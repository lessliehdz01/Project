//
//  LIHInputViewController.h
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class LIHInputViewController;

@protocol LIHInputViewControllerDelegate  <NSObject>

-(void)inputController:(LIHInputViewController *)controller didFinishWithText:(NSString *)text getTitle:(NSString *)title getPhoto:(NSObject *)photo;

@end


@interface LIHInputViewController : UIViewController

@property (nonatomic, weak) id<LIHInputViewControllerDelegate> delegate;


@end
