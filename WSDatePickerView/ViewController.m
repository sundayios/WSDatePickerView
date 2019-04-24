//
//  ViewController.m
//  WSDatePickerView
//
//  Created by cb_2018 on 2019/4/24.
//  Copyright © 2019 cfwf. All rights reserved.
//

#import "ViewController.h"

#define WeakSelf(type) __weak typeof(type) weak##type = type;
#define StrongSelf(type) __strong typeof(weak##type) strong##type = weak##type;
#import "WSDatePickerView.h"//日期选择
#import "NSDate+Extension.h"
#import "NSDate+Extend.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startTimeTextField.tag = 0;
    self.endTimeTextField.tag = 0;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.startTimeTextField addGestureRecognizer:tap1];
    [self.endTimeTextField addGestureRecognizer:tap2];
}

- (void)tapClick:(UITapGestureRecognizer *)gesture{
    NSInteger tag = gesture.view.tag;
    switch (tag) {
        case 0:
        {   [self.startTimeTextField becomeFirstResponder];
            [self.startTimeTextField resignFirstResponder];
            //开始时间
            WeakSelf(self)
            WSDatePickerView *datePicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * date) {
                weakself.startTimeTextField.text = [date stringWithFormat:@"yyyy-MM-dd"];
            }];
            
            datePicker.hideBackgroundYearLabel = YES;
            datePicker.dateLabelColor = [UIColor blackColor];
            datePicker.doneButtonColor = [UIColor whiteColor];
            NSDate *current = [NSDate date];
            datePicker.minLimitDate = current;
            NSDate *maxDate = [current dateByAddingYears:30];
            datePicker.maxLimitDate = maxDate;
            [datePicker show];
            //
        }
            break;
        case 1:
        {
            [self.endTimeTextField becomeFirstResponder];
            [self.endTimeTextField resignFirstResponder];
            //结束时间
            NSString *startStr= [self.startTimeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
            if (startStr.length > 0) {
                WeakSelf(self)
                WSDatePickerView *datePicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate * date) {
                    weakself.endTimeTextField.text = [date stringWithFormat:@"yyyy-MM-dd"];
                }];
                datePicker.hideBackgroundYearLabel = YES;
                datePicker.dateLabelColor = [UIColor blackColor];
                datePicker.doneButtonColor = [UIColor whiteColor];
                NSDate *current = [NSDate dateWithString:startStr format:@"yyyy-MM-dd"];
                datePicker.minLimitDate = current;
                NSDate *maxDate = [current dateByAddingYears:30];
                datePicker.maxLimitDate = maxDate;
                [datePicker show];
            }else{
                //                [ToolUtils showError:@"请选择开始时间" toView:self.view];
            }
        }
            break;
        default:
            break;
    }
}
@end
