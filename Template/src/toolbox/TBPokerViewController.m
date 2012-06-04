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

@interface TBPokerViewController ()

@end

@implementation TBPokerViewController
@synthesize pokerView= _pokerView;
@synthesize variableHeightRows =_variableHeightRows;
@synthesize dataSource =_dataSource;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void) dealloc{

    TT_RELEASE_SAFELY(_pokerView);
    TT_RELEASE_SAFELY(_dataSource);
    
    [super dealloc];
}

#pragma mark -
#pragma mark private

- (void)updateTableDelegate {
    if (!_pokerView.delegate) {
        [_pokerDelegate release];
        _pokerDelegate = [[self createDelegate] retain];
        
        // You need to set it to nil before changing it or it won't have any effect
        _pokerView.delegate = nil;
        _pokerView.delegate = _pokerDelegate;
    }
}

#pragma mark -
#pragma mark  public
- (id<TBPokerViewDelegate>)createDelegate{
    return [[[TBPokerViewDelegate alloc] initWithController:self] autorelease];
//    if (_variableHeightRows) {
//        return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
//        
//    } else {
//        return [[[TTTableViewDelegate alloc] initWithController:self] autorelease];
//    }
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
- (BOOL)shouldOpenURL:(NSString*)URL{
    return YES;
}


- (void)didBeginDragging{}


- (void)didEndDragging{}

- (void)invalidateModel {
    [super invalidateModel];
    
    // Renew the tableView delegate when the model is refreshed.
    // Otherwise the delegate will be retained the model.
    
    // You need to set it to nil before changing it or it won't have any effect
    _pokerView.delegate = nil;
    [self updateTableDelegate];
}

@end
