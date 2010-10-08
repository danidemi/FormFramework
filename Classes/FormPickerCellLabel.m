#import "FormPickerCellLabel.h"


@implementation FormPickerCellLabel
@synthesize label;

-(void)setPlaceholder:(NSString *)newPlaceholder{
	self.label.text = newPlaceholder;
	textField.placeholder = nil;
}

- (void) dealloc
{
	[label release];
	[super dealloc];
}

@end
