//
//  TBCommentView.m
//  
//
//  Created by Yiming Lin on 12/26/11.
//  Copyright (c) 2011 . All rights reserved.
//

#import "TBCommentView.h"
#import "TBAlertView.h"

@implementation TBCommentView

- (id) init
{
    if (self =[super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        _inited = NO;
        _maxTextLength = 163;
        UIImage *bgImage = [[UIImage imageNamed:@"CommentBg.png"] stretchableImageWithLeftCapWidth:25.0 
                                                                                      topCapHeight:20.0];
        _backgroundImageView = [[UIImageView alloc] init];
        [_backgroundImageView setImage:bgImage];
        [self addSubview:_backgroundImageView];
        
        _commentTextView = [[UITextView alloc] init];
        _commentTextView.delegate =self;
        [_commentTextView setEditable:YES];
        [_commentTextView setBackgroundColor:[UIColor clearColor]];
        [_commentTextView setTextColor:[UIColor lightGrayColor]];
        [_commentTextView setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_commentTextView setFont:[UIFont systemFontOfSize:14.0]];

        [self addSubview:_commentTextView];
        
        _letterCountLabel = [[UILabel alloc] init];
        [_letterCountLabel setFont:[UIFont systemFontOfSize:10.0]];
        [_letterCountLabel setTextColor:[UIColor lightGrayColor]];
        [_letterCountLabel setTextAlignment:UITextAlignmentRight];
        [_letterCountLabel setBackgroundColor:[UIColor clearColor]];
        [_letterCountLabel setText:[NSString stringWithFormat:@"0/%d",_maxTextLength]];
        [self addSubview:_letterCountLabel]; 
        [_commentTextView becomeFirstResponder];
    }
    return self;
}


- (void) setText:(NSString *)text
{
    _commentTextView.text = text;
}

- (NSString*) text
{
    if (!_inited) {
        return nil;
    }
    return _commentTextView.text;
}

- (void) setMaxTextLength: (int) maxTextLength;
{
    _maxTextLength = maxTextLength;
    [_letterCountLabel setText:[NSString stringWithFormat:@"0/%d",_maxTextLength]];
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    _backgroundImageView.frame = CGRectMake(0, 0, 
                                            self.width, 
                                            self.height);
    _commentTextView.frame = CGRectMake(kTableCellHPadding, 
                                        kTableCellVPadding, 
                                        self.width-2*kTableCellHPadding, 
                                        self.height-3.5*kTableCellVPadding);

    [_letterCountLabel sizeToFit];
    _letterCountLabel.top= _commentTextView.bottom;
    _letterCountLabel.right = self.width - 2*kTableCellHPadding;

}

#pragma -
#pragma UITextView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (!_inited)
    {
        [_commentTextView setText:@""];
        [_commentTextView setTextColor:[UIColor blackColor]];
        _inited = YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([[textView text] length] > _maxTextLength)
    {
        NSString *substring = [[textView text] substringToIndex:_maxTextLength];
        [textView setText:substring];
        [textView scrollRangeToVisible:NSRangeFromString(substring)];

    }
    [_letterCountLabel setText:[NSString stringWithFormat:@"%d/%d", [[textView text] length],_maxTextLength]];
    [_letterCountLabel sizeToFit];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString* originalText = textView.text;
    if (originalText.length>_maxTextLength) {
        return NO;
    }
    NSString* preText = [originalText substringToIndex:range.location];
    NSString* suffixText = [originalText substringFromIndex:(range.location+range.length)];
    NSString* newText = [NSString stringWithFormat:@"%@%@%@%",preText,text,suffixText];
    if (newText.length> _maxTextLength)
    {
        NSString* alert = [NSString stringWithFormat:@"%@%d%@",
                           TTLocalizedString(@"内容有点长，请控制字数在",nil),
                           _maxTextLength,
                           TTLocalizedString(@"以内",nil)];
        DSAlert(alert);
        return NO;
    }
    return YES;
}

@end
