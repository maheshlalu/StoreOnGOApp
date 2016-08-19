//
//  CXHeaderView.m
//  StoreOnGoApp
//
//  Created by Rama kuppa on 29/05/16.
//  Copyright © 2016 CX. All rights reserved.
//

#import "CXHeaderView.h"
#import <CoreData+MagicalRecord.h>

@implementation CXHeaderView {

    UILabel *titileLbl;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

//-(id)initWithSegmentedBarFrame:(CGRect)frame andTitle:(NSArray*)titlesArr andDelegate:(id)delegate currentViewVisible:(BOOL)isVisible{
//    
//    self.segmentedDelegate = delegate;
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        [self loadSegmentedViewWithTitleArray:titlesArr andDelegate:delegate currentViewVisible:isVisible];
//    }
//    return self;
//
//}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible profileBtnVisible:(BOOL)appear isForgot:(BOOL)yes isLogout:(BOOL)yesLogout;
{
    self.delegate = delegate;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateCartBtnAction:)
                                                     name:@"updateCartBtnAction"
                                                   object:nil];
        
        [self setBackgroundColor:[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
        [self loadSubViewsandTitle:inTitle andDelegate:self backButtonVisible:isVisible cartBtnVisible:visible profileBtnVisible:appear isForgot:yes isLogout:yesLogout];
    }
    return self;
}


-(void)updateCartBtnAction:(NSNotification *)notification {
    
    NSString *cartCount = [self cartCount];
    if (![cartCount isEqualToString:@""]) {
        [self.cartBtn setBadgeString:cartCount];
        [self.cartBtn setBadgeBackgroundColor:[UIColor redColor]];
        [self.cartBtn setBadgeTextColor:[UIColor whiteColor]];
    }else{
        [self.cartBtn setBadgeString:@""];
        [self.cartBtn setBadgeBackgroundColor:[UIColor clearColor]];
        [self.cartBtn setBadgeTextColor:[UIColor clearColor]];
        
    }
}

//-(void)loadSegmentedViewWithTitleArray:(NSArray*)titlesArr andDelegate:(id)delegate currentViewVisible:(BOOL)isVisible{
//    //CGRect  screenSize  = [[UIScreen mainScreen] bounds];
//    UIButton *viewBtn = [self createSegmentedBtnWithFrame:CGRectMake(5, 10, 40, 10)];
//    [viewBtn setBackgroundColor:[UIColor blueColor]];
//    
//    UIImageView *separator =[[UIImageView alloc] initWithFrame:CGRectMake(viewBtn.frame.size.width+5,10,2,viewBtn.frame.size.height)];
//    separator.image=[UIImage imageNamed:@"separator"];
//    [self addSubview:separator];
//    
//    
//    if (isVisible) {
//        viewBtn.titleLabel.textColor = [UIColor redColor];
//    }
//    
//    
//    
//}

- (void)loadSubViewsandTitle:(NSString*)inTitle andDelegate:(id)delegate backButtonVisible:(BOOL)isVisible cartBtnVisible:(BOOL)visible profileBtnVisible:(BOOL)appear isForgot:(BOOL)yes isLogout:(BOOL)yesLogout{
    
  //  UILabel *titleLbl = [];
    
    CGRect  screenSize  = [[UIScreen mainScreen] bounds];
    UIButton *backBtn = [self createButtonWithFrame:CGRectMake(10, 20, 35, 40) backroundImageView:[UIImage imageNamed:@"appLogo"] isCartButton:NO];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    self.cartBtn= [self cartButtonCreationWithFrame:CGRectMake(screenSize.size.width-60, 26, 30, 30) backroundImageView:[UIImage imageNamed:@"cart"] isCartButton:YES];//90
    self.profileBtn= [self createProfileBtnWithFrame:CGRectMake(screenSize.size.width-25, 32, 20, 20) backroundImageView:[UIImage imageNamed:@"profileBtn"] isProfileButton:YES];

    if (isVisible) {
        [backBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backImg"] forState:UIControlStateNormal];
        
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(backBtn.frame.size.width + 5, 20, 35, 40)];
        dot.image=[UIImage imageNamed:@"appLogo"];
        [self addSubview:dot];
        
        [self addSubview:self.profileBtn];
        
        
    }else{
        backBtn.userInteractionEnabled = NO;
    }
    
    if (visible) {
        [self addSubview:self.cartBtn];
    }else if (appear == NO){
        self.cartBtn.frame = CGRectMake(screenSize.size.width-50, 26, 30, 30);
        self.profileBtn.hidden = YES;
    }else if (yes == YES){
        self.isSignInUp = YES;
    }else{}
    
    if (yesLogout == YES){
        self.isLogout = YES;
    }

    //imageView.tint = [UIColor redColor];
    [self addSubview:backBtn];
    
   
    titileLbl = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.frame.size.width+20+35+5, 20, 200, 40)];
    titileLbl.text = inTitle;
    titileLbl.textColor = [UIColor whiteColor];
    titileLbl.textAlignment = NSTextAlignmentLeft;
    titileLbl.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
    if (!isVisible) {
        titileLbl.frame = CGRectMake(backBtn.frame.size.width+20, 20, 200, 40);
    }
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

