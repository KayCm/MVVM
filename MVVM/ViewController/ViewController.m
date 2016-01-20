//
//  ViewController.m
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "ViewController.h"

#import "NetViewModel.h"

#import "WeatherModel.h"

#import "CustomView.h"

#import "ArchiverCache.h"

#import "MD5Encode.h"

#import "KeyChainIO.h"

//#import "UIImageView+AFNetworking.h"
//
//#import "UIImageView+AFNetworking.h"

#import "UIKit+AFNetworking.h"

#define Apiurl "http://api.k780.com:88/?app=weather.today&weaid=101210101&appkey=17173&sign=7f9e8d28cff1fa31bbad01b72163cd0c&format=json"

@interface ViewController ()<NetViewModelDelegate,CustomViewDelegate>
{
    NetViewModel *net;
    CustomView *cv;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    // Do any additional setup after loading the view, typically from a nib.
    
    cv = [[CustomView alloc] initWithFrame:self.view.bounds];
    
    cv.Delegate = self;
    
    [self.view addSubview:cv];

    
    net = [[NetViewModel alloc] init];
   
#pragma mark ======= Cache
    WeatherModel *WM = [net NetViewModelWithCache];
    
    [cv ViewInitWith:WM];
    
#pragma mark ======= Block;
    
    __weak typeof(cv) weakCv = cv;
    __weak typeof(net) weakNet = net;
    
    cv.BlockClick = ^(){
        
        [weakNet NetViewModelWithBlock:^(id returnValue) {
            
            NSLog(@"Block:%@",returnValue);
            
            WeatherModel *wm = (WeatherModel*)returnValue;
            
            [weakCv ViewInitWith:wm];//循环引用  如果在NetViewModel里拆分该方法,block的赋值和调用分开,就可以避免
            
            NSLog(@"Name:%@",wm.citynm);
            
        } SetFailure:^(id FailureVaue) {
            NSLog(@"FailureVaue:%@",FailureVaue);
        } SetError:^(id ErrorValue) {
            NSLog(@"ErrorValue:%@",ErrorValue);
        } SetUrl:@Apiurl];
        
    };
    

    
#pragma mark ======= Noti
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Noti:) name:@"Noti" object:nil];
    
    cv.NotiClick = ^(){
        
         [weakNet NetViewModelWithNotiWithUrl:@Apiurl];
        
    };

    
}


-(UIImage *)getImageForCacheOrDiskOrNetWithKey:(NSString*)Key
{
    
    //cache data
    
    NSCache *cache = [[NSCache alloc] init];
    
    NSData *CacheData =  [cache objectForKey:Key];
    
    if (CacheData != nil) {
        
        
        return [UIImage imageWithData:CacheData];
        
        
    }else{
        
        //Disk read
        
        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        
        NSString *cachePath = [arr firstObject];
        
        NSString *filePath = [cachePath stringByAppendingPathComponent:Key];
        
        NSData *Diskdata = [[NSData alloc] initWithContentsOfFile:filePath];
        
        
        if (Diskdata != nil) {
            
            return [UIImage imageWithData:Diskdata];
            
        }else{
            
            //internet request here;
            
            NSString *imageURLStr = @"http://pic.58pic.com/58pic/15/48/73/04f58PIC37y_1024.png";
            
            NSData *InternetData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
            
            return [UIImage imageWithData:InternetData];
            
        }
    }
    
    
}





#pragma mark ======== NetViewModelDelegate 实现
-(void)NetDelegateSuccessValue:(id)Value
{
    
    WeatherModel *wm = Value;
    
    [cv ViewInitWith:wm];
    
}

-(void)NetDelegateFailureValue:(id)Value
{
    NSLog(@"Delegate:%@",Value);
}


#pragma mark ========= CustomDelegate 实现

-(void)ViewDelegateClick
{
    //#pragma mark ======= Delegate;
    net.Delegate = self;
    
    [net NetViewModelWithDelegateWith:@Apiurl];
    
}


#pragma mark ======== notification 实现
-(void)Noti:(NSNotification*)Noti{
    
    NSLog(@"Noti:%@",Noti.object);
    
    WeatherModel *wm = Noti.object;
    
    [cv ViewInitWith:wm];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
