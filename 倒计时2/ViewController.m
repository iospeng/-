//
//  ViewController.m
//  倒计时2
//
//  Created by 李志鹏 on 16/4/22.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    long long int xiHao;
    long long int MYhao;
}
@property (strong,nonatomic) UILabel *lab;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic) NSDateFormatter * formatter;
@property (strong,nonatomic) NSTimeZone *zone;
@property (strong,nonatomic) UITextField *H;
@property (strong,nonatomic) UITextField *M;
@property (strong,nonatomic) UITextField *S;
//自己输入的时间
@property (strong,nonatomic) NSString *shijan;
@property (strong,nonatomic) NSTimer * timers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    UILabel *biao = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _H = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 40, 40)];
    UILabel *fen1 = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 10, 40)];
    _M = [[UITextField alloc] initWithFrame:CGRectMake(170, 150, 40, 40)];
    UILabel *fen2 = [[UILabel alloc] initWithFrame:CGRectMake(220, 150, 10, 40)];
    _S = [[UITextField alloc] initWithFrame:CGRectMake(240, 150, 40, 40)];
    
    
    _lab.textColor = [UIColor blackColor];
    _H.backgroundColor = [UIColor grayColor];
    fen1.textColor = [UIColor blackColor];
    _M.backgroundColor = [UIColor grayColor];
    fen2.textColor = [UIColor blackColor];
    _S.backgroundColor = [UIColor grayColor];
    
    biao.text =@"请输入截止时间";
    fen1.text = @":";
    fen2.text = @":";
    
    
    [self.view addSubview:_lab];
    [self.view addSubview:biao];
    [self.view addSubview:_H];
    [self.view addSubview:fen1];
    [self.view addSubview:_M];
    [self.view addSubview:fen2];
    [self.view addSubview:_S];
    
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
    tap.numberOfTouchesRequired = 1;
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    //计时器
    _timers = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    
    [_timers invalidate];
    
}

//计算时间差，倒计时
-(void)timeCha:(NSString *)HH min:(NSString *)MM se:(NSString *)SS
{
    //规定日期格式
    _formatter = [[NSDateFormatter alloc] init];
    _zone = [NSTimeZone systemTimeZone];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取当前系统时间
    _date = [NSDate date];
//    //将时间（NSDdate）转换为（NSString）
//    NSString *date1str = [_formatter stringFromDate:_date];
//    //解决时差问题
//    NSInteger interval = [_zone secondsFromGMTForDate:_date];
//    NSDate *localeDate = [_date dateByAddingTimeInterval:interval];
    //NSLog(@"%@",localeDate);
    
 
    
    //系统时间转换为毫秒
    xiHao= floor([_date timeIntervalSince1970]*1000);
    
    /*
     *  方案一
     *         在原有的基础上加一个小时
     *
    */
//    //在当前系统时间的基础上加一个小时
//    long long int jia = xiHao + 3600000;
//    //把获得的毫秒转换为自己的时间
//    NSDate *MYdate = [NSDate dateWithTimeIntervalSince1970:jia/1000];
    
    /*
     *  方案二
     *          自己指定时间
     *
     */
    _shijan = [NSString stringWithFormat:@"2016-04-22 %@:%@:%@",HH,MM,SS];
    //自己指定时间
    NSDate *MYdate = [_formatter dateFromString:_shijan];
    //解决八小时时差
    NSInteger ziint =[_zone secondsFromGMTForDate:MYdate];
    NSDate *ziloca = [MYdate dateByAddingTimeInterval:ziint];
    
    //自己的时间转换为毫秒
    MYhao = floor([ziloca timeIntervalSince1970]*1000);

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
    //获取当前系统时间
    _date = [NSDate date];
    //系统时间转换为毫秒
    xiHao= floor([_date timeIntervalSince1970]*1000);
    
    if (MYhao > xiHao) {
        long long int cha = MYhao - xiHao;
        
        //将毫秒值得差转换为时间（NSDate）
        NSDate *chadates = [NSDate dateWithTimeIntervalSince1970:cha/1000];
        
        //解决八小时时差
        NSInteger interval = [_zone secondsFromGMTForDate:chadates];
        NSDate *localedate = [chadates dateByAddingTimeInterval:interval];
        
        //再将NSDate转换为NSString
        //NSString *strcha = [formatter stringFromDate:chadates];
        NSString * strcha = [_formatter stringFromDate:localedate];
        
        NSDate *chad = [_formatter dateFromString:strcha];
        
        //        NSInteger interval = [zone secondsFromGMTForDate:chad];
        //        NSDate *localedate = [chad dateByAddingTimeInterval:interval];
        //字符串截取
        NSString *shi = [strcha substringWithRange:NSMakeRange(11, 8)];
        //NSLog(@"时间差%@",shi);
        //_lab.text = @" ";
        _lab.text = shi;
        
    }else
    {
        NSLog(@"对比时间小于当前系统时间");
    }
}
-(void)tapclick
{
    //获取输入的值
    NSString *H = _H.text;
    NSString *M = _M.text;
    NSString *S = _S.text;
    //正则判断是00到23的数字
    NSString *zheng = @"^((0?[0-9])|(1[0-9])|(2[0-3]))$";
    NSString *zhengM = @"^((0?[0-9])|(1[0-9])|(2[0-9])|(3[0-9])|(4[0-9])|(5[0-9]))";
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zheng];
    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhengM];
    BOOL a = [p evaluateWithObject:H];
    BOOL b = [p1 evaluateWithObject:M];
    BOOL c = [p1 evaluateWithObject:S];
    
    if (a) {
        if (b && M.length == 2) {
            if (c) {
                [self timeCha:H min:M se:S];
                _timers = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
                [_timers fire];
            }else
            {
                NSLog(@"请注意格式  HH:mm:ss");
            }
        }else
        {
            NSLog(@"请注意格式  HH:mm:ss");
        }
    }else
    {
        NSLog(@"请注意格式  HH:mm:ss");
    }
  
   
    [_H resignFirstResponder];
    [_M resignFirstResponder];
    [_S resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
