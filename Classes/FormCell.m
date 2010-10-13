#import "FormCell.h"
#import "UIViewUtils.h"

@implementation FormCell
@synthesize identifier, value, placeholder, formController;

#pragma mark -
#pragma mark Allocation / Deallocation

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier identifier:(NSString*) newIdentifier{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		identifier = [newIdentifier retain];
    }
    return self;
}

- (void)dealloc {
	[identifier release];
	[value release];
	[placeholder release];
	[formController release];
	[super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)startEditing{
}

-(void)stopEditing{
}

/*
-(UIView*)panel{
	return panel;
}
 */

-(void)hideToolbar{
	[formController hideToolbar];
}

-(void)showToolbar{
	[formController showToolbar];
}

#pragma mark -
#pragma mark Toolbar Events

-(void)actionNext{
	[formController actionNextCell:self];
}
-(void)actionPrevious{
	[formController actionPreviousCell:self];	
}
-(void)actionDone{
	[formController actionDone:self];
}

-(BOOL)isBlank{
	return value == nil;
}



@end
