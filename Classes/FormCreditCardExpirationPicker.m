#import "FormCreditCardExpirationPicker.h"
#import "FormPickerCell.h"

@implementation FormCreditCardExpirationPicker

static int BASE_YEAR = 2010;

-(NSInteger)numberOfComponentsInFormPickerCell:(FormPickerCell*)pickerCell{
	return 2;
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell numberOfRowsInComponent:(NSInteger)component{
	if (component == 0) {
		return 12;
	}else if(component == 1){
		return 50;
	}
	return 0;	
}

-(NSString*)formPickerCell:(FormPickerCell*)pickerCell titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (component == 0) {
		return [NSString stringWithFormat:@"%d",row + 1];
	}else if(component == 1){
		return [NSString stringWithFormat:@"%d",BASE_YEAR + row];
	}
	return nil;	
}

-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell selectedRowInComponent:(NSInteger)component forValue:(NSObject*)newValue{
	NSInteger r;
	if (![pickerCell isBlank]) {
		r = [[(NSArray*)[pickerCell value] objectAtIndex:component] intValue];
		if (component == 1) {
			r = r - BASE_YEAR;
		}
	}else{
		r = 0;
	}
	return r;
}

-(void)formPickerCell:(FormPickerCell*)pickerCell didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if ([pickerCell isBlank]) {
		NSMutableArray* newValue = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
		[newValue addObject:@"1"];
		[newValue addObject:[NSString stringWithFormat:@"%d", BASE_YEAR]];
		[pickerCell setValue:newValue];
	}
	NSMutableArray* arrValue = (NSMutableArray*)[pickerCell value];
	[arrValue 
	 replaceObjectAtIndex:component 
	 withObject:[self formPickerCell:pickerCell titleForRow:row forComponent:component]
	 ];	
}

-(NSString*)descriptionForFormPickerCell:(id)pickerCell{
	NSMutableArray* arrValue = (NSMutableArray*)[pickerCell value];
	NSString* s = [NSString stringWithFormat:@"%@/%@",
				   [arrValue objectAtIndex:0],
				   [arrValue objectAtIndex:1], nil];
	return s;				   	
}
				   


/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

}

-(NSInteger)numberOfComponentsInFormPickerCell:(id)pickerCell{
	return 2;
}

-(NSInteger)formPickerCell:(id)pickerCell numberOfRowsInComponent:(NSInteger)component{
	if (component == 0) {
		return 12;
	}else if(component == 1){
		return 50;
	}
	return 0;
}

-(NSString*)formPickerCell:(id)pickerCell titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (component == 0) {
		return [NSString stringWithFormat:@"%d",row];
	}else if(component == 1){
		return [NSString stringWithFormat:@"%d",2010 + row];
	}
	return nil;
}
*/

@end
