#import <UIKit/UIKit.h>
@class FormController;

@protocol FormControllerDelegate

-(void)formFillingTerminated:(FormController*)form;

@end
