//
//  CXHeaderView.h
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIBadgeButton.h"
#import "MIBadgeLabel.h"
#import "CAPopUpViewController.h"

@protocol HeaderViewDelegate <NSObject>
- (void)backButtonAction;
- (void)cartButtonAction;
- (void)presentViewController:(CAPopUpViewController*)popUpView;
//- (void)navigationProfileandLogout:(BOOL)isProfile;



@end

@interface CXHeaderView : UIView <UIActionSheetDelegate>

@property (nonatomic,strong) MIBadgeButton *cartBtn;
@property (nonatomic,strong) UIButton *profileBtn;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible;

@property (nonnull,assign) id <HeaderViewDelegate> delegate;
@end


