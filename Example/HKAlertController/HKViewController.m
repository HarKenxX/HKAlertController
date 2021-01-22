//
//  HKViewController.m
//  HKAlertController_Example
//
//  Created by Harken on 2021/1/22.
//  Copyright © 2021 Harken. All rights reserved.
//

#import "HKViewController.h"
#import "HKAlertController.h"

@interface HKViewController ()

@end

@implementation HKViewController

#pragma mark - Alert Functions

- (IBAction)horizontalButtonAlertCenter:(id)sender {
    HKAlertController *alertController = [HKAlertController alertControllerWithTitle:@"Horizontal Alert"
                                                                             message:@"Single Line + Center Align"
                                                                      preferredStyle:HKAlertViewStyleHorizontal];
    alertController.titleAlignment = NSTextAlignmentCenter;
    alertController.messageAlignment = NSTextAlignmentCenter;
    
    HKAlertAction *cancelAction = [HKAlertAction actionWithTitle:@"Cancel"
                                                           style:HKAlertActionStyleCancel
                                                         handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    HKAlertAction *confirmAction = [HKAlertAction actionWithTitle:@"Confirm"
                                                            style:HKAlertActionStyleDefault
                                                          handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)horizontalButtonAlert:(id)sender {
    HKAlertController *alertController = [HKAlertController alertControllerWithTitle:@"Horizontal Alert"
                                                                             message:@"Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line"
                                                                      preferredStyle:HKAlertViewStyleHorizontal];
    
    HKAlertAction *cancelAction = [HKAlertAction actionWithTitle:@"Cancel"
                                                           style:HKAlertActionStyleCancel
                                                         handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    HKAlertAction *confirmAction = [HKAlertAction actionWithTitle:@"Confirm"
                                                            style:HKAlertActionStyleDefault
                                                          handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)oneButtonAlert:(id)sender {
    HKAlertController *alertController = [HKAlertController alertControllerWithTitle:nil
                                                                             message:@"Toast Alert"
                                                                      preferredStyle:HKAlertViewStyleVertical];
    alertController.messageAlignment = NSTextAlignmentCenter;
    HKAlertAction *confirmAction = [HKAlertAction actionWithTitle:@"Try Click BG ~"
                                                            style:HKAlertActionStyleDefault
                                                          handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [alertController addCancelAction:^{
        
    }];
    [alertController show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HKAlertController dismiss];
    });
}

- (IBAction)verticalButtonAlert:(id)sender {
    HKAlertController *alertController = [HKAlertController alertControllerWithTitle:@"Vertical Alert"
                                                                             message:@"Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line Multi-Line"
                                                                      preferredStyle:HKAlertViewStyleVertical];
    
    HKAlertAction *cancelAction = [HKAlertAction actionWithTitle:@"Cancel"
                                                           style:HKAlertActionStyleCancel
                                                         handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    HKAlertAction *otherAction = [HKAlertAction actionWithTitle:@"Disable"
                                                          style:HKAlertActionStyleDefault
                                                        handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:otherAction];
    otherAction.enabled = NO;
    
    HKAlertAction *confirmAction = [HKAlertAction actionWithTitle:@"Confirm"
                                                            style:HKAlertActionStyleDefault
                                                          handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)verticalButtonAlertCenter:(id)sender {
    HKAlertController *alertController = [HKAlertController alertControllerWithTitle:@"Vertical Alert"
                                                                             message:@"Single Line - Center Align"
                                                                      preferredStyle:HKAlertViewStyleVertical];
    alertController.titleAlignment = NSTextAlignmentCenter;
    alertController.messageAlignment = NSTextAlignmentCenter;
    
    HKAlertAction *cancelAction = [HKAlertAction actionWithTitle:@"Cancel"
                                                           style:HKAlertActionStyleCancel
                                                         handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    HKAlertAction *confirmAction = [HKAlertAction actionWithTitle:@"Confirm"
                                                            style:HKAlertActionStyleDefault
                                                          handler:^(HKAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
