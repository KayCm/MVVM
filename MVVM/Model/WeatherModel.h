//
//  WeatherModel.h
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property(nonatomic,strong)NSString* cityid;
@property(nonatomic,strong)NSString* citynm;
@property(nonatomic,strong)NSString* cityno;
@property(nonatomic,strong)NSString* days;
@property(nonatomic,strong)NSString* humi_high;
@property(nonatomic,strong)NSString* humi_low;
@property(nonatomic,strong)NSString* humidity;
@property(nonatomic,strong)NSString* temp_curr;
@property(nonatomic,strong)NSString* temp_high;
@property(nonatomic,strong)NSString* temp_low;
@property(nonatomic,strong)NSString* temperature;
@property(nonatomic,strong)NSString* temperature_curr;
@property(nonatomic,strong)NSString* weaid;
@property(nonatomic,strong)NSString* weather;
@property(nonatomic,strong)NSString* weather_icon;
@property(nonatomic,strong)NSString* weather_icon1;
@property(nonatomic,strong)NSString* weatid;
@property(nonatomic,strong)NSString* weatid1;
@property(nonatomic,strong)NSString* week;
@property(nonatomic,strong)NSString* wind;
@property(nonatomic,strong)NSString* windid;
@property(nonatomic,strong)NSString* winp;
@property(nonatomic,strong)NSString* winpid;


-(id)initWithDictionary:(NSDictionary*)dic;

@end
