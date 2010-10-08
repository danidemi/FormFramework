#import <UIKit/UIKit.h>
#import "FormController.h";

@interface FormView : UITableView {
	IBOutlet FormController *formController;
}
@property(nonatomic,retain) IBOutlet FormController *formController;
@end
