//
//  CustomView.h
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;

@protocol CustomViewDelegate <NSObject>

-(void)ViewDelegateClick;

@end

@interface CustomView : UIView

@property(nonatomic,weak)id<CustomViewDelegate> Delegate;

@property(nonatomic,copy)void(^BlockClick)();
@property(nonatomic,strong)void(^NotiClick)();

-(void)ViewInitWith:(WeatherModel*)Model;

@end
