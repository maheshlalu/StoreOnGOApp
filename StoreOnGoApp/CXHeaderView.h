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
//-(void)presentViewController:(CAPopUpViewController*)popUpView animated:(BOOL)isSignInUp completion:(void (^ _Nullable)(void))completion;


//- (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes))blockName;
//+ (void)myMethod:(UIView *)exampleView completion:(void (^)(BOOL finished))completion {
//if (completion) {
//    completion(finished);
//}

@end

@interface CXHeaderView : UIView <UIActionSheetDelegate>{
}

@property (nonatomic,strong) MIBadgeButton *cartBtn;
@property (nonatomic,strong) UIButton *profileBtn;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible profileBtnVisible:(BOOL)appear;

@property (nonnull,assign) id <HeaderViewDelegate> delegate;
@property (assign)  BOOL isLogout;
@property (assign)  BOOL isSignInUp;
@end


