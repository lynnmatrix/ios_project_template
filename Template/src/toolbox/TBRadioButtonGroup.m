//
//  TBRadioButtonGroup.m
//  
//
//  Created by Yiming Lin on 2/23/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import "TBRadioButtonGroup.h"

// MODIFIED:
#define RADIO_UNSELECTED 0
#define RADIO_SELECTED 1

@implementation TBRadioButtonGroup
@synthesize radioButtons = _radioButtons;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns{
    NSMutableArray *arrTemp =[[NSMutableArray alloc]init];
    self.radioButtons =arrTemp;
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        int framex =0;
        framex= frame.size.width/columns;
        int framey = 0;
        framey =frame.size.height/([options count]/(columns));
        int rem =[options count]%columns;
        if(rem !=0){
            framey =frame.size.height/(([options count]/columns)+1);
        }
        int k = 0;
        for(int i=0;i<([options count]/columns);i++){
            for(int j=0;j<columns;j++){
                int x = kTableCellHPadding;
                int y = kTableCellVPadding;
                UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*i+y, framex/2+x, framey/2+y)];
                [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [btTemp setImage:[UIImage imageNamed:@"RadioBox.png"] forState:UIControlStateNormal];
                [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
                [btTemp setTitle:[NSString stringWithFormat:@"  %@",[options objectAtIndex:k]] forState:UIControlStateNormal];
                // MODIFIED:
                btTemp.tag = RADIO_UNSELECTED;
                [self.radioButtons addObject:btTemp];
                [self addSubview:btTemp];
                k++;
            }
        }
        for(int j=0;j<rem;j++){
            int x = framex*0.25;
            int y = framey*0.25;
            UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*([options count]/columns), framex/2+x, framey/2+y)];
            [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btTemp setImage:[UIImage imageNamed:@"RadioBox.png"] forState:UIControlStateNormal];
            [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
            [btTemp setTitle:[NSString stringWithFormat:@"  %@",[options objectAtIndex:k]] forState:UIControlStateNormal];
            // MODIFIED:
            btTemp.tag = RADIO_UNSELECTED;
            [self.radioButtons addObject:btTemp];
            [self addSubview:btTemp];
            k++;
        }
    }
    return self;
}

-(IBAction) radioButtonClicked:(UIButton *) sender{
    for(int i=0;i<[self.radioButtons count];i++){
        // MODIFIED:
        UIButton *btTemp = [self.radioButtons objectAtIndex:i];
        [btTemp setImage:[UIImage imageNamed:@"RadioBox.png"] forState:UIControlStateNormal];
        // MODIFIED:
        if (btTemp == sender) {
            if (RADIO_SELECTED!=btTemp.tag) {
                [btTemp setTag:RADIO_SELECTED];
                if (self.delegate) {
                    if ([self.delegate conformsToProtocol:@protocol(DSRadioButtonGroupDelegete)]) {
                        [self.delegate performSelector:@selector(onRadioButtonGroupChanged:) withObject:self];
                    }else{
                        [NSException raise:NSInternalInconsistencyException
                                    format:@"'%@' must conform with the 'DSRadioButtonGroupDelegete' protocol",
                         NSStringFromClass([(id)self.delegate class]) ];
                    }
                }
            }
  
        } else {
            [btTemp setTag:RADIO_UNSELECTED];
        }
    }
    [sender setImage:[UIImage imageNamed:@"RadioBoxChecked.png"] forState:UIControlStateNormal];

    
}
-(void) removeButtonAtIndex:(int)index{
    [[self.radioButtons objectAtIndex:index] removeFromSuperview];
}
-(void) setSelected:(int) index{
    for(int i=0;i<[self.radioButtons count];i++){
        // MODIFIED:
        UIButton *btTemp = [self.radioButtons objectAtIndex:i];
        [btTemp setImage:[UIImage imageNamed:@"RadioBox.png"] forState:UIControlStateNormal];
        // MODIFIED:
        [btTemp setTag:RADIO_UNSELECTED];
    }
    // MODIFIED:
    UIButton *btSelected = [self.radioButtons objectAtIndex:index];
    // MODIFIED:
    [btSelected setTag:RADIO_SELECTED];
    [btSelected setImage:[UIImage imageNamed:@"RadioBoxChecked.png"] forState:UIControlStateNormal];
}

// MODIFIED:
-(int) getSelected {
    for(int i=0;i<[self.radioButtons count];i++){
        UIButton *btTemp = [self.radioButtons objectAtIndex:i];
        if (btTemp.tag == RADIO_SELECTED) {
            return i;
        }
    }
    return -1;
}
-(void)clearAll{
    for(int i=0;i<[self.radioButtons count];i++){
        [[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"RadioBox.png"] forState:UIControlStateNormal];
    }
}
@end