#import "FormPickerCell.h"
#import "UIViewUtils.h"

@implementation FormPickerCell

@synthesize pickerCellDelegate, textField;

- (void) dealloc
{
	[picker release];
	[(id)pickerCellDelegate release];
	[textField release];
	[super dealloc];
}

-(void)setPlaceholder:(NSString *)newPlaceholder{
	[super setPlaceholder:newPlaceholder];
	textField.placeholder = self.placeholder;
}

-(void)setValue:(NSObject *)newValue{
	[super setValue:newValue];
	textField.text = [pickerCellDelegate descriptionForFormPickerCell:self];
}


-(void)startEditing{
	if(!picker){
		picker = [UIPickerView new];
		picker.delegate = self;
		picker.dataSource = self;			
		picker.showsSelectionIndicator = YES;
	}

	if(!picker.superview){
		
		[self showToolbar];
		UIView* theView = [self panel];
		
		[theView addSubview:picker];
		
		CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
		CGRect startRect = CGRectMake(0.0,
									  44.0,
									  pickerSize.width,
									  pickerSize.height);		
		picker.frame = startRect;	
		
		NSInteger components = [pickerCellDelegate numberOfComponentsInFormPickerCell:self];
		for(NSInteger component = 0; component < components; component++){
			NSInteger row = [pickerCellDelegate formPickerCell:self selectedRowInComponent:component forValue:value];
			if(row >= 0){
				[picker selectRow:row inComponent:component animated:NO];
			}
		}				
	}
	
}

-(void)stopEditing{
	[picker removeFromSuperview];
	[self hideToolbar];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [pickerCellDelegate formPickerCell:self numberOfRowsInComponent:component];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return [pickerCellDelegate numberOfComponentsInFormPickerCell:self];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [pickerCellDelegate formPickerCell:self titleForRow:row forComponent:component];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	[pickerCellDelegate formPickerCell:self didSelectRow:row inComponent:component];
	textField.text = [pickerCellDelegate descriptionForFormPickerCell:self];
}

@end
