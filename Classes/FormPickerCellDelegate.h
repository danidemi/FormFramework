#import <UIKit/UIKit.h>
@class FormPickerCell;

@protocol FormPickerCellDelegate

-(NSInteger)numberOfComponentsInFormPickerCell:(FormPickerCell*)pickerCell;
-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell numberOfRowsInComponent:(NSInteger)component;
-(NSString*)formPickerCell:(FormPickerCell*)pickerCell titleForRow:(NSInteger)row forComponent:(NSInteger)component;
-(NSInteger)formPickerCell:(FormPickerCell*)pickerCell selectedRowInComponent:(NSInteger)component forValue:(NSObject*)newValue;
-(void)formPickerCell:(FormPickerCell*)pickerCell didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(NSString*)descriptionForFormPickerCell:(FormPickerCell*)pickerCell;
@end
