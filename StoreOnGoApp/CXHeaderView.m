//
//  CXHeaderView.m
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

#import "CXHeaderView.h"
#import <CoreData+MagicalRecord.h>

@implementation CXHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible;
{
    self.delegate = delegate;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor grayColor]];
        [self loadSubViewsandTitle:inTitle andDelegate:self backButtonVisible:isVisible cartBtnVisible:visible];
    }
    return self;
}



- (void)loadSubViewsandTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible{
    
  //  UILabel *titleLbl = [];
    
    CGRect  screenSize  = [[UIScreen mainScreen] bounds];
    UIButton *backBtn = [self createButtonWithFrame:CGRectMake(10, 20, 35, 40) backroundImageView:[UIImage imageNamed:@"appLogo"] isCartButton:NO];
    self.cartBtn= [self cartButtonCreationWithFrame:CGRectMake(screenSize.size.width-60, 15, 50, 50) backroundImageView:[UIImage imageNamed:@"cart"] isCartButton:YES];
    
    if (isVisible) {
        [backBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backImg"] forState:UIControlStateNormal];
        
    }else{
        backBtn.userInteractionEnabled = NO;
    }
    if (visible) {
        [self addSubview:self.cartBtn];
    }

    //imageView.tint = [UIColor redColor];
    [self addSubview:backBtn];
    
    
    UILabel *titileLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 40)];
    titileLbl.text = inTitle;
    titileLbl.textColor = [UIColor whiteColor];
    titileLbl.textAlignment = NSTextAlignmentCenter;
    titileLbl.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
    [self addSubview:titileLbl];
    
    
}

- (void)buttonAction{
    
    if ([self.delegate respondsToSelector:@selector(backButtonAction)]) {
        [self.delegate backButtonAction];
    }
    
}

- (void)cartButtonAction{
    
    if ([self.delegate respondsToSelector:@selector(backButtonAction)]) {
        [self.delegate cartButtonAction];
    }
    
}


- (MIBadgeButton*)cartButtonCreationWithFrame:(CGRect)frame backroundImageView:(UIImage*)inImage isCartButton:(BOOL)isCartBtn{
    
    MIBadgeButton *cartBtn = [MIBadgeButton buttonWithType:UIButtonTypeCustom];
    cartBtn.frame = frame;
    [cartBtn addTarget:self action:@selector(cartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    cartBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cartBtn setBackgroundImage:inImage forState:UIControlStateNormal];
    [cartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // optional to change the default position of the badge
    [cartBtn setBadgeEdgeInsets:UIEdgeInsetsMake(20, 5, 0,20)];
    [cartBtn setBadgeString:[self cartCount]];
    [cartBtn setBadgeTextColor:[UIColor whiteColor]];
    cartBtn.showsTouchWhenHighlighted = YES;
    [cartBtn setBadgeBackgroundColor:[UIColor redColor]];

    return cartBtn;
}

- (UIButton*)createButtonWithFrame:(CGRect)frame backroundImageView:(UIImage*)inImage isCartButton:(BOOL)isCartBtn {

    UIButton *backBtn = [[UIButton alloc] initWithFrame:frame];
    backBtn.showsTouchWhenHighlighted = YES;
    //backBtn.titleLabel.text = @"Back";
    //backBtn.imageView.image = inImage;
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn setBackgroundImage:inImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
        return backBtn;
    
}


- (NSString*)cartCount{
    
//    NSEntityDescription *entity = [NSEntityDescription];
//    let productEn = NSEntityDescription.entityForName("CX_Cart", inManagedObjectContext: NSManagedObjectContext.MR_contextForCurrentThread())
//    let fetchRequest = CX_Cart.MR_requestAllSortedBy("name", ascending: true)
//    // fetchRequest.predicate = predicate
//    fetchRequest.entity = productEn
//    self.productsList.addObjectsFromArray( CX_Cart.MR_executeFetchRequest(fetchRequest))
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CX_Cart"];
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        
        //Deal with failure
    }
    else {
        
        //Deal with success
    }

    return [NSString stringWithFormat:@"%lu",(unsigned long)results.count];
}





@end
