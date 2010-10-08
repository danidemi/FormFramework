#import "FormFieldCellLabel.h"


@implementation FormFieldCellLabel
@synthesize label;

-(void)setPlaceholder:(NSString *)newPlaceholder{
	self.label.text = newPlaceholder;
	self.textField.placeholder = nil;
}

- (void) dealloc
{
	[label release];
	[super dealloc];
}

@end
