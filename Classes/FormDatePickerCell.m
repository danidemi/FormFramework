#import "FormDatePickerCell.h"

@implementation FormDatePickerCell

@synthesize label, textField;

#pragma mark -
#pragma mark Allocation / Deallocation

-(void)setupIfNeeded{
	if(!formatter){
		formatter = [NSDateFormatter new];
		formatter.dateFormat = @"dd/MM/y";
	}
}

- (void) dealloc{
	[formatter release];
	[picker release];
	[super dealloc];
}

-(void)setPlaceholder:(NSString *)newPlaceholder{
	label.text = newPlaceholder;
}

-(void)setValue:(NSObject *)newValue{
	[self setupIfNeeded];
	NSAssert([newValue isKindOfClass:[NSDate class]], @"Wrong value type", nil);
	[super setValue:newValue];
	textField.text = [formatter stringFromDate:(NSDate*)newValue];
}

-(void)dateChanged{
	[self setupIfNeeded];
	//textField.text = [formatter stringFromDate:picker.date];
	[self setValue:picker.date];
}

-(void)startEditing{
	if(!picker){
		picker = [UIDatePicker new];
		picker.datePickerMode = UIDatePickerModeDate;
		
		[picker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
	}
	
	if(!picker.superview){
		
		[self showToolbar];
		
		UIView* inputPanel = [self panel];
		[inputPanel addSubview:picker];
		
		CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
		CGRect pickerRect = CGRectMake(0.0,
									  44.0,
									  pickerSize.width,
									  pickerSize.height);		
		picker.frame = pickerRect;			
	}
	
}

-(void)stopEditing{
	[picker removeFromSuperview];
	[self hideToolbar];
}

@end
