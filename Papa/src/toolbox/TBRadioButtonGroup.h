//
//  TBRadioButtonGroup.h
//  
//
//  Created by Yiming Lin on 2/23/12.
//  Copyright (c) 2012 Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TBRadioButtonGroup;

@protocol DSRadioButtonGroupDelegete <NSObject>

@optional
- (void) onRadioButtonGroupChanged:(TBRadioButtonGroup*)sender;

@end

@interface TBRadioButtonGroup : UIView{
}

@property (nonatomic,retain) NSMutableArray *radioButtons;
@property (nonatomic, assign) id<DSRadioButtonGroupDelegete> delegate;


- (id)initWithFrame:(CGRect)frame 
         andOptions:(NSArray *)options 
         andColumns:(int)columns;

-(IBAction) radioButtonClicked:(UIButton *) sender;

-(void) removeButtonAtIndex:(int)index;

-(void) setSelected:(int) index;
-(int) getSelected;

-(void)clearAll;

@end
