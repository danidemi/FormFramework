#import "LabelStyle.h"


@implementation LabelStyle

+(LabelStyle*)style{
	return [[[LabelStyle alloc] init] autorelease];
}

- (id) initWithColor:(UIColor*)newColor
{
	self = [super init];
	if (self != nil) {
		labelColor = [newColor retain];
	}
	return self;
}

- (id) init
{
	return [self initWithColor:[UIColor colorWithRed:0.0 green:0.502 blue:0.5 alpha:1.0]];
}


- (void) dealloc
{
	[labelColor release];
	[super dealloc];
}



-(UILabel*)buildLabel:(CGRect)r{

	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 6, 70, 33)];
	
	label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	label.lineBreakMode = UILineBreakModeTailTruncation;
	label.textAlignment = UITextAlignmentRight;
	label.numberOfLines = 1;
	label.minimumFontSize = 10;
	label.adjustsFontSizeToFitWidth = YES;		
	label.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
	label.textColor = labelColor;
	
	return [label autorelease];
}

-(UITextField*)buildValueTextField:(CGRect)r{
	UIFont* font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
	UITextField* textoField = [[UITextField alloc] initWithFrame:CGRectMake(99, 5, 201, 33)];
	textoField.textAlignment = UITextAlignmentLeft;
	textoField.adjustsFontSizeToFitWidth = YES;
	textoField.font = font; 
	textoField.minimumFontSize = 17;
	textoField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textoField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	
	return [textoField autorelease];
}

@end
