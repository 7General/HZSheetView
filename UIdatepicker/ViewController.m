//
//  ViewController.m
//  UIdatepicker
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//



#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "ViewController.h"
#import "CustomDatePicker.h"

@interface ViewController ()<CustomDatePickerDataSource,CustomDatePickerDelegate>

//@property (nonatomic, strong) UIPickerView * pickView;

@property (nonatomic, strong) NSMutableArray * dataArry;


@property (nonatomic, strong) CustomDatePicker * pickerView;

@end

@implementation ViewController

-(CustomDatePicker *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [CustomDatePicker new];
        _pickerView.frame = CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        _pickerView.backgroundColor = [UIColor redColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *plusButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(100, 100, 110, 110);
    plusButton.backgroundColor = [UIColor redColor];
    [plusButton addTarget:self action:@selector(showPICKERvIEW) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:plusButton];
    
   
    [self.view addSubview:self.pickerView];
    
    
    self.dataArry = @[@"中国人名解放军",@"中国人名空军",@"中国人名解陆军",@"中国人名解军委主席"].mutableCopy;
    
    
    
    
}
-(void)showPICKERvIEW {
    NSLog(@"=-------");
    UIWindow * windw = [self getCurrentWindowView];
    windw.backgroundColor = [UIColor redColor];
    
    
    
    //[YSColor(0, 0, 0) colorWithAlphaComponent:0.5];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        CGRect rect = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200);
//        self.pickerView.frame = rect;
//        
//       
//    }];
//    [self.pickerView selectRow:((self.dataArry.count * 0.5)  - 1) compant:0 withAnimate:YES];
}

-(NSInteger)CpickerView:(UIPickerView *)pickerView numberOfRowsInPicker:(NSInteger)component {
    return self.dataArry.count;
}
-(NSAttributedString *)CpickerView:(UIPickerView *)pickerView attributedTitleForRowTtile:(NSInteger)row forComponent:(NSInteger)component {
    NSString * reStr = self.dataArry[row];
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:reStr];
    // 修改富文本中的不同文字的样式
    [attriStr addAttribute:NSForegroundColorAttributeName value:YSColor(88, 164, 240) range:NSMakeRange(0, reStr.length)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, reStr.length)];

    return attriStr;
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
