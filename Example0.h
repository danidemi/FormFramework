#import <UIKit/UIKit.h>
#import "FormFramework.h"

@interface Example0 : UIViewController <FormControllerDelegate, FormPickerCellDelegate> {
	FormController* formController;
	NSMutableArray* combination;
}
@property(nonatomic, retain) IBOutlet FormController* formController;
-(IBAction)setValues;
@end
