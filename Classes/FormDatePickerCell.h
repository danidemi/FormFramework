#import <Foundation/Foundation.h>
#import "FormCell.h"
#import "FormPickerCellDelegate.h"

@interface FormDatePickerCell : FormCell {
	UITextField *textField;
	UIDatePicker *picker;
	IBOutlet UILabel *label;
	NSDateFormatter *formatter;
}
@property(nonatomic, retain) IBOutlet UILabel *label;
@property(nonatomic, retain) IBOutlet UITextField* textField;

@end
