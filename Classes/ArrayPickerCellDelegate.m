#import "ArrayPickerCellDelegate.h"
#import "FormPickerCell.h"

@implementation ArrayPickerCellDelegate

- (id) initWithArray:(NSArray*)values {
	self = [super init];
	if (self != nil) {
		array = [values retain];
	}
	return self;
}

- (void) dealloc {
	[array release];
	[super dealloc];
}



-(NSInteger)numberOfComponentsInFormPickerCell:(FormPickerCell*)pickerCell{
	return 1;
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell numberOfRowsInComponent:(NSInteger)component{
	return [array count];
}

-(NSString*)formPickerCell:(FormPickerCell*)pickerCell titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [[array objectAtIndex:row] description];
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell selectedRowInComponent:(NSInteger)component forValue:(NSObject*)newValue{
	return [array indexOfObject:newValue];
}

-(void)formPickerCell:(FormPickerCell*)pickerCell didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	NSString* newValue = [self 
					   formPickerCell:pickerCell 
					   titleForRow:row 
					   forComponent:component];
	[(FormPickerCell*)pickerCell setValue:newValue];
}

-(NSString*)descriptionForFormPickerCell:(FormPickerCell*)pickerCell{
	return [[pickerCell value] description];
}

@end
