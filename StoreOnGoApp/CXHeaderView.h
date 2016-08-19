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
- (void)navigationProfileandLogout:(BOOL)isProfile;
- (void)navigateToProfilepage;
-(void)userLogout;
@end
//
//@protocol HeaderViewSegmentedDelegate <NSObject>
//-(void)segmentedButtonAction;
//@end

@interface CXHeaderView : UIView <UIActionSheetDelegate>{
}

@property (nonatomic,strong) MIBadgeButton *cartBtn;
@property (nonatomic,strong) UIButton *profileBtn;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible profileBtnVisible:(BOOL)appear isForgot:(BOOL)yes isLogout:(BOOL)yesLogout;

//-(id)initWithSegmentedBarFrame:(CGRect)frame andTitle:(NSArray*)titlesArr andDelegate:(id)delegate currentViewVisible:(BOOL)isVisible;

@property (nonnull,assign) id <HeaderViewDelegate> delegate;
//@property (nonnull,assign) id <HeaderViewSegmentedDelegate> segmentedDelegate;
@property (assign)  BOOL isLogout;
@property (assign)  BOOL isSignInUp;
@end


