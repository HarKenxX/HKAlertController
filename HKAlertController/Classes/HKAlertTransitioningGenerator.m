//
//  HKAlertTransitioningGenerator.m
//  HKAlertController
//
//  Created by Harken on 2021/1/22.
//

#import "HKAlertTransitioningGenerator.h"

@implementation HKAlertTransitioningGenerator

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval interval = 0.f;
    switch (self.transitioningStyle) {
        case HKAlertTransitioningStyleFadeInOut:
            interval = 0.25f;
            break;
            
        default:
            break;
    }
    return interval;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (HKAlertTransitioningTypePresent == self.transitioningType) {
        [self presentTransitioningAnimation:transitionContext];
    } else if (HKAlertTransitioningTypeDismiss == self.transitioningType) {
        [self dismissTransitioningAnimation:transitionContext];
    }
}

#pragma mark - Animation Functions

- (void)presentTransitioningAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitioningStyle) {
        case HKAlertTransitioningStyleFadeInOut:
            [self fadeInAlertTransitioningAnimation:transitionContext];
            break;
            
        default:
            [self fadeInAlertTransitioningAnimation:transitionContext];
            break;
    }
}

- (void)dismissTransitioningAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitioningStyle) {
        case HKAlertTransitioningStyleFadeInOut:
            [self fadeOutAlertTransitioningAnimation:transitionContext];
            break;
            
        default:
            [self fadeOutAlertTransitioningAnimation:transitionContext];
            break;
    }
}

- (void)fadeInAlertTransitioningAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toController.view.alpha = 0.f;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
        toController.view.alpha = 1.f;
    }
                     completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)fadeOutAlertTransitioningAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
        fromController.view.alpha = 0.f;
    }
                     completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
