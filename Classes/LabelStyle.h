#import <Foundation/Foundation.h>
#import "FieldStyle.h"

@interface LabelStyle : NSObject <FieldStyle> {
	UIColor *labelColor;
}
- (id) initWithColor:(UIColor*)newColor;
+(LabelStyle*)style;

@end
