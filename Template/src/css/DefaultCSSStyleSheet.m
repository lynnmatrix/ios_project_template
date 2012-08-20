//
//  DefaultCSSStyleSheet.m
//  
//
//  Created by Yiming Lin on 11/1/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "DefaultCSSStyleSheet.h"
#import "Three20Style/UIColorAdditions.h"

@implementation DefaultCSSStyleSheet
//- (UIColor*) navigationBarTintColor
//{
//    return [UIColor clearColor];
//}
//
//- (UIColor*) backgroundColor
//{
//    return RGBCOLOR(239, 236, 220);
//}
//
//- (UIColor *) tableGroupedBackgroundColor
//{
//    return [UIColor clearColor];
//}
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UIColor*)tablePlainBackgroundColor {
//    return RGBCOLOR(239, 236, 220);
//}
//
//- (UIColor*) pokerViewBackgroundColor{
//    return RGBCOLOR(239, 236, 220);
//}
//
//- (UITableViewCellSelectionStyle)tableSelectionStyle {
//    return UITableViewCellSelectionStyleNone;
//}
//
//- (UITableViewCellSeparatorStyle)tablePlainCellSeparatorStyle {
//	return UITableViewCellSeparatorStyleSingleLine;
//}
//
//- (UIColor*)tableHeaderTextColor {
//    return RGBCOLOR(131, 105, 58);
//}
//
//- (UIImage*) navigationBarImage
//{
//    return [UIImage imageNamed:@"NavigationBar.png"];
//}
//
//#pragma mark -
//#pragma mark button style
//
//- (TTStyle*) buttonForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"Button"] 
//                 stretchableImageWithLeftCapWidth:15 topCapHeight:0];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonPressed"] 
//                 stretchableImageWithLeftCapWidth:15 topCapHeight:0];
//    }
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTSolidBorderStyle styleWithColor:nil width:0 next:
//              [TTTextStyle styleWithColor:TTSTYLEVAR(postButtonColor) next:
//               nil]]]];
//}
//
//- (TTStyle*) buttonBackForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"ButtonBack"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonBackPressed"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
//    }
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTTextStyle styleWithColor:TTSTYLEVAR(postButtonColor) next:
//              nil]]];
//}
//
//- (TTStyle*) buttonConfigForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [UIImage imageNamed:@"ButtonConfig"];
//    }else{
//        image = [UIImage imageNamed:@"ButtonConfigPressed"];
//    }
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTSolidBorderStyle styleWithColor:nil width:0 next:nil]]];
//}
//
//- (TTStyle*) buttonRightForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"ButtonRight"] 
//                 stretchableImageWithLeftCapWidth:20 topCapHeight:0];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonRightPressed"] 
//                 stretchableImageWithLeftCapWidth:20 topCapHeight:0];
//    }
//    TTTextStyle *textStyle = [TTTextStyle styleWithFont:[UIFont systemFontOfSize:15.0] color:TTSTYLEVAR(postButtonColor) textAlignment:UITextAlignmentCenter next:
//                              nil];
//    [textStyle setVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             textStyle]];
//}
//
//- (TTStyle*) buttonLeftForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"ButtonLeft"] 
//                 stretchableImageWithLeftCapWidth:20 topCapHeight:0];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonLeftPressed"] 
//                 stretchableImageWithLeftCapWidth:20 topCapHeight:0];
//    }
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTTextStyle styleWithColor:TTSTYLEVAR(postButtonColor) next:
//              nil]]];
//}
//
//- (TTStyle*) buttonRightWhiteForState: (UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"ButtonRightWhite"] 
//                 stretchableImageWithLeftCapWidth:5 topCapHeight:0];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonRightWhitePressed"] 
//                 stretchableImageWithLeftCapWidth:5 topCapHeight:0];
//    }
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTTextStyle styleWithColor:TTSTYLEVAR(postButtonColor) next:
//              nil]]];
//}
//
//- (TTStyle*) buttonTransparentForState:(UIControlState*) state
//{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [[UIImage imageNamed:@"ButtonTransparent"] 
//                 stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    }else{
//        image = [[UIImage imageNamed:@"ButtonTransparentPressed"] 
//                 stretchableImageWithLeftCapWidth:15 topCapHeight:15];
//    }
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTImageStyle styleWithImage:image next:
//             [TTTextStyle styleWithColor:TTSTYLEVAR(postButtonColor) next:
//              nil]]];
//}
//
//- (TTStyle*) buttonClearForState:(UIControlState*) state{
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
//             [TTTextStyle styleWithFont:TTSTYLEVAR(font) next:
//              nil]]];
//}
//
//- (TTStyle*) buttonDeleteForState:(UIControlState) state
//{
//    UIImage* image = nil;
//
//    image = [UIImage imageNamed:@"ButtonNotChecked@"];
//
//    TTImageStyle* imageStyle = [TTImageStyle styleWithImage:image next:nil];
//    imageStyle.contentMode = UIViewContentModeTopRight;
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            imageStyle];
//}
//
//- (TTStyle*)blueButton:(UIControlState)state {
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [UIImage imageNamed:@"ButtonChecked"];
//    }else{
//        image = [UIImage imageNamed:@"ButtonCheckedPressed"];
//    }
//    TTImageStyle* imageStyle = [TTImageStyle styleWithImage:image next:nil];
//
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            imageStyle];
//}
//
//- (TTStyle*)silveryButton:(UIControlState)state {
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [UIImage imageNamed:@"ButtonCheckedGray"];
//    }else{
//        image = [UIImage imageNamed:@"ButtonCheckedGrayPressed"];
//    }
//
//    TTImageStyle* imageStyle = [TTImageStyle styleWithImage:image next:nil];
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            imageStyle];
//}
//
//- (TTStyle*) buttonOptionForState:(UIControlState) state{
//    UIImage* image = nil;
//    if (UIControlStateNormal == state) {
//        image = [UIImage imageNamed:@"ButtonOption"];
//    }else{
//        image = [UIImage imageNamed:@"ButtonOptionPressed"];
//    }
//    TTImageStyle* imageStyle = [TTImageStyle styleWithImage:image next:nil];
//    
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            imageStyle];
//}
//
//#pragma mark -
//- (TTStyle*) labelDefault
//{
//    return [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
//            [TTTextStyle styleWithFont:TTSTYLEVAR(font) 
//                                 color:TTSTYLEVAR(textColor) 
//                         textAlignment:UITextAlignmentLeft next:nil]
//            ];
//}
//
//- (TTStyle*) labelHint
//{
//    return [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
//            [TTTextStyle styleWithFont:TTSTYLEVAR(font)
//                                 color:[UIColor orangeColor]
//                         textAlignment:UITextAlignmentRight
//                                  next:nil]
//            ];
//}
//- (TTStyle*) labelPrompt{
//    TTTextStyle* textStyle = [TTTextStyle styleWithFont:TTSTYLEVAR(font)
//                                                  color:STYLEVAR(hintTextColor)
//                                          textAlignment:UITextAlignmentLeft
//                                                   next:nil];
//    textStyle.lineBreakMode = UILineBreakModeWordWrap;
//    textStyle.numberOfLines =0;
//    return [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:textStyle];
//}
//
//- (TTStyle*) labelOrange
//{
//    return [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
//            [TTTextStyle styleWithFont:TTSTYLEVAR(font) 
//                                 color:STYLEVAR(orangeTextColor)
//                         textAlignment:UITextAlignmentLeft next:nil]
//            ];
//}
//
//- (TTStyle*) textEditor
//{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//            [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
//             [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.4) 
//                                           blur:2 
//                                         offset:CGSizeMake(1, 1) next:
//              nil]]];
//}
//
//- (TTStyle*) fakeTextEditor
//{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4] next:
//            [TTSolidFillStyle styleWithColor:RGBCOLOR(209, 197, 175) next:
//             [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.4) 
//                                           blur:2 
//                                         offset:CGSizeMake(1, 1) next:
//              [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 5*kTableCellHPadding, 0, 0) next:
//              nil]]]];
//}
//
//- (TTStyle*) homeTownButtonStyle{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//            [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
//             [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.4) 
//                                           blur:2 
//                                         offset:CGSizeMake(1, 1) next:
//              [TTBoxStyle  styleWithPadding:UIEdgeInsetsMake(0, kTableCellHPadding, 0, 0) next:
//               [TTTextStyle styleWithFont:[UIFont systemFontOfSize:16]
//                                    color:TTSTYLEVAR(textColor)
//                            textAlignment:UITextAlignmentLeft
//                                     next:nil]]]]];
//}
//
//- (TTStyle*) homeTownButtonNullStyle{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//            [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
//             [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.4) 
//                                           blur:2 
//                                         offset:CGSizeMake(1, 1) next:
//              [TTBoxStyle  styleWithPadding:UIEdgeInsetsMake(0, kTableCellHPadding, 0, 0) next:
//               [TTTextStyle styleWithFont:[UIFont systemFontOfSize:16]
//                                    color:TTSTYLEVAR(grayTextColor)
//                            textAlignment:UITextAlignmentLeft
//                                     next:nil]]]]];
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (TTStyle*)searchTextField {
//    return
//    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:TT_ROUNDED] next:
//     [TTInsetStyle styleWithInset:UIEdgeInsetsMake(1, 45, 1, 0) next:nil]];
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (TTStyle*)searchBar {
//    return
//     [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//        [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
//          [TTSolidBorderStyle styleWithColor:RGBCOLOR(212, 213, 216) width:1 next:
//           nil]]];
//}
//
//- (TTStyle*) orangeBox {
//    return
//    [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//     [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 5, 0, 5) next:
//      [TTSolidFillStyle styleWithColor:RGBCOLOR(230, 121, 101) next:
//       [TTTextStyle styleWithColor:[UIColor whiteColor] next:
//        [TTInnerShadowStyle styleWithColor:[UIColor grayColor]
//                                      blur:1
//                                    offset:CGSizeMake(0,1)  next:
//         nil]]]]];
//}
//
//- (TTStyle*) trainHeadView
//{ 
//    return 
//    [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//     [TTShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) 
//                              blur:3 
//                            offset:CGSizeMake(0, 1) next:
//      [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
//                                          color2:RGBCOLOR(235, 234, 233) next:
//       nil]]];
//}
//
//- (TTStyle*) alertViewBackgroundView
//{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:10] next:
//            [TTSolidFillStyle styleWithColor:RGBCOLOR(255,238,205)  next:nil]];
//}
//
//- (TTStyle*) alertViewTitleLabel
//{
//    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
//            [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
//             [TTTextStyle styleWithFont:[UIFont systemFontOfSize:20]
//                                  color:[UIColor redColor]
//                          textAlignment:UITextAlignmentCenter next:nil]]];
//}
//
//- (TTStyle*) alertCancelButton
//{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//            [TTImageStyle styleWithImage:[UIImage imageNamed:@"GrayPlainBar.png"] next:
//             [TTTextStyle styleWithFont:nil color:[UIColor blackColor] 
//                          textAlignment:UITextAlignmentCenter next:nil]]];
//}
//
//- (TTStyle*) alertDoneButton
//{
//    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
//            [TTImageStyle styleWithImage:[UIImage imageNamed:@"GrayPlainBar.png"] 
//                                    next:nil]];
//}
//
//- (TTStyle*) orangeText
//{
//    return [TTTextStyle styleWithColor:STYLEVAR(orangeTextColor) next:nil];
//}
//
//- (TTStyle*) starBackground
//{
//    UIImage* starBkImage = [[UIImage imageNamed:@"StarBackground"] 
//                            stretchableImageWithLeftCapWidth:5
//                            topCapHeight:5];
//    
//    return [TTImageStyle styleWithImage:starBkImage next:
//            [TTShapeStyle styleWithShape:[TTRectangleShape shape]
//                                    next:
//             nil]];
//}
//
//#pragma mark -
//#pragma color
//
//- (UIColor*) textColor
//{
//    return RGBCOLOR(54, 50, 50);
//}
//
//-(UIColor*) grayTextColor{
//    return RGBCOLOR(119, 119, 119);
//}
//
//-(UIColor*) hintTextColor{
//    return RGBCOLOR(139, 137, 137);
//}
//
//- (UIColor*) orangeTextColor{
//    return RGBCOLOR(255, 75, 9);
//}
//
//- (UIColor*)tableSubTextColor {
//    return RGBCOLOR(80, 80, 80);
//}
//
//- (UIColor*)moreLinkTextColor {
//    return RGBCOLOR(99, 109, 125);
//}
//
//- (UIFont*)buttonFont {
//    return [UIFont boldSystemFontOfSize:16];
//}
//
//- (UIColor*) postButtonColor
//{
//    return RGBCOLOR(78, 77, 77);
//}
//
//- (UIColor*)timestampTextColor 
//{
//    return [UIColor colorWithWhite:0.5 alpha:1];
//}
//
//- (UIColor*) tableCellBackgroundColor{
//    return RGBACOLOR(254,252,237,0.9);
//}
//
//-(UIColor*) accountConfigBkColor{
//
//    return RGBCOLOR(255, 253, 247);
//}
//
//- (UIColor*)backgroundTextColor {
//	return [UIColor clearColor];
//}
//
//#pragma mark -
//#pragma mark refresh header
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UIColor*)tableRefreshHeaderBackgroundColor {
//    return [UIColor clearColor];
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UIColor*)tableRefreshHeaderTextColor {
//    return RGBCOLOR(50,50,50);
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UIColor*)tableRefreshHeaderTextShadowColor {
//    return [[UIColor whiteColor] colorWithAlphaComponent:0.9];
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (CGSize)tableRefreshHeaderTextShadowOffset {
//    return CGSizeMake(0.0f, 1.0f);
//}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UIImage*)tableRefreshHeaderArrowImage {
//    return [UIImage imageNamed:@"RefreshArrow"];
//}

@end
