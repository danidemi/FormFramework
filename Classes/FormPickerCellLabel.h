#import <Foundation/Foundation.h>
#import "FormPickerCell.h"

@interface FormPickerCellLabel : FormPickerCell {
	IBOutlet UILabel *label;
}
@property(nonatomic, retain) IBOutlet UILabel *label;
@end
