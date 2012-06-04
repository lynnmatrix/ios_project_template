//
//  TBPokerViewController.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import "TBPokerView.h"

@interface TBPokerViewController : TTModelViewController {
    TBPokerView*  _pokerView;
//    UIView*       _pokerBannerView;
//    UIView*       _pokerOverlayView;
//    UIView*       _loadingView;
//    UIView*       _errorView;
//    UIView*       _emptyView;
//    
//    UIView*           _menuView;
//    TBPokerViewCell*  _menuCell;
//    
//    UIInterfaceOrientation  _lastInterfaceOrientation;
    
    BOOL _variableHeightRows;
//    BOOL _showPokerShadows;
//    BOOL _clearsSelectionOnViewWillAppear;
    
    id<TBPokerViewDataSource> _dataSource;
    id<TBPokerViewDelegate>   _pokerDelegate;
}

@property (nonatomic, retain) TBPokerView* pokerView;

///**
// * A view that is displayed as a banner at the bottom of the poker view.
// */
//@property (nonatomic, retain) UIView* pokerBannerView;
//
///**
// * A view that is displayed over the poker view.
// */
//@property (nonatomic, retain) UIView* pokerOverlayView;
//
//@property (nonatomic, retain) UIView* loadingView;
//@property (nonatomic, retain) UIView* errorView;
//@property (nonatomic, retain) UIView* emptyView;
//
//@property (nonatomic, readonly) UIView* menuView;

/**
 * The data source used to populate the poker view.
 *
 * Setting dataSource has the side effect of also setting model to the value of the
 * dataSource's model property.
 */
@property (nonatomic, retain) id<TBPokerViewDataSource> dataSource;

/**
 * Indicates if the poker should support non-fixed row heights.
 */
@property (nonatomic) BOOL variableHeightRows;

/**
 * Creates an delegate for the poker view.
 *
 * Subclasses can override this to provide their own poker delegate implementation.
 */
- (id<TBPokerViewDelegate>)createDelegate;



///**
// * When enabled, draws gutter shadows above the first poker item and below the last poker item.
// *
// * Known issues: When there aren't enough cell items to fill the screen, the poker view draws
// * empty cells for the remaining space. This causes the bottom shadow to appear out of place.
// */
//@property (nonatomic) BOOL showPokerShadows;
//
///**
// * A Boolean value indicating if the controller clears the selection when the poker appears.
// * Default is YES.
// */
//@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;




///**
// * Sets the view that is displayed at the bottom of the poker view with an optional animation.
// */
//- (void)setPokerBannerView:(UIView*)pokerBannerView animated:(BOOL)animated;
//
///**
// * Shows a menu over a poker cell.
// */
//- (void)showMenu:(UIView*)view forCell:(TBPokerViewCell*)cell animated:(BOOL)animated;
//
///**
// * Hides the currently visible poker cell menu.
// */
//- (void)hideMenu:(BOOL)animated;

///**
// * Tells the controller that the user selected an object in the poker.
// *
// * By default, the object's URLValue will be opened in TTNavigator, if it has one. If you don't
// * want this to be happen, be sure to override this method and be sure not to call super.
// */
//- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Asks if a URL from that user touched in the poker should be opened.
 */
- (BOOL)shouldOpenURL:(NSString*)URL;

/**
 * Tells the controller that the user began dragging the poker view.
 */
- (void)didBeginDragging;

/**
 * Tells the controller that the user stopped dragging the poker view.
 */
- (void)didEndDragging;

///**
// * The rectangle where the overlay view should appear.
// */
//- (CGRect)rectForOverlayView;
//
///**
// * The rectangle where the banner view should appear.
// */
//- (CGRect)rectForBannerView;

@end
