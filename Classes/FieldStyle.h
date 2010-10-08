#import <UIKit/UIKit.h>


@protocol FieldStyle

-(UILabel*)buildLabel:(CGRect)r;
-(UITextField*)buildValueTextField:(CGRect)r;

@end
