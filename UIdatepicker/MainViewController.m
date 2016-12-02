//
//  MainViewController.m
//  UIdatepicker
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//


#define CurrentWindow [self getCurrentWindowView]

#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "MainViewController.h"
#import "CustomDatePicker.h"

@interface MainViewController ()<CustomDatePickerDataSource,CustomDatePickerDelegate>

@property (nonatomic, strong) CustomDatePicker * pickerView;

@property (nonatomic, strong) NSMutableArray * dataArry;

@property (nonatomic, strong) NSString * selectStr;
@end



@implementation MainViewController
-(NSMutableArray *)dataArry {
    if (_dataArry == nil) {
        _dataArry = [NSMutableArray new];
    }
    return _dataArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *plusButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(100, 100, 110, 110);
    plusButton.backgroundColor = [UIColor redColor];
    [plusButton addTarget:self action:@selector(showpickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:plusButton];
    
//    self.dataArry = @[@"中国人名解放军",@"中国人名空军",@"中国人名解陆军",@"中国人名解军委主席"].mutableCopy;

    [self getWeakDay];
}


-(void)getWeakDay {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (int days = 0; days < 23; days ++) {
        NSString *dateString = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:days * secondsPerDay]];
        NSString * xq = [self calculateWeek:dateString];
        if (![xq isEqualToString:@"周日"] && ![xq isEqualToString:@"周六"]) {
            NSString * itemStr = [NSString stringWithFormat:@"%@(%@)",dateString,xq];
            [self.dataArry addObject:itemStr];
        }
    }
}





- (NSString *)calculateWeek:(NSString *)dateStr{
    NSString* string = dateStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:inputDate] weekday];
    switch (week) {
        case 1:
        {
            return @"周日";
        }
        case 2:
        {
            return @"周一";
        }
        case 3:
        {
            return @"周二";
        }
        case 4:
        {
            return @"周三";
        }
        case 5:
        {
            return @"周四";
        }
        case 6:
        {
            return @"周五";
        }
        case 7:
        {
            return @"周六";
        }
    }
    
    return @"";
}









-(void)showpickerView {
    CustomDatePicker * pickerView = [[CustomDatePicker alloc] initWithSureBtnTitle:@"取消" otherButtonTitle:@"确定"];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [pickerView show];
}





-(NSInteger)CpickerView:(UIPickerView *)pickerView numberOfRowsInPicker:(NSInteger)component {
    return self.dataArry.count;
}

-(UIView *)CpickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel * cellTitle = [[UILabel alloc] init];
    cellTitle.text = self.dataArry[row];
    cellTitle.textColor = [UIColor redColor];
    cellTitle.textAlignment = NSTextAlignmentCenter;
    
    return cellTitle;
}



-(void)CpickerViewdidSelectRow:(NSInteger)row {
    NSLog(@"-----%ld",row);
}

-(CGFloat)CpickerView:(UIPickerView *)pickerView rowHeightForPicker:(NSInteger)component {
    return 43;
}


/**获取当前window*/
- (UIWindow *)getCurrentWindowView {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}


@end
