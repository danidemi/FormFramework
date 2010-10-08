#import "FieldCatalog.h"


@implementation FieldCatalog

- (id) init
{
	self = [super init];
	if (self != nil) {
		identifierToFormCell = [NSMutableDictionary new];
		formCells = [NSMutableArray new];
	}
	return self;
}
- (void) dealloc
{
	[identifierToFormCell release];
	[formCells release];
	[super dealloc];
}

-(NSArray*)fields{
	return [NSArray arrayWithArray:formCells];
}

-(void)addField:(FormCell*)field withIdentifier:(NSString*)identifier{
	NSAssert(identifier, @"Identifier nil.");
	NSAssert(field, @"Field nil.");
	if([identifierToFormCell objectForKey:identifier]){ 
		[NSException raise:@"Duplicated identifier" format:@"identifier %@ is already used", identifier];
	}
	[identifierToFormCell setObject:field forKey:identifier];
	[formCells addObject:field];
	
}

-(FormCell*)fieldForIdentifier:(NSString*)identifier{
	return [identifierToFormCell objectForKey:identifier];
}

-(int)count{
	return [identifierToFormCell count];
}
-(FormCell*)fieldAtIndex:(int)index{
	return [formCells objectAtIndex:index];
	
}
-(int)indexOfField:(FormCell*)field{
	return [formCells indexOfObject:field];
}
@end
