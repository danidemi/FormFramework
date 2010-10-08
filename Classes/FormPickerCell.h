#import <Foundation/Foundation.h>
#import "FormCell.h"
#import "FormPickerCellDelegate.h"

@interface FormPickerCell : FormCell <UIPickerViewDelegate, UIPickerViewDataSource> {
	UITextField *textField;
	UIPickerView *picker;
	id<FormPickerCellDelegate> pickerCellDelegate;
	
}

@property(nonatomic, retain) id<FormPickerCellDelegate> pickerCellDelegate;
@property(nonatomic, retain) IBOutlet UITextField *textField;

@end
