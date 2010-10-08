#import <UIKit/UIKit.h>
#import "FormController.h"

@interface Example0 : UIViewController <FormControllerDelegate> {
	FormController* formController;
}
@property(nonatomic, retain) IBOutlet FormController* formController;

@end
