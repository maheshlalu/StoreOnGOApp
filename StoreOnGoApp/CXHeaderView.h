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
@protocol HeaderViewDelegate <NSObject>

- (void)backButtonAction;
- (void)cartButtonAction;


@end

@interface CXHeaderView : UIView

@property (nonatomic,strong) MIBadgeButton *cartBtn;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible;

@property (nonnull,assign) id <HeaderViewDelegate> delegate;
@end


