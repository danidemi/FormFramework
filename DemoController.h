//
//  DemoController.h
//  FormFramework
//
//  Created by Daniele Demichelis on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormFramework.h"

@interface DemoController : UIViewController <FormControllerDelegate>{
	FormController* formController;
}
@property(nonatomic, retain) IBOutlet FormController* formController;

@end
