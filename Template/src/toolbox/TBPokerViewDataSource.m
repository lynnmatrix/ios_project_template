//
//  TBPokerViewDataSource.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerViewDataSource.h"
#import "TBPokerView.h"
#import "TBPokerViewCell.h"

#import <objc/runtime.h>

@implementation TBPokerViewDataSource
@synthesize model =_model;
@synthesize items = _items;

- (void) dealloc{
    TT_RELEASE_SAFELY(_model);
    TT_RELEASE_SAFELY(_items);
    [super dealloc];
}

- (id)initWithItems:(NSArray*)items {
	self = [self init];
    if (self) {
        _items = [items mutableCopy];
    }
    
    return self;
}

#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TBPokerViewDataSource*)dataSourceWithObjects:(id)object,... {
    NSMutableArray* items = [NSMutableArray array];
    va_list ap;
    va_start(ap, object);
    while (object) {
        [items addObject:object];
        object = va_arg(ap, id);
    }
    va_end(ap);
    
    return [[[self alloc] initWithItems:items] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TBPokerViewDataSource*)dataSourceWithItems:(NSMutableArray*)items {
    return [[[self alloc] initWithItems:items] autorelease];
}

#pragma mark -
#pragma mark TTModel


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)delegates {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
}

#pragma mark -
#pragma mark TBPokerViewDataSource

- (NSInteger)numberOfViewsInPokerView:(TBPokerView *)pokerView{
  return _items.count;
}

- (TBPokerViewCell *)pokerView:(TBPokerView *)pokerView viewAtIndex:(NSInteger)index{
    id object = [self pokerView:pokerView objectForRowAtIndex:index];
    
    Class cellClass = [self pokerView:pokerView cellClassForObject:object];
    const char* className = class_getName(cellClass);
    NSString* identifier = [[NSString alloc] initWithBytesNoCopy:(char*)className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    TBPokerViewCell* cell =
    (TBPokerViewCell*)[pokerView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[cellClass alloc] initWithReuseIdentifier:identifier] autorelease];
    }
    [identifier release];
    
    [(TBPokerViewCell*)cell setObject:object];
    
    return cell;
}

- (CGFloat)pokerView:(TBPokerView*) pokerView heightForViewAtIndex:(NSInteger)index{
    id object = [self.items objectAtIndex:index];
    Class cellClass = [self pokerView:pokerView cellClassForObject:object];

    return [cellClass heightForViewWithObject:object inColumnWidth:pokerView.colWidth];;
}


- (id)pokerView:(TBPokerView*)pokerView objectForRowAtIndex:(NSInteger) index{
    if (index< _items.count) {
        return [_items objectAtIndex:index];
    } else {
        return nil;
    }
}

- (id<TTModel>)model {
    return _model ? _model : self;
}


- (Class)pokerView:(TBPokerView*)pokerView cellClassForObject:(id)object{
    return [TBPokerViewCell class];
}


#pragma mark -
#pragma mark network related text and images setting 

- (void)pokerViewDidLoadModel:(TBPokerView*)pokerView{

}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return TTLocalizedString(@"Updating...", @"");
        
    } else {
        return TTLocalizedString(@"Loading...", @"");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForEmpty {
    return [self imageForError:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)reloadButtonForEmpty {
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForError:(NSError*)error {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForError:(NSError*)error {
    return TTDescriptionForError(error);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return TTLocalizedString(@"Sorry, there was an error.", @"");
}

#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)indexPathOfItemWithUserInfo:(id)userInfo {
    for (NSInteger i = 0; i < _items.count; ++i) {
        TTTableItem* item = [_items objectAtIndex:i];
        if (item.userInfo == userInfo) {
            return [NSIndexPath indexPathForRow:i inSection:0];
        }
    }
    return nil;
}

@end
