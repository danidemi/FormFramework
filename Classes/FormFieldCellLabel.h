#import <Foundation/Foundation.h>
#import "FormFieldCell.h"

@interface FormFieldCellLabel : FormFieldCell {
	UILabel *label;
}

@property(nonatomic,retain)IBOutlet UILabel *label;
@end
