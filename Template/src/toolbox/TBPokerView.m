//
//  TBPokerView.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerView.h"
#import "TBPokerViewCell.h"
#import "TBPokerViewDataSource.h"
#import "TBPokerViewDelegate.h"

static inline NSString * TBPokerKeyForIndex(NSInteger index) {
    return [NSString stringWithFormat:@"%d", index];
}

static inline NSInteger TBPokerIndexForKey(NSString *key) {
    return [key integerValue];
}
#pragma mark - Gesture Recognizer

// This is just so we know that we sent this tap gesture recognizer in the delegate
@interface TBPokerViewTapGestureRecognizer : UITapGestureRecognizer
@end

@implementation TBPokerViewTapGestureRecognizer
@end


@interface TBPokerView () <UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) CGFloat colWidth;
@property (nonatomic, assign, readwrite) NSInteger numCols;
@property (nonatomic, assign) UIInterfaceOrientation orientation;

@property (nonatomic, retain) NSMutableSet *reuseableViews;
@property (nonatomic, retain) NSMutableDictionary *visibleViews;
@property (nonatomic, retain) NSMutableArray *viewKeysToRemove;
@property (nonatomic, retain) NSMutableDictionary *indexToRectMap;


/**
 Forces a relayout of the collection grid
 */
- (void)relayoutViews;

/**
 Stores a view for later reuse
 TODO: add an identifier like UITableView
 */
- (void)enqueueReusableView:(TBPokerViewCell *)view;

/**
 Magic!
 */
- (void)removeAndAddCellsIfNecessary;

@end


@implementation TBPokerView

// Public Views
@synthesize
headerView = _headerView,
footerView = _footerView,
emptyView = _emptyView,
loadingView = _loadingView;

// Public
@synthesize
colWidth = _colWidth,
numCols = _numCols,
numColsLandscape = _numColsLandscape,
numColsPortrait = _numColsPortrait,
pokerViewDelegate = _pokerViewDelegate,
dataSource = _dataSource;

// Private
@synthesize
orientation = _orientation,
reuseableViews = _reuseableViews,
visibleViews = _visibleViews,
viewKeysToRemove = _viewKeysToRemove,
indexToRectMap = _indexToRectMap;

#pragma mark - Init/Memory

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alwaysBounceVertical = YES;
        
        self.colWidth = 0.0;
        self.numCols = 0;
        self.numColsPortrait = 0;
        self.numColsLandscape = 0;
        self.orientation = [UIApplication sharedApplication].statusBarOrientation;
        
        self.reuseableViews = [NSMutableSet set];
        self.visibleViews = [NSMutableDictionary dictionary];
        self.viewKeysToRemove = [NSMutableArray array];
        self.indexToRectMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    // clear delegates
    self.delegate = nil;
    self.dataSource = nil;
    self.pokerViewDelegate = nil;
    
    // release retains
    self.headerView = nil;
    self.footerView = nil;
    self.emptyView = nil;
    self.loadingView = nil;
    
    self.reuseableViews = nil;
    self.visibleViews = nil;
    self.viewKeysToRemove = nil;
    self.indexToRectMap = nil;
    [super dealloc];
}

#pragma mark - Setters

- (void)setLoadingView:(UIView *)loadingView {
    if (_loadingView && [_loadingView respondsToSelector:@selector(removeFromSuperview)]) {
        [_loadingView removeFromSuperview];
    }
    [_loadingView release], _loadingView = nil;
    _loadingView = [loadingView retain];
    
    [self addSubview:_loadingView];
}

- (void) setPokerViewDelegate:(id<TBPokerViewDelegate>) pokerViewDelegate{
    _pokerViewDelegate = pokerViewDelegate;
    self.delegate = self.pokerViewDelegate;
}
#pragma mark - DataSource

- (void)reloadData {
    [self relayoutViews];
}

#pragma mark - View

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (self.orientation != orientation) {
        self.orientation = orientation;
        [self relayoutViews];
    } else {
        [self removeAndAddCellsIfNecessary];
    }
}

