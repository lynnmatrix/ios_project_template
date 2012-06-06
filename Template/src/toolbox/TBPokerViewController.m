//
//  TBPokerViewController.m
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerViewController.h"
#import "TBPokerViewDelegate.h"
#import "TBPokerViewDataSource.h"
#import "DefaultCSSStyleSheet.h"
#import "TBPokerViewCell.h"

@interface TBPokerViewController ()

@end

@implementation TBPokerViewController
@synthesize pokerView= _pokerView;
@synthesize pokerBannerView =_pokerBannerView;
@synthesize pokerOverlayView = _pokerOverlayView;
@synthesize loadingView = _loadingView;
@synthesize errorView = _errorView;
@synthesize emptyView = _emptyView;
@synthesize menuView = _menuView;
@synthesize variableHeightRows =_variableHeightRows;
@synthesize showPokerShadows =_showPokerShadows;
@synthesize clearsSelectionOnViewWillAppear  = _clearsSelectionOnViewWillAppear;
@synthesize dataSource =_dataSource;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _lastInterfaceOrientation = self.interfaceOrientation;
        _clearsSelectionOnViewWillAppear = YES;
    }
    return self;
}

- (void) dealloc{
    _pokerView.delegate = nil;
    _pokerView.dataSource = nil;

    TT_RELEASE_SAFELY(_dataSource);
    TT_RELEASE_SAFELY(_pokerDelegate);
    TT_RELEASE_SAFELY(_pokerView);
    TT_RELEASE_SAFELY(_loadingView);
    TT_RELEASE_SAFELY(_errorView);
    TT_RELEASE_SAFELY(_emptyView);
    TT_RELEASE_SAFELY(_pokerOverlayView);
    TT_RELEASE_SAFELY(_pokerBannerView);
    
    [super dealloc];
}

#pragma mark -
#pragma mark private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createInterstitialModel {
    self.dataSource = [[[TBPokerViewInterstitialDataSource alloc] init] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)defaultTitleForLoading {
    return TTLocalizedString(@"Loading...", @"");
}

