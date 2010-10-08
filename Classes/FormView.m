#import "FormView.h"


@implementation FormView
@synthesize formController;

-(void)setFormController:(FormController *)newController{
	[formController release];
	formController = [newController retain];
	formController.tableView = self;
	self.delegate = formController;
	self.dataSource = formController;
}

- (void) dealloc
{
	[formController release];
	[super dealloc];
}

@end
