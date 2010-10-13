#import "FormFieldCell.h"
#import "UIViewUtils.h"

@implementation FormFieldCell

@synthesize textField;


- (void) dealloc
{
	[textField release];
	[super dealloc];
}


-(void)setPlaceholder:(NSString *)newPlaceholder{
	[super setPlaceholder:newPlaceholder];
	textField.placeholder = [super placeholder];
}
-(void)setValue:(NSObject *)newValue{
	[super setValue:newValue];
	textField.text = [[super value] description];
}

-(void)startEditing{
	textField.delegate = self;
	textField.enabled = YES;
	[textField becomeFirstResponder];
	[self showToolbar];
}

-(void)stopEditing{
	textField.delegate = nil;
	textField.enabled = NO;
	[textField resignFirstResponder];
	[self setValue:textField.text];
	[self hideToolbar];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self.formController actionNext];
	return NO;
	//return [self.formController userPressReturnOn:self];
}

-(BOOL)isBlank{
	NSString *s = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
	return [super isBlank] || [s length] == 0;
}

@end
