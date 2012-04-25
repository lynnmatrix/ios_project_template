//
//  TBGlobalErrorView.m
//  
//
//  Created by Yiming Lin on 12/15/11.
//  Copyright (c) 2011 Youdao. All rights reserved.
//

#import "TBGlobalErrorView.h"

@interface TBGlobalErrorView () 
- (id) initWithMessage: (NSString*) title
              imageURL: (NSString*) imageURL;

- (void) show;
- (void) hide;

- (void) setMessage:(NSString*) message;
- (void) setImageURL: (NSString*) imageURL;
@end

@implementation TBGlobalErrorView

-(id) init
{
    if (self = [super init]) {
        _imageView = [[TTImageView alloc] init];
        _imageView.autoresizesToImage =YES;
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = TTSTYLEVAR(font);
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.width = 150;
        [self addSubview:_messageLabel];
        
        self.width = 150;
        self.backgroundColor = [UIColor clearColor];
        self.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:10] next:
                      [TTSolidFillStyle styleWithColor:RGBACOLOR(0, 0, 0, 0.7) next:
                       nil]];
    }
    return self;
}

- (id) initWithMessage: (NSString*) title
              imageURL: (NSString*) imageURL
{
    if (self = [self init]) {
        _imageView.urlPath = imageURL;
        
        _messageLabel.text = title;
        [_messageLabel sizeToFit];
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    _imageView.centerX = self.width/2;
    _imageView.top = kTableCellMargin;

    [_messageLabel sizeToFit];
    _messageLabel.top = _imageView.bottom +kTableCellMargin;
    _messageLabel.centerX = self.width/2;

    self.height = _messageLabel.bottom +kTableCellMargin;
}
#pragma mark --
#pragma mark public method
- (void) setMessage:(NSString*) message
{
    _messageLabel.text= message;
    [_messageLabel sizeToFit];
}

- (void) setImageURL: (NSString*) imageURL
{
    _imageView.urlPath = imageURL;
}

#pragma mark --
#pragma mark public Class method
+ (void) showNetworkErrorView
{
    NSString* title =NSLocalizedString(@"网络连接失败", nil);
    NSString* imageURL=@"bundle://AlertNetwork.png";
    
    [TBGlobalErrorView showErrorViewWithMessage:title
                                       imageURL:imageURL];
}

+ (void) showEmptyErrorView
{
    NSString* title =NSLocalizedString(@"没有符合条件的结果", nil);
    NSString* imageURL=@"bundle://AlertEmpty.png";
    
    [TBGlobalErrorView showErrorViewWithMessage:title
                                       imageURL:imageURL];
}

+ (void) showRequestFailureView
{
    NSString* title =NSLocalizedString(@"无法完成请求", nil);
    NSString* imageURL=@"bundle://AlertRequest.png";
    
    [TBGlobalErrorView showErrorViewWithMessage:title
                                       imageURL:imageURL];
}

+ (void) showErrorViewWithMessage:(NSString*) message
                         imageURL:(NSString*) imageURL
{
    static TBGlobalErrorView* errorView = nil;
    if (nil == errorView) {
        errorView = [[TBGlobalErrorView alloc] init];
    }
    [errorView setMessage:message];
    [errorView setImageURL:imageURL];
    
    [errorView show];
}



- (void) show
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    CGRect windowFrame = [window frameWithKeyboardSubtracted:0];
    self.centerX = windowFrame.size.width/2;
    self.centerY = windowFrame.size.height/2;

    [self removeFromSuperview];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    self.alpha = 0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    self.alpha= 1;
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:2
                                      target:self
                                    selector:@selector(hide)
                                    userInfo:nil
                                     repeats:NO];
}

#pragma mark -
#pragma mark private

-(void) hide
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    self.alpha = 0;
    [UIView commitAnimations];
}
@end
