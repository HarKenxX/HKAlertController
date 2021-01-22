//
//  HKAlertController.m
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import "HKAlertController.h"
#import "HKAlertTransitioningGenerator.h"
#import "HKAlertView.h"

#import <Masonry/Masonry.h>

const CGFloat kHKAlertContentRadius = 8.f;
const CGFloat kHKAlertContentOutsidePadding = 35.f;

@interface HKAlertController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong, nonnull) HKAlertView *alertContentView;
@property (nonatomic, strong, nonnull) UIButton *alertBackgroundView;

@property (nonatomic, assign) HKAlertViewStyle preferredStyle;

@property (nonatomic, copy, nonnull) NSMutableArray<HKAlertAction *> *alertActions;
@property (nonatomic, copy, nullable) dispatch_block_t cancelBlock;

@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

@end

@implementation HKAlertController
@synthesize title = _title;

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                          preferredStyle:(HKAlertViewStyle)preferredStyle {
    HKAlertController *alertController = [[HKAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.preferredStyle = preferredStyle;
    return alertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUIs];
    [self prepareConstraints];
}

#pragma mark - Prepare Functions

- (void)prepareUIs {
    self.view.backgroundColor = UIColor.clearColor;
    
    [self.view addSubview:self.alertBackgroundView];
    [self.view addSubview:self.alertContentView];
    
    self.alertContentView.alertStyle = self.preferredStyle;
    [self.alertContentView resetWithTitle:self.title message:self.message actions:self.actions];
    __weak typeof(self) weakSelf = self;
    self.alertContentView.actionButtonDidClick = ^(NSUInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.actions.count <= index) {
            return;
        }
        
        HKAlertAction *alertAction = strongSelf.actions[index];
        if (alertAction.isEnabled) {
            [strongSelf dismissViewControllerAnimated:YES completion:^{
                strongSelf.class.alertWindow.hidden = YES;
                !alertAction.handler ?: alertAction.handler(alertAction);
            }];
        }
    };
}

- (void)prepareConstraints {
    [self.alertBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.leading.equalTo(self.view);
    }];
    
    [self.alertContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.equalTo(self.view).inset(kHKAlertContentOutsidePadding);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - Public Functions

- (void)addAction:(HKAlertAction *)action {
    [self.alertActions addObject:action];
}

- (void)addCancelAction:(dispatch_block_t)cancelBlock {
    self.cancelBlock = cancelBlock;
}

- (void)show {
    UIViewController *presentedController = self.class.alertWindow.rootViewController.presentedViewController;
    if (presentedController) {
        /// dismiss last alert controller
        [presentedController dismissViewControllerAnimated:NO completion:nil];
    }
    
    self.class.alertWindow.rootViewController = [[UIViewController alloc] init];
    self.class.alertWindow.hidden = NO;
    [self.class.alertWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        weakSelf.class.alertWindow.hidden = YES;
    }];
}

#pragma mark - Handler Functions

- (void)didTapAlertBackgroundView:(id)sender {
    if (!self.cancelBlock) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        weakSelf.class.alertWindow.hidden = YES;
        !weakSelf.cancelBlock ?: weakSelf.cancelBlock();
    }];
}

#pragma mark - Setter & Getter Functions

static UIWindow *alertWindow = nil;
+ (UIWindow *)alertWindow {
    if (!alertWindow) {
        alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.windowLevel = UIWindowLevelAlert;
    }
    return alertWindow;
}

- (NSMutableArray<HKAlertAction *> *)alertActions {
    if (!_alertActions) {
        _alertActions = [NSMutableArray array];
    }
    return _alertActions;
}

- (NSArray<HKAlertAction *> *)actions {
    return [self.alertActions copy];
}

- (void)setTitleAlignment:(NSTextAlignment)titleAlignment {
    _titleAlignment = titleAlignment;
    self.alertContentView.titleLabel.textAlignment = _titleAlignment;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    self.alertContentView.messageLabel.textAlignment = _messageAlignment;
}

#pragma mark - Lazy Functions

- (UIButton *)alertBackgroundView {
    if (!_alertBackgroundView) {
        _alertBackgroundView = [UIButton buttonWithType:UIButtonTypeCustom];
        _alertBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _alertBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4f];
        [_alertBackgroundView addTarget:self
                                 action:@selector(didTapAlertBackgroundView:)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    return _alertBackgroundView;
}

- (HKAlertView *)alertContentView {
    if (!_alertContentView) {
        _alertContentView = [[HKAlertView alloc] initWithFrame:CGRectZero];
        _alertContentView.backgroundColor = UIColor.whiteColor;
        _alertContentView.layer.cornerRadius = kHKAlertContentRadius;
    }
    return _alertContentView;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    HKAlertTransitioningGenerator *generator = [[HKAlertTransitioningGenerator alloc] init];
    generator.transitioningType = HKAlertTransitioningTypePresent;
    return generator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    HKAlertTransitioningGenerator *generator = [[HKAlertTransitioningGenerator alloc] init];
    generator.transitioningType = HKAlertTransitioningTypeDismiss;
    return generator;
}

@end
