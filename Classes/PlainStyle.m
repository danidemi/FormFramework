#import "PlainStyle.h"


@implementation PlainStyle

+(PlainStyle*)style{
	return [[[PlainStyle alloc] init] autorelease];
}

-(UILabel*)buildLabel:(CGRect)r{
	return nil;
}

-(UITextField*)buildValueTextField:(CGRect)r{
	UIFont* font = [UIFont fontWithName:@"Helvetica" size:12.0];
	int textHeight = r.size.height;
	int y = (int)((r.size.height - textHeight) / 2.0);
	UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(20, y, 280, textHeight)];
	textField.textAlignment = UITextAlignmentLeft;
	textField.adjustsFontSizeToFitWidth = YES;
	textField.font = font; 
	textField.minimumFontSize = 17;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	return [textField autorelease];
}

@end
