#import <Foundation/Foundation.h>
#import "FormCell.h"
#import "FormController.h"

@interface FormFieldCell : FormCell <UITextFieldDelegate>{
	UITextField *textField;
}
@property(nonatomic, retain)IBOutlet UITextField *textField;

@end
