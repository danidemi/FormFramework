#import "Example0.h"
#import "PlainStyle.h"

@implementation Example0

@synthesize formController;

-(void)viewDidLoad{
	[formController 
	 addTextField:@"nickname" 
	 placeholder:@"Nickname" 
	 initialValue:nil 
	 keyboardType:UIKeyboardTypeASCIICapable 
	 styled:[PlainStyle style]];

	[formController 
	 addPasswordField:@"password" 
	 placeholder:@"Password" 
	 initialValue:nil 
	 keyboardType:UIKeyboardTypeASCIICapable 
	 styled:[PlainStyle style]];
	
}

- (void) dealloc
{
	[formController release];
	[super dealloc];
}

-(void)formFillingTerminated:(FormController *)form{
}

@end
