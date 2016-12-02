//
//  CustomDatePicker.m
//  UIdatepicker
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#define CurrentWindow [self getCurrentWindowView]

#define DDMWIDTH [UIScreen mainScreen].bounds.size.width

#define DDMHEIGHT [UIScreen mainScreen].bounds.size.height

#define DDMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define SHEETHEIGHT 270

#import "CustomDatePicker.h"

@interface CustomDatePicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, weak) UIPickerView * pickView;

@property (nonatomic, weak) UIView * mainView;

@property (nonatomic, strong) NSString * sureBtnTitle;
@property (nonatomic, strong) NSString * otherButtonTitle;

@property (nonatomic, assign) NSInteger  selectIndex;

@end

@implementation CustomDatePicker

- (id)initWithSureBtnTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle
{
    if(self = [super init])
    {
        [self initView];
        self.sureBtnTitle = title;
        self.otherButtonTitle = otherButtonTitle;
    }
    return self;
}


-(void)initView {
    self.frame = CurrentWindow.frame;
    [CurrentWindow addSubview:self];
    
    UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(0, DDMHEIGHT ,DDMWIDTH, SHEETHEIGHT)];
    [self addSubview:mainView];
    self.mainView  = mainView;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
    [self addGestureRecognizer:tap];
    
    
    
    
    
}

-(void)dismisView {
    [UIView animateWithDuration:0.33 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.mainView.frame = CGRectMake(0, DDMHEIGHT, DDMWIDTH, SHEETHEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setDataSource:(id<CustomDatePickerDataSource>)dataSource {
    _dataSource = dataSource;
    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, SHEETHEIGHT)];
    pickView.backgroundColor = DDMColor(245, 245,245);
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.mainView addSubview:pickView];
    self.pickView = pickView;
    
    UIView * topConsole = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, 46)];
    topConsole.backgroundColor = DDMColor(255, 255, 255);
    [self.mainView addSubview:topConsole];
    
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:self.sureBtnTitle forState:UIControlStateNormal];
    [cancleBtn setTitleColor:DDMColor(80, 80, 80) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleBtn addTarget:self action:@selector(CancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.frame = CGRectMake(18, 0, 38, 46);
    [topConsole addSubview:cancleBtn];
    
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:self.otherButtonTitle forState:UIControlStateNormal];
    [sureBtn setTitleColor:DDMColor(75, 196, 251) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    sureBtn.frame = CGRectMake(DDMWIDTH - 18 - 38, 0, 38, 46);
    [sureBtn addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topConsole addSubview:sureBtn];
}
/**取消*/
-(void)CancleBtnClick {
    [self dismisView];
}
/**确定*/
-(void)SureBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CpickerViewdidSelectRow:)]) {
        [self.delegate CpickerViewdidSelectRow:self.selectIndex];
    }
    [self dismisView];
}


- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        CGRect rect = CGRectMake(0, DDMHEIGHT - SHEETHEIGHT, DDMWIDTH, SHEETHEIGHT);
        self.mainView.frame = rect;
    }];
}

-(void)selectRow:(NSInteger)rows compant:(NSInteger)Compant withAnimate:(BOOL)Animate {
    if (rows <= 0) {
        return;
    }
    [self.pickView selectRow:rows inComponent:Compant animated:Animate];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(CpickerView:numberOfRowsInPicker:)]) {
        return [self.dataSource CpickerView:pickerView numberOfRowsInPicker:component];
    }else {
        return 0;
    }
}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSAttributedString * attribStr = nil;
//    if (self.dataSource && [self.dataSource respondsToSelector:@selector(CpickerView:attributedTitleForRowTtile:forComponent:)]) {
//        attribStr = [self.dataSource CpickerView:pickerView attributedTitleForRowTtile:row forComponent:component];
//    }
//    return  attribStr;
//}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UIView * resView = [[UIView alloc] init];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(CpickerView:viewForRow:forComponent:reusingView:)]) {
        resView = [self.dataSource CpickerView:pickerView viewForRow:row forComponent:component reusingView:view];
    }
    return  resView;
}





-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if (self.delegate && [self.delegate respondsToSelector:@selector(CpickerView:rowHeightForPicker:)]) {
        return [self.delegate CpickerView:pickerView rowHeightForPicker:component];
    }else {
        return 25;
    }
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
