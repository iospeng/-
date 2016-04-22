//
//  ViewController.m
//  倒计时2
//
//  Created by 李志鹏 on 16/4/22.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) UILabel *lab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _lab.textColor = [UIColor blackColor];
    [self.view addSubview:_lab];
    
    NSTimer * timers = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    [timers fire];
    
    
}

//计算时间差，倒计时
-(void)timeCha
{
    //规定日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取当前系统时间
    NSDate *date = [NSDate date];
    //将时间（NSDdate）转换为（NSString）
    NSString *date1str = [formatter stringFromDate:date];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    //NSLog(@"%@",localeDate);
    
    //自己指定时间
    NSDate *MYdate = [formatter dateFromString:@"2016-04-22 14:00:00"];
    //解决八小时时差
    NSInteger ziint =[zone secondsFromGMTForDate:MYdate];
    NSDate *ziloca = [MYdate dateByAddingTimeInterval:ziint];
    
    //系统时间转换为毫秒
    long long int xiHao= floor([date timeIntervalSince1970]*1000);
    //自己的时间转换为毫秒
    long long int MYhao = floor([ziloca timeIntervalSince1970]*1000);
    if (MYhao > xiHao) {
        long long int cha = MYhao - xiHao;
        
        //将毫秒值得差转换为时间（NSDate）
        NSDate *chadates = [NSDate dateWithTimeIntervalSince1970:cha/1000];
        
        //解决八小时时差
        NSInteger interval = [zone secondsFromGMTForDate:chadates];
        NSDate *localedate = [chadates dateByAddingTimeInterval:interval];
        
        //再将NSDate转换为NSString
        //NSString *strcha = [formatter stringFromDate:chadates];
        NSString * strcha = [formatter stringFromDate:localedate];
        
        NSDate *chad = [formatter dateFromString:strcha];
        
        //        NSInteger interval = [zone secondsFromGMTForDate:chad];
        //        NSDate *localedate = [chad dateByAddingTimeInterval:interval];
        //字符串截取
        NSString *shi = [strcha substringWithRange:NSMakeRange(11, 8)];
        //NSLog(@"时间差%@",shi);
        _lab.text = shi;
        
    }else
    {
        NSLog(@"对比时间小于当前系统时间");
    }
//    //输出系统时间（毫秒值）
//    NSLog(@"系统时间毫秒值%lld",xiHao);
//    //自己时间（毫秒值）
//    NSLog(@"自己时间毫秒值%lld",MYhao);
//    //系统当前时间
//    NSLog(@"当前系统时间%@",date1str);
//    //自己时间
//    NSLog(@"自己时间%@",ziloca);
}

-(void)timerClick
{
    [self timeCha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