//- (void)segmentedButtonAction{
//    
//    if ([self.segmentedDelegate respondsToSelector:@selector(segmentedButtonAction)]) {
//        [self.segmentedDelegate segmentedButtonAction];
//    }
//    
//}


- (void)profileBtnAction:(UIButton*)btn{
    NSLog(@"signinup: %d",self.isSignInUp);
    NSLog(@"signinup: %d",self.isLogout);
    
    NSString *sendName = [[NSBundle mainBundle] localizedStringForKey:@"Profile" value:@"" table:nil];
    NSString *schuName = [[NSBundle mainBundle] localizedStringForKey:@"Logout" value:@"" table:nil];
    NSString *forgotpass = [[NSBundle mainBundle] localizedStringForKey:@"Forgot Password?" value:@"" table:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CAPopUpViewController *popup = [[CAPopUpViewController alloc] init];
        if (self.isLogout) {
            popup.itemsArray = @[sendName, schuName];
        }else if(self.isSignInUp){
            popup.itemsArray = @[forgotpass];
        }else{
            popup.itemsArray = @[sendName];
        }
        popup.sourceView = btn;
        popup.backgroundColor = [UIColor whiteColor];
        popup.backgroundImage = nil;
        popup.itemTitleColor = [UIColor blackColor];
        popup.itemSelectionColor = [UIColor lightGrayColor];
        popup.arrowDirections = UIPopoverArrowDirectionAny;
        popup.arrowColor = [UIColor whiteColor];
        [popup setPopCellBlock:^(CAPopUpViewController *popupVC, UITableViewCell *popupCell, NSInteger row, NSInteger section) {
            if ([popupCell.textLabel.text isEqualToString:sendName]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [popupVC dismissViewControllerAnimated:YES completion:^{
                        if (self.isLogout) {
                            [self.delegate navigateToProfilepage];
                        }else{
                        [self.delegate navigationProfileandLogout:self.isLogout];
                        }
                    }];
                });
                
            } else if ([popupCell.textLabel.text isEqualToString:schuName]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [popupVC dismissViewControllerAnimated:YES completion:^{
                        [self logout];
                        [self.delegate userLogout];
                    }];
                });
            } else if ([popupCell.textLabel.text isEqualToString:forgotpass]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [popupVC dismissViewControllerAnimated:YES completion:^{
                        [self.delegate navigationProfileandLogout:self.isLogout];
                    }];
                });
            }
        }];
        [self.delegate presentViewController:popup];
        
    });
    
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
    
    NSString *cartCount = [self cartCount];
    if (![cartCount isEqualToString:@""]) {
        [cartBtn setBadgeString:cartCount];
        [cartBtn setBadgeBackgroundColor:[UIColor redColor]];
        [cartBtn setBadgeTextColor:[UIColor whiteColor]];
    }
    
    

    cartBtn.showsTouchWhenHighlighted = YES;

    return cartBtn;
}

- (UIButton*)createButtonWithFrame:(CGRect)frame backroundImageView:(UIImage*)inImage isCartButton:(BOOL)isCartBtn {

    UIButton *backBtn = [[UIButton alloc] initWithFrame:frame];
    backBtn.showsTouchWhenHighlighted = YES;
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn setBackgroundImage:inImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
        return backBtn;
    
}

- (UIButton*)createProfileBtnWithFrame:(CGRect)frame backroundImageView:(UIImage*)inImage isProfileButton:(BOOL)isProfileBtn{
    
    UIButton *profileBtn = [[UIButton alloc] initWithFrame:frame];
    profileBtn.showsTouchWhenHighlighted = YES;
    profileBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [profileBtn setBackgroundImage:inImage forState:UIControlStateNormal];
    [profileBtn addTarget:self action:@selector(profileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:profileBtn];
    return profileBtn;
}
//
//- (UIButton*)createSegmentedBtnWithFrame:(CGRect)frame{
//    
//    UIButton *profileBtn = [[UIButton alloc] initWithFrame:frame];
//    profileBtn.showsTouchWhenHighlighted = YES;
//    profileBtn.titleLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
//    profileBtn.titleLabel.textColor = [UIColor blackColor];
//    profileBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [profileBtn addTarget:self action:@selector(segmentedButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:profileBtn];
//    return profileBtn;
//}

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
    if (results.count !=0)
    return [NSString stringWithFormat:@"%lu",(unsigned long)results.count];
    return @"";
}

-(void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"STATE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_EMAIL"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FIRST_NAME"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LAST_NAME"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_BANNER_PATH"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GENDER"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_IMAGE_PATH"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_ID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MAC_ID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MOBILE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ADDRESS"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FULL_NAME"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CITY"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ORG_ID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MACID_JOBID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ORGANIZATION"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MESSAGE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"COUNTRY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




@end