- (void)updatePokerDelegate {
    if (!_pokerView.delegate) {
        [_pokerDelegate release];
        _pokerDelegate = [[self createDelegate] retain];
        
        // You need to set it to nil before changing it or it won't have any effect
        _pokerView.delegate = nil;
        _pokerView.delegate = _pokerDelegate;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addToOverlayView:(UIView*)view {
    if (!_pokerOverlayView) {
        CGRect frame = [self rectForOverlayView];
        _pokerOverlayView = [[UIView alloc] initWithFrame:frame];
        _pokerOverlayView.autoresizesSubviews = YES;
        _pokerOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        NSInteger pokerIndex = [_pokerView.superview.subviews indexOfObject:_pokerView];
        if (pokerIndex != NSNotFound) {
            [_pokerView.superview addSubview:_pokerOverlayView];
        }
    }
    
    view.frame = _pokerOverlayView.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_pokerOverlayView addSubview:view];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetOverlayView {
    if (_pokerOverlayView && !_pokerOverlayView.subviews.count) {
        [_pokerOverlayView removeFromSuperview];
        TT_RELEASE_SAFELY(_pokerOverlayView);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addSubviewOverPokerView:(UIView*)view {
    NSInteger pokerIndex = [_pokerView.superview.subviews
                            indexOfObject:_pokerView];
    if (NSNotFound != pokerIndex) {
        [_pokerView.superview addSubview:view];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutOverlayView {
    if (_pokerOverlayView) {
        _pokerOverlayView.frame = [self rectForOverlayView];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutBannerView {
    if (_pokerBannerView) {
        _pokerBannerView.frame = [self rectForBannerView];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadeOutView:(UIView*)view {
    [view retain];
    [UIView beginAnimations:nil context:view];
    [UIView setAnimationDuration:TT_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadingOutViewDidStop:finished:context:)];
    view.alpha = 0;
    [UIView commitAnimations];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadingOutViewDidStop:(NSString*)animationID finished:(NSNumber*)finished
                     context:(void*)context {
    UIView* view = (UIView*)context;
    [view removeFromSuperview];
    [view release];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)hideMenuAnimationDidStop:(NSString*)animationID finished:(NSNumber*)finished
                         context:(void*)context {
    UIView* menuView = (UIView*)context;
    [menuView removeFromSuperview];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    [self pokerView];
    
    // If this view was unloaded and is now being reloaded, and it was previously
    // showing a poker banner, then redisplay that banner now.
    if (_pokerBannerView) {
        UIView* savedPokerBannerView = [_pokerBannerView retain];
        [self setPokerBannerView:nil animated:NO];
        [self setPokerBannerView:savedPokerBannerView animated:NO];
        [savedPokerBannerView release];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    _pokerView.delegate = nil;
    _pokerView.dataSource = nil;
    TT_RELEASE_SAFELY(_pokerDelegate);
    TT_RELEASE_SAFELY(_pokerView);
    [_pokerOverlayView removeFromSuperview];
    TT_RELEASE_SAFELY(_pokerOverlayView);
    [_loadingView removeFromSuperview];
    TT_RELEASE_SAFELY(_loadingView);
    [_errorView removeFromSuperview];
    TT_RELEASE_SAFELY(_errorView);
    [_emptyView removeFromSuperview];
    TT_RELEASE_SAFELY(_emptyView);
    [_menuView removeFromSuperview];
    TT_RELEASE_SAFELY(_menuView);
    [_menuCell removeFromSuperview];
    TT_RELEASE_SAFELY(_menuCell);
    
    // Do not release _pokerBannerView, because we have no way to recreate it on demand if
    // this view gets reloaded.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_lastInterfaceOrientation != self.interfaceOrientation) {
        _lastInterfaceOrientation = self.interfaceOrientation;
        [_pokerView reloadData];
        
    }
//    else if ([_pokerView isKindOfClass:[TBPokerView class]]) {
//        TBPokerView* pokerView = (TBPokerView*)_pokerView;
//        pokerView.highlightedLabel = nil;
//        pokerView.showShadows = _showPokerShadows;
//    }
//    
//    if (_clearsSelectionOnViewWillAppear) {
//        [_pokerView deselectRowAtIndexPath:[_pokerView indexPathForSelectedRow] animated:animated];
//    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_flags.isShowingModel) {
        [_pokerView flashScrollIndicators];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideMenu:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.pokerView setEditing:editing animated:animated];
//}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UTViewController (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)persistView:(NSMutableDictionary*)state {
    CGFloat scrollY = _pokerView.contentOffset.y;
    [state setObject:[NSNumber numberWithFloat:scrollY] forKey:@"scrollOffsetY"];
    return [super persistView:state];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)restoreView:(NSDictionary*)state {
    CGFloat scrollY = [[state objectForKey:@"scrollOffsetY"] floatValue];
    if (scrollY) {
        //set to 0 if contentSize is smaller than the pokerView.height
        CGFloat maxY = MAX(0, _pokerView.contentSize.height - _pokerView.height);
        if (scrollY <= maxY) {
            _pokerView.contentOffset = CGPointMake(0, scrollY);
            
        } else {
            _pokerView.contentOffset = CGPointMake(0, maxY);
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardDidAppear:animated withBounds:bounds];
    self.pokerView.frame = TTRectContract(self.pokerView.frame, 0, bounds.size.height);
//    [self.pokerView scrollFirstResponderIntoView];
    [self layoutOverlayView];
    [self layoutBannerView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardWillDisappear:animated withBounds:bounds];
    
    // If we do this when there is currently no poker view, we can get into a weird loop where the
    // poker view gets doubly-initialized. self.pokerView will try to initialize it; this will call
    // self.view, which will call -loadView, which often calls self.pokerView, which initializes it.
    if (_pokerView) {
        CGRect previousFrame = self.pokerView.frame;
        self.pokerView.frame = TTRectContract(self.pokerView.frame, 0, -bounds.size.height);
        
        // There's any number of edge cases wherein a poker view controller will get this callback but
        // it shouldn't resize itself -- e.g. when a controller has the keyboard up, and then drills
        // down into this controller. This is a sanity check to avoid situations where the poker
        // extends way off the bottom of the screen and becomes unusable.
        if (self.pokerView.height > self.view.bounds.size.height) {
            self.pokerView.frame = previousFrame;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds {
    [super keyboardDidDisappear:animated withBounds:bounds];
    [self layoutOverlayView];
    [self layoutBannerView];
}

#pragma mark -
#pragma mark TTModelViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canShowModel {

    NSInteger numberOfRows = [_dataSource numberOfViewsInPokerView:_pokerView];
    return numberOfRows > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadModel:(BOOL)firstTime {
    [super didLoadModel:firstTime];
    [_dataSource pokerViewDidLoadModel:_pokerView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didShowModel:(BOOL)firstTime {
    [super didShowModel:firstTime];
    if (![self isViewAppearing] && firstTime) {
        [_pokerView flashScrollIndicators];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show {
    [self hideMenu:YES];
    if (show) {
        [self updatePokerDelegate];
        _pokerView.dataSource = _dataSource;
        
    } else {
        _pokerView.dataSource = nil;
    }
    [_pokerView reloadData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)show {
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
            NSString* title = _dataSource
            ? [_dataSource titleForLoading:NO]
            : [self defaultTitleForLoading];
            if (title.length) {
                TTActivityLabel* label =
                [[[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhiteBox]
                 autorelease];
                label.text = title;
                label.backgroundColor = _pokerView.backgroundColor;
                self.loadingView = label;
            }
        }
        
    } else {
        self.loadingView = nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showError:(BOOL)show {
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
            NSString* title = [_dataSource titleForError:_modelError];
            NSString* subtitle = [_dataSource subtitleForError:_modelError];
            UIImage* image = [_dataSource imageForError:_modelError];
            if (title.length || subtitle.length || image) {
                TTErrorView* errorView = [[[TTErrorView alloc] initWithTitle:title
                                                                    subtitle:subtitle
                                                                       image:image] autorelease];
                if ([_dataSource reloadButtonForEmpty]) {
                    [errorView addReloadButton];
                    [errorView.reloadButton addTarget:self
                                               action:@selector(reload)
                                     forControlEvents:UIControlEventTouchUpInside];
                }
                errorView.backgroundColor = _pokerView.backgroundColor;
                
                self.errorView = errorView;
                
            } else {
                self.errorView = nil;
            }
            _pokerView.dataSource = nil;
            [_pokerView reloadData];
        }
        
    } else {
        self.errorView = nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showEmpty:(BOOL)show {
    if (show) {
        NSString* title = [_dataSource titleForEmpty];
        NSString* subtitle = [_dataSource subtitleForEmpty];
        UIImage* image = [_dataSource imageForEmpty];
        if (title.length || subtitle.length || image) {
            TTErrorView* errorView = [[[TTErrorView alloc] initWithTitle:title
                                                                subtitle:subtitle
                                                                   image:image] autorelease];
            errorView.backgroundColor = _pokerView.backgroundColor;
            self.emptyView = errorView;
            
        } else {
            self.emptyView = nil;
        }
        _pokerView.dataSource = nil;
        [_pokerView reloadData];
        
    } else {
        self.emptyView = nil;
    }
}


#pragma mark -
#pragma mark  public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TBPokerView*)pokerView {
    if (nil == _pokerView) {
        _pokerView = [[TBPokerView alloc] initWithFrame:self.view.bounds];
        _pokerView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        

        UIColor* backgroundColor = STYLEVAR(pokerViewBackgroundColor);
        if (backgroundColor) {
            _pokerView.backgroundColor = backgroundColor;
            self.view.backgroundColor = backgroundColor;
        }
        [self.view addSubview:_pokerView];
    }
    return _pokerView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPokerView:(TBPokerView*)pokerView {
    if (pokerView != _pokerView) {
        [_pokerView release];
        _pokerView = [pokerView retain];
        if (!_pokerView) {
            self.pokerBannerView = nil;
            self.pokerOverlayView = nil;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPokerBannerView:(UIView*)pokerBannerView {
    [self setPokerBannerView:pokerBannerView animated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPokerBannerView:(UIView*)pokerBannerView animated:(BOOL)animated {
    if (pokerBannerView != _pokerBannerView) {
        if (_pokerBannerView) {
            if (animated) {
                [self fadeOutView:_pokerBannerView];
                
            } else {
                [_pokerBannerView removeFromSuperview];
            }
        }
        
        [_pokerBannerView release];
        _pokerBannerView = [pokerBannerView retain];
        
        if (_pokerBannerView) {
            self.pokerView.contentInset = UIEdgeInsetsMake(0, 0, TTSTYLEVAR(tableBannerViewHeight), 0);
            self.pokerView.scrollIndicatorInsets = self.pokerView.contentInset;
            _pokerBannerView.frame = [self rectForBannerView];
            _pokerBannerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                                 | UIViewAutoresizingFlexibleTopMargin);
            [self addSubviewOverPokerView:_pokerBannerView];
            
            
            if (animated) {
                _pokerBannerView.top += TTSTYLEVAR(tableBannerViewHeight);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:TT_TRANSITION_DURATION];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                _pokerBannerView.top -= TTSTYLEVAR(tableBannerViewHeight);
                [UIView commitAnimations];
            }
            
        } else {
            self.pokerView.contentInset = UIEdgeInsetsZero;
            self.pokerView.scrollIndicatorInsets = UIEdgeInsetsZero;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPokerOverlayView:(UIView*)pokerOverlayView animated:(BOOL)animated {
    if (pokerOverlayView != _pokerOverlayView) {
        if (_pokerOverlayView) {
            if (animated) {
                [self fadeOutView:_pokerOverlayView];
                
            } else {
                [_pokerOverlayView removeFromSuperview];
            }
        }
        
        [_pokerOverlayView release];
        _pokerOverlayView = [pokerOverlayView retain];
        
        if (_pokerOverlayView) {
            _pokerOverlayView.frame = [self rectForOverlayView];
            [self addToOverlayView:_pokerOverlayView];
        }
        
        // XXXjoe There seem to be cases where this gets left disable - must investigate
        //_pokerView.scrollEnabled = !_pokerOverlayView;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<TBPokerViewDataSource>)dataSource {
    if (dataSource != _dataSource) {
        [_dataSource release];
        _dataSource = [dataSource retain];
        _pokerView.dataSource = nil;
        
        self.model = dataSource.model;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setVariableHeightRows:(BOOL)variableHeightRows {
    if (variableHeightRows != _variableHeightRows) {
        _variableHeightRows = variableHeightRows;
        
        // Force the delegate to be re-created so that it supports the right kind of row measurement
        _pokerView.delegate = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLoadingView:(UIView*)view {
    if (view != _loadingView) {
        if (_loadingView) {
            [_loadingView removeFromSuperview];
            TT_RELEASE_SAFELY(_loadingView);
        }
        _loadingView = [view retain];
        if (_loadingView) {
            [self addToOverlayView:_loadingView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setErrorView:(UIView*)view {
    if (view != _errorView) {
        if (_errorView) {
            [_errorView removeFromSuperview];
            TT_RELEASE_SAFELY(_errorView);
        }
        _errorView = [view retain];
        
        if (_errorView) {
            [self addToOverlayView:_errorView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEmptyView:(UIView*)view {
    if (view != _emptyView) {
        if (_emptyView) {
            [_emptyView removeFromSuperview];
            TT_RELEASE_SAFELY(_emptyView);
        }
        _emptyView = [view retain];
        if (_emptyView) {
            [self addToOverlayView:_emptyView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


- (id<TBPokerViewDelegate>)createDelegate{
    return [[[TBPokerViewDelegate alloc] initWithController:self] autorelease];
    //    if (_variableHeightRows) {
    //        return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
    //        
    //    } else {
    //        return [[[TTTableViewDelegate alloc] initWithController:self] autorelease];
    //    }
}


- (void)showMenu:(UIView*)view forCell:(TBPokerViewCell*)cell animated:(BOOL)animated {
    [self hideMenu:YES];
    
    _menuView = [view retain];
    _menuCell = [cell retain];
    
    // Insert the cell below all content subviews
    [_menuCell insertSubview:_menuView atIndex:0];
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:TT_FAST_TRANSITION_DURATION];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    }
    
    // Move each content subview down, revealing the menu
    for (UIView* subview in [_menuCell subviews] ) {
        if (subview != _menuView) {
            subview.left -= _menuCell.width;
        }
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)hideMenu:(BOOL)animated {
    if (_menuView) {
        if (animated) {
            [UIView beginAnimations:nil context:_menuView];
            [UIView setAnimationDuration:TT_FAST_TRANSITION_DURATION];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(hideMenuAnimationDidStop:finished:context:)];
        }
        
        for (UIView* view in _menuCell.subviews) {
            if (view != _menuView) {
                view.left += _menuCell.width;
            }
        }
        
        if (animated) {
            [UIView commitAnimations];
            
        } else {
            [_menuView removeFromSuperview];
        }
        
        TT_RELEASE_SAFELY(_menuView);
        TT_RELEASE_SAFELY(_menuCell);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndex:(NSInteger)index {
    if ([object respondsToSelector:@selector(URLValue)]) {
        NSString* URL = [object URLValue];
        if (URL) {
            TTOpenURLFromView(URL, self.view);
        }
    }
}

- (BOOL)shouldOpenURL:(NSString*)URL{
    return YES;
}


- (void)didBeginDragging{

  [self hideMenu:YES];
}


- (void)didEndDragging{}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)rectForOverlayView {
    return [_pokerView frameWithKeyboardSubtracted:0];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)rectForBannerView {
    CGRect pokerFrame = [_pokerView frameWithKeyboardSubtracted:0];
    const CGFloat bannerViewHeight = TTSTYLEVAR(tableBannerViewHeight);
    return CGRectMake(pokerFrame.origin.x,
                      (pokerFrame.origin.y + pokerFrame.size.height) - bannerViewHeight,
                      pokerFrame.size.width, bannerViewHeight);
}



- (void)invalidateModel {
    [super invalidateModel];
    
    // Renew the pokerView delegate when the model is refreshed.
    // Otherwise the delegate will be retained the model.
    
    // You need to set it to nil before changing it or it won't have any effect
    _pokerView.delegate = nil;
    [self updatePokerDelegate];
}

@end
