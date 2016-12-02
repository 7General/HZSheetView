//
//  CustomDatePicker.h
//  UIdatepicker
//
//  Created by 王会洲 on 16/11/21.
//  Copyright © 2016年 王会洲. All rights reserved.
//



#import <UIKit/UIKit.h>



@protocol CustomDatePickerDataSource <NSObject>

@required
/**设置行数数量*/
-(NSInteger)CpickerView:(UIPickerView *)pickerView numberOfRowsInPicker:(NSInteger)component;


@optional
/**设置每行的显示富文本字体*/
- (NSAttributedString *)CpickerView:(UIPickerView *)pickerView attributedTitleForRowTtile:(NSInteger)row forComponent:(NSInteger)component;

/**设置每行返回的view*/
- (UIView *)CpickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
@end


@protocol CustomDatePickerDelegate <NSObject>

/**设置每行高度*/
-(CGFloat)CpickerView:(UIPickerView *)pickerView rowHeightForPicker:(NSInteger)component;

-(void)CpickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

-(void)CpickerViewdidSelectRow:(NSInteger)row;
@end


@interface CustomDatePicker : UIView



@property (nonatomic, weak) id<CustomDatePickerDataSource>  dataSource;
@property (nonatomic, weak) id<CustomDatePickerDelegate>  delegate;



-(void)selectRow:(NSInteger)rows compant:(NSInteger)Compant withAnimate:(BOOL)Animate;



- (id)initWithSureBtnTitle:(NSString *)title otherButtonTitle:(NSString *)otherButtonTitle;
/**展现视图*/
- (void)show;
/**移除视图*/
-(void)dismisView;




@end
