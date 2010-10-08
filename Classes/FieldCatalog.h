#import <Foundation/Foundation.h>
#import "FormCell.h"

@interface FieldCatalog : NSObject {
	NSMutableDictionary *identifierToFormCell;
	NSMutableArray *formCells;
}
-(void)addField:(FormCell*)field withIdentifier:(NSString*)identifier;
-(int)count;
-(FormCell*)fieldAtIndex:(int)index;
-(FormCell*)fieldForIdentifier:(NSString*)identifier;
-(int)indexOfField:(FormCell*)field;
-(NSArray*)fields;
@end
