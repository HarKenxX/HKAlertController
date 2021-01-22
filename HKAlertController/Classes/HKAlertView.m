//
//  HKAlertView.m
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import "HKAlertView.h"
#import "HKAlertAction.h"
#import <Masonry/Masonry.h>

const NSInteger kHKAlertHorizontalButtonMax = 2;
const NSInteger kHKAlertVerticalButtonMax = 4;

const CGFloat kHKAlertContentInsidePadding = 16.f;
const CGFloat kHKAlertContentTopPadding = 28.f;
const CGFloat kHKAlertContentBottomPadding = 20.f;

const CGFloat kHKAlertTitleMessagePadding = 8.f;
const CGFloat kHKAlertMessageButtonPadding = 18.f;
const CGFloat kHKAlertButtonsPadding = 12.f;

const CGFloat kHKAlertTitleHeight = 20.f;
const CGFloat kHKAlertButtonHeight = 36.f;

@interface HKAlertView ()

@property (nonatomic, copy, nonnull) NSArray<UIButton *> *buttons;

@property (nonatomic, strong, nonnull) UILabel *titleLabel;

@property (nonatomic, strong, nonnull) UILabel *messageLabel;

@end

@implementation HKAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUIs:frame];
    }
    return self;
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    
    [self prepareUIs:self.frame];
}

- (void)prepareUIs:(CGRect)frame {
    BOOL titleExists = self.titleLabel.text.length > 0;
    [self resetTitleFontIfNeeded];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(kHKAlertContentTopPadding);
        make.trailing.leading.equalTo(self).inset(kHKAlertContentInsidePadding);
        make.height.mas_greaterThanOrEqualTo(titleExists ? kHKAlertTitleHeight : 0);
    }];
    
    [self addSubview:self.messageLabel];
    
    if (self.buttons.count == 0) {
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(kHKAlertTitleMessagePadding);
            make.trailing.leading.equalTo(self.titleLabel);
            make.bottom.equalTo(self).inset(kHKAlertContentBottomPadding);
        }];
        return;
    }
    
    CGFloat buttonsHeight = 0.f;
    if (HKAlertViewStyleHorizontal == self.alertStyle) {
        [self prepareHorizontalButtons:frame];
        buttonsHeight = kHKAlertButtonHeight;
    } else if (HKAlertViewStyleVertical == self.alertStyle) {
        [self prepareVerticalButtons:frame];
        buttonsHeight = kHKAlertButtonHeight * self.buttons.count + kHKAlertButtonsPadding * (self.buttons.count - 1);
    }
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(titleExists ? kHKAlertTitleMessagePadding : 0);
        make.trailing.leading.equalTo(self.titleLabel);
        make.bottom.equalTo(self).inset(buttonsHeight + kHKAlertContentBottomPadding + kHKAlertMessageButtonPadding);
    }];
}

- (void)prepareHorizontalButtons:(CGRect)frame {
    if (self.buttons.count == 1) {
        UIButton *button = self.buttons.firstObject;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.titleLabel);
            make.top.equalTo(self.messageLabel.mas_bottom).offset(kHKAlertMessageButtonPadding);
            make.height.mas_equalTo(kHKAlertButtonHeight);
        }];
    } else {
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button,
                                                   NSUInteger idx,
                                                   BOOL * _Nonnull stop) {
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (idx == 0) {
                    make.leading.equalTo(self.titleLabel);
                } else if (idx == 1) {
                    make.trailing.equalTo(self.titleLabel);
                }
                make.top.equalTo(self.messageLabel.mas_bottom).offset(kHKAlertMessageButtonPadding);
                make.width.equalTo(self.titleLabel).dividedBy(2).offset(-kHKAlertButtonsPadding * 0.5);
                make.height.mas_equalTo(kHKAlertButtonHeight);
            }];
            
            if (idx >= kHKAlertHorizontalButtonMax) {
                *stop = YES;
                return;
            }
        }];
    }
}

- (void)prepareVerticalButtons:(CGRect)frame {
    __block UIButton *lastButton = nil;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button,
                                               NSUInteger idx,
                                               BOOL * _Nonnull stop) {
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastButton) {
                make.leading.trailing.equalTo(lastButton);
                make.height.equalTo(lastButton);
                make.top.equalTo(lastButton.mas_bottom).offset(kHKAlertButtonsPadding);
            } else {
                make.leading.trailing.equalTo(self.titleLabel);
                make.height.mas_equalTo(kHKAlertButtonHeight);
                make.top.equalTo(self.messageLabel.mas_bottom).offset(kHKAlertMessageButtonPadding);
            }
        }];
        lastButton = button;
    }];
}

- (void)resetTitleFontIfNeeded {
    if (self.messageLabel.text.length == 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:16.f];
    } else {
        self.titleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightBold];
    }
    
    if (self.titleLabel.text.length == 0) {
        self.messageLabel.font = [UIFont systemFontOfSize:16.f];
        self.messageLabel.textColor = UIColor.blackColor;
    } else {
        self.messageLabel.font = [UIFont systemFontOfSize:14.f];
        self.messageLabel.textColor = [UIColor colorWithWhite:0 alpha:0.4f];
    }
}

- (void)resetWithTitle:(nonnull NSString *)title
               message:(nullable NSString *)message
               actions:(nullable NSArray<HKAlertAction *> *)actions {
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    
    if (HKAlertViewStyleHorizontal == self.alertStyle) {
        if (actions.count > kHKAlertHorizontalButtonMax) {
            actions = @[ actions[0], actions[1] ];
        }
    }
    NSMutableArray<UIButton *> *buttons = [NSMutableArray arrayWithCapacity:actions.count];
    
    [actions enumerateObjectsUsingBlock:^(HKAlertAction * _Nonnull action,
                                          NSUInteger idx,
                                          BOOL * _Nonnull stop) {
        UIButton *button = [self buttonWithAction:action];
        button.tag = idx;
        [buttons addObject:button];
    }];
    self.buttons = buttons;
    
    [self removeAllSubViews];
    [self setNeedsLayout];
}

- (void)removeAllSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (UIButton *)buttonWithAction:(HKAlertAction *)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIColor *backgroundColor, *titleColor, *borderColor;
    switch (action.style) {
        case HKAlertActionStyleDefault:
        {
            backgroundColor = UIColor.blueColor;
            titleColor = UIColor.whiteColor;
        }
            break;
        case HKAlertActionStyleCancel:
        case HKAlertActionStyleDestructive:
        {
            backgroundColor = UIColor.whiteColor;
            titleColor = UIColor.blackColor;
            borderColor = [UIColor colorWithWhite:0 alpha:0.1f];
        }
            break;
    }
    
    [button setBackgroundColor:backgroundColor];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:action.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapActionButton:) forControlEvents:UIControlEventTouchUpInside];
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor;
        button.layer.borderWidth = 1.f;
    }
    button.layer.cornerRadius = 4.f;
    button.titleLabel.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightBold];
    button.enabled = action.isEnabled;
    button.alpha = action.isEnabled ? 1.f : 0.3f ;
    return button;
}

#pragma mark - Handler Functions

- (void)didTapActionButton:(UIButton *)sender {
    !self.actionButtonDidClick ?: self.actionButtonDidClick(sender.tag);
}

#pragma mark - Lazy Functions

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.font = [UIFont systemFontOfSize:14.f];
        _messageLabel.textColor = [UIColor colorWithWhite:0 alpha:0.4f];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

@end



