#import <Foundation/Foundation.h>
#import "FormPickerCellDelegate.h"

@interface ArrayPickerCellDelegate : NSObject <FormPickerCellDelegate>{
	NSArray* array;
}

- (id) initWithArray:(NSArray*)values;

@end