- (void)relayoutViews {
    self.numCols = UIInterfaceOrientationIsPortrait(self.orientation) ? self.numColsPortrait : self.numColsLandscape;
    
    // Reset all state
    [self.visibleViews enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        TBPokerViewCell *view = (TBPokerViewCell *)obj;
        [self enqueueReusableView:view];
    }];
    [self.visibleViews removeAllObjects];
    [self.viewKeysToRemove removeAllObjects];
    [self.indexToRectMap removeAllObjects];
    
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
    }
    [self.loadingView removeFromSuperview];
    
    // This is where we should layout the entire grid first
    NSInteger numViews = [self.dataSource numberOfViewsInPokerView:self];
    
    CGFloat totalHeight = 0.0;
    CGFloat top = kTableCellSmallMargin;
    
    // Add headerView if it exists
    if (self.headerView) {
        self.headerView.top = kTableCellSmallMargin;
        top = self.headerView.top;
        [self addSubview:self.headerView];
        top += self.headerView.height;
        top += kTableCellSmallMargin;
    }
    
    if (numViews > 0) {
        // This array determines the last height offset on a column
        NSMutableArray *colOffsets = [NSMutableArray arrayWithCapacity:self.numCols];
        for (int i = 0; i < self.numCols; i++) {
            [colOffsets addObject:[NSNumber numberWithFloat:top]];
        }
        
        // Calculate index to rect mapping
        self.colWidth = floorf((self.width - kTableCellSmallMargin * (self.numCols + 1)) / self.numCols);
        for (NSInteger i = 0; i < numViews; i++) {
            NSString *key = TBPokerKeyForIndex(i);
            
            // Find the shortest column
            NSInteger col = 0;
            CGFloat minHeight = [[colOffsets objectAtIndex:col] floatValue];
            for (int i = 1; i < [colOffsets count]; i++) {
                CGFloat colHeight = [[colOffsets objectAtIndex:i] floatValue];
                
                if (colHeight < minHeight) {
                    col = i;
                    minHeight = colHeight;
                }
            }
            
            CGFloat left = kTableCellSmallMargin + (col * kTableCellSmallMargin) + (col * self.colWidth);
            CGFloat top = [[colOffsets objectAtIndex:col] floatValue];
            CGFloat colHeight = [self.dataSource pokerView:self heightForViewAtIndex:i];
            if (colHeight == 0) {
                colHeight = self.colWidth;
            }
            
            if (top != top) {
                // NaN
            }
            
            CGRect viewRect = CGRectMake(left, top, self.colWidth, colHeight);
            
            // Add to index rect map
            [self.indexToRectMap setObject:NSStringFromCGRect(viewRect) forKey:key];
            
            // Update the last height offset for this column
            CGFloat test = top + colHeight + kTableCellSmallMargin;
            
            if (test != test) {
                // NaN
            }
            [colOffsets replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:test]];
        }
        
        for (NSNumber *colHeight in colOffsets) {
            totalHeight = (totalHeight < [colHeight floatValue]) ? [colHeight floatValue] : totalHeight;
        }
    } else {
        totalHeight = self.height;
        
        // If we have an empty view, show it
        if (self.emptyView) {
            self.emptyView.frame = CGRectMake(kTableCellSmallMargin, top, self.width - kTableCellSmallMargin * 2, self.height - top - kTableCellSmallMargin);
            [self addSubview:self.emptyView];
        }
    }
    
    // Add footerView if exists
    if (self.footerView) {
        self.footerView.top = totalHeight;
        [self addSubview:self.footerView];
        totalHeight += self.footerView.height;
        totalHeight += kTableCellSmallMargin;
    }
    
    self.contentSize = CGSizeMake(self.width, totalHeight);
    
    [self removeAndAddCellsIfNecessary];
}

