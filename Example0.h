#import <UIKit/UIKit.h>
#import "FormFramework.h"

@interface Example0 : UIViewController <FormControllerDelegate, FormPickerCellDelegate> {
	FormController* formController;
	NSMutableArray* combination;
	
	UIButton* switchReadonlyButton;
}
@property(nonatomic, retain) IBOutlet FormController* formController;
@property(nonatomic, retain) IBOutlet UIButton* switchReadonlyButton;
-(IBAction)setValues;
-(IBAction)doSwitchReadonly;
-(void)updateOutlets;
@end
