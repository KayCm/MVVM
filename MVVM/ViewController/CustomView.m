//
//  CustomView.m
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "CustomView.h"

#import "WeatherModel.h"

@interface CustomView ()

@property(nonatomic,strong)UILabel *lbl;
@property(nonatomic,strong)UILabel *ModelLbl;

@end

@implementation CustomView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        
        UIStackView *usv = [[UIStackView alloc] initWithFrame:CGRectMake(0, frame.size.height-60, frame.size.width, 60)];
        
        usv.axis = UILayoutConstraintAxisHorizontal;
        
        usv.alignment = UIStackViewAlignmentFill;
        
        usv.distribution = UIStackViewDistributionFillEqually;
        
        usv.spacing = 1.0f;
        
        [self addSubview:usv];
        
        UIButton *DelegateBtn = [self btnInitWithString:@"Delegate"];
        UIButton *BlockBtn    = [self btnInitWithString:@"Block"];
        UIButton *NotiBtn     = [self btnInitWithString:@"Notification"];
        
        [usv addArrangedSubview:DelegateBtn];
        [usv addArrangedSubview:BlockBtn];
        [usv addArrangedSubview:NotiBtn];
        
        [DelegateBtn addTarget:self action:@selector(clickDelegate) forControlEvents:UIControlEventTouchUpInside];
        [BlockBtn addTarget:self action:@selector(clickBlock) forControlEvents:UIControlEventTouchUpInside];
        [NotiBtn addTarget:self action:@selector(clickNoti) forControlEvents:UIControlEventTouchUpInside];
        
        _lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/2-50, frame.size.width, 50)];
        
        _lbl.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lbl];
        
        _ModelLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/2+50, frame.size.width, 50)];
        
        _ModelLbl.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_ModelLbl];
        
    }
    
    return self;
}

-(void)clickDelegate
{
    _ModelLbl.text = @"Delegate";
    _lbl.text = @"";
    if ([self.Delegate respondsToSelector:@selector(ViewDelegateClick)]) {
        
        [self.Delegate performSelector:@selector(ViewDelegateClick) withObject:nil];
        
    }
}

-(void)clickBlock
{
    _ModelLbl.text = @"Block";
    _lbl.text = @"";
    if (self.BlockClick) self.BlockClick();
}

-(void)clickNoti
{
    _ModelLbl.text = @"Notification";
    _lbl.text = @"";
    if (self.NotiClick) self.NotiClick();
}


-(void)ViewInitWith:(WeatherModel*)Model
{
    _lbl.text = [NSString stringWithFormat:@"%@,%@,%@",Model.citynm,Model.weather,Model.temperature_curr];
    
}

-(UIButton*)btnInitWithString:(NSString*)String
{
    
    UIButton *btn = [UIButton new];
    
    btn.backgroundColor = [UIColor darkGrayColor];
    
    [btn setTitle:String forState:UIControlStateNormal];
    
    return btn;
    
}

@end
