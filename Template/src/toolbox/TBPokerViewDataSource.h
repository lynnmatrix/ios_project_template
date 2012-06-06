//
//  TBPokerViewDataSource.h
//  Template
//
//  Created by Lin Yiming on 6/4/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBPokerView;
@class TBPokerViewCell;

@protocol TBPokerViewDataSource <NSObject,TTModel>

@required
@property (nonatomic, retain) id<TTModel> model;

- (NSInteger)numberOfViewsInPokerView:(TBPokerView *)pokerView;
- (TBPokerViewCell *)pokerView:(TBPokerView *)pokerView viewAtIndex:(NSInteger)index;
- (id)pokerView:(TBPokerView*)pokerView objectForRowAtIndex:(NSInteger)index;
- (CGFloat)pokerView:(TBPokerView*) pokerView heightForViewAtIndex:(NSInteger)index;

- (Class)pokerView:(TBPokerView*)pokerView cellClassForObject:(id)object;


/**
 * Informs the data source that its model loaded.
 *
 * That would be a good time to prepare the freshly loaded data for use in the table view.
 */
- (void)pokerViewDidLoadModel:(TBPokerView*)pokerView;

- (NSString*)titleForLoading:(BOOL)reloading;

- (UIImage*)imageForEmpty;

- (NSString*)titleForEmpty;

- (NSString*)subtitleForEmpty;



/**
 * return YES to include a reload button in the TTErrorView.
 */
- (BOOL)reloadButtonForEmpty;

- (UIImage*)imageForError:(NSError*)error;

- (NSString*)titleForError:(NSError*)error;

- (NSString*)subtitleForError:(NSError*)error;
@end


@interface TBPokerViewDataSource : NSObject <TBPokerViewDataSource> {
    id<TTModel>       _model;
    NSMutableArray*   _items;
}

@property (nonatomic, retain) NSMutableArray* items;

+ (TBPokerViewDataSource*)dataSourceWithObjects:(id)object,...;
+ (TBPokerViewDataSource*)dataSourceWithItems:(NSMutableArray*)items;

- (id)initWithItems:(NSArray*)items;

- (NSIndexPath*)indexPathOfItemWithUserInfo:(id)userInfo;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * A datasource that is eternally loading.  Useful when you are in between data sources and
 * want to show the impression of loading until your actual data source is available.
 */
@interface TBPokerViewInterstitialDataSource : TBPokerViewDataSource <TTModel>
@end