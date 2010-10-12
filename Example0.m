#import "Example0.h"
#import "FormFramework.h"

@implementation Example0

@synthesize formController,switchReadonlyButton;

-(void)viewDidLoad{
	
	combination = [[NSMutableArray alloc] initWithCapacity:4];
	[combination addObject:@"0"];
	[combination addObject:@"0"];
	[combination addObject:@"0"];
	[combination addObject:@"0"];
	
	[formController 
	 addTextField:@"nickname" 
	 placeholder:@"Nickname" 
	 initialValue:nil 
	 keyboardType:UIKeyboardTypeASCIICapable 
	 styled:[LabelStyle style]];

	[formController 
	 addPasswordField:@"password" 
	 placeholder:@"Password" 
	 initialValue:nil 
	 keyboardType:UIKeyboardTypeASCIICapable 
	 styled:[LabelStyle style]];
	
	NSArray* values = [NSArray arrayWithObjects:
					   @"American Express",
					   @"Diners Club",
					   @"JCB",
					   @"Master Card",
					   @"Visa",
					   @"Visa Electron",
					   nil];
	ArrayPickerCellDelegate* arrayPicker = 
	[[ArrayPickerCellDelegate alloc] initWithArray:values];
	[formController
	 addPickerField:@"picker" 
	 placeholder:@"Card" 
	 dataSource:arrayPicker 
	 styled:[LabelStyle style]];
	[arrayPicker release];
	
	[formController
	 addPickerField:@"combination" 
	 placeholder:@"Combination" 
	 dataSource:self 
	 styled:[LabelStyle style]];
	
	[self updateOutlets];
	
}

-(void)updateOutlets{
	NSString* label = formController.writeable ? @"Lock" : @"Unlock";	
	[switchReadonlyButton 
	 setTitle:label
	 forState:UIControlStateNormal];
}

-(IBAction)doSwitchReadonly{
	formController.writeable = !formController.writeable;
	[self updateOutlets];
}

- (void) dealloc
{
	[formController release];
	[combination release];
	[switchReadonlyButton release];
	[super dealloc];
}

-(void)formFillingTerminated:(FormController *)form{
}

-(IBAction)setValues{
	[formController setValue:[[NSDate date] description] forField:@"nickname"];
	[formController setValue:[[NSDate date] description] forField:@"password"];	
}

#pragma mark FormPickerCellDelegate

-(NSInteger)numberOfComponentsInFormPickerCell:(FormPickerCell*)pickerCell{
	return [combination count];
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell numberOfRowsInComponent:(NSInteger)component{
	return 10;
}

-(NSString*)formPickerCell:(FormPickerCell*)pickerCell titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [NSString stringWithFormat:@"%d", row];
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell selectedRowInComponent:(NSInteger)component 
				  forValue:(NSObject*)newValue{
	return [[newValue description] intValue];
}

-(void)formPickerCell:(FormPickerCell*)pickerCell didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	[combination replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%d", row] ];
}

-(NSString*)descriptionForFormPickerCell:(FormPickerCell*)pickerCell{
	NSMutableString* result = [[NSMutableString alloc] initWithCapacity:[combination count]];
	for (NSString* s in combination) {
		if(s){
			[result appendString:s];
		}else {
			[result appendString:@"-"];
		}

	}
	return [result autorelease];
}

@end