- (void)removeAndAddCellsIfNecessary {
    static NSInteger bufferViewFactor = 5;
    static NSInteger topIndex = 0;
    static NSInteger bottomIndex = 0;
    
    NSInteger numViews = [self.dataSource numberOfViewsInPokerView:self];
    
    if (numViews == 0) return;
    
    // Find out what rows are visible
    CGRect visibleRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.width, self.height);
    
    // Remove all rows that are not inside the visible rect
    [self.visibleViews enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        TBPokerViewCell *view = (TBPokerViewCell *)obj;
        CGRect viewRect = view.frame;
        if (!CGRectIntersectsRect(visibleRect, viewRect)) {
            [self enqueueReusableView:view];
            [self.viewKeysToRemove addObject:key];
        }
    }];
    
    [self.visibleViews removeObjectsForKeys:self.viewKeysToRemove];
    [self.viewKeysToRemove removeAllObjects];
    
    if ([self.visibleViews count] == 0) {
        topIndex = 0;
        bottomIndex = numViews;
    } else {
        NSArray *sortedKeys = [[self.visibleViews allKeys] sortedArrayUsingComparator:^(id obj1, id obj2) {
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        topIndex = [[sortedKeys objectAtIndex:0] integerValue];
        bottomIndex = [[sortedKeys lastObject] integerValue];
        
        topIndex = MAX(0, topIndex - (bufferViewFactor * self.numCols));
        bottomIndex = MIN(numViews, bottomIndex + (bufferViewFactor * self.numCols));
    }
    //    NSLog(@"topIndex: %d, bottomIndex: %d", topIndex, bottomIndex);
    
    // Add views
    for (NSInteger i = topIndex; i < bottomIndex; i++) {
        NSString *key = TBPokerKeyForIndex(i);
        CGRect rect = CGRectFromString([self.indexToRectMap objectForKey:key]);
        
        // If view is within visible rect and is not already shown
        if (![self.visibleViews objectForKey:key] && CGRectIntersectsRect(visibleRect, rect)) {
            // Only add views if not visible
            TBPokerViewCell *newView = [self.dataSource pokerView:self viewAtIndex:i];
            newView.frame = CGRectFromString([self.indexToRectMap objectForKey:key]);
            [self addSubview:newView];
            
            // Setup gesture recognizer
            if ([newView.gestureRecognizers count] == 0) {
                TBPokerViewTapGestureRecognizer *gr = [[[TBPokerViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectView:)] autorelease];
                gr.delegate = self;
                [newView addGestureRecognizer:gr];
                newView.userInteractionEnabled = YES;
            }
            
            [self.visibleViews setObject:newView forKey:key];
        }
    }
}

#pragma mark - Reusing Views

- (UIView *)dequeueReusableCellWithIdentifier:(NSString*) identifier; {
    TBPokerViewCell *view = [self.reuseableViews anyObject];
    if (view) {
        // Found a reusable view, remove it from the set
        [view retain];
        [self.reuseableViews removeObject:view];
        [view autorelease];
    }
    
    return view;
}

- (void)enqueueReusableView:(TBPokerViewCell *)view {
    if ([view respondsToSelector:@selector(prepareForReuse)]) {
        [view performSelector:@selector(prepareForReuse)];
    }
    view.frame = CGRectZero;
    [self.reuseableViews addObject:view];
    [view removeFromSuperview];
}

#pragma mark - Gesture Recognizer

- (void)didSelectView:(UITapGestureRecognizer *)gestureRecognizer {    
    NSString *rectString = NSStringFromCGRect(gestureRecognizer.view.frame);
    NSArray *matchingKeys = [self.indexToRectMap allKeysForObject:rectString];
    NSString *key = [matchingKeys lastObject];
    if ([gestureRecognizer.view isMemberOfClass:[[self.visibleViews objectForKey:key] class]]) {
        if (self.pokerViewDelegate && [self.pokerViewDelegate respondsToSelector:@selector(pokerView:didSelectView:atIndex:)]) {
            NSInteger matchingIndex = TBPokerIndexForKey([matchingKeys lastObject]);
            [self.pokerViewDelegate pokerView:self didSelectView:(TBPokerViewCell *)gestureRecognizer.view atIndex:matchingIndex];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (![gestureRecognizer isMemberOfClass:[TBPokerViewTapGestureRecognizer class]]) return YES;
    
    NSString *rectString = NSStringFromCGRect(gestureRecognizer.view.frame);
    NSArray *matchingKeys = [self.indexToRectMap allKeysForObject:rectString];
    NSString *key = [matchingKeys lastObject];
    
    if ([touch.view isMemberOfClass:[[self.visibleViews objectForKey:key] class]]) {
        return YES;
    } else {
        return NO;
    }
}
    
@end
