//
//  LIHInputViewController.h
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LIHInputViewController;

@protocol LIHInputViewControllerDelegate  <NSObject>

-(void)inputController:(LIHInputViewController *)controller didFinishWithText:(NSString *)text getTitle:(NSString *)title;

@end


@interface LIHInputViewController : UIViewController

@property (nonatomic, weak) id<LIHInputViewControllerDelegate> delegate;


@end
