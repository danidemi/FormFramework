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

-(UIView*)panel{
	return panel;
}

-(void)showToolbar{
	
	//Screen 
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	
	//Toolbar should be built firstly to discover its heigh
	NSString* btnLbl = NSLocalizedString(@"form.toolbar.previousButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.previousButton"]) {btnLbl = @"Prev";}
	UIBarButtonItem* prevBtn = [[[UIBarButtonItem alloc] initWithTitle:btnLbl style:UIBarButtonItemStyleBordered target:self action:@selector(actionPrevious)] autorelease];
	
	btnLbl = NSLocalizedString(@"form.toolbar.nextButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.nextButton"]) {btnLbl = @"Next";}	
	UIBarButtonItem* nextBtn = [[[UIBarButtonItem alloc] initWithTitle:btnLbl style:UIBarButtonItemStyleBordered target:self action:@selector(actionNext)] autorelease];	

	UIBarButtonItem* flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];	
		
	btnLbl = NSLocalizedString(@"form.toolbar.doneButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.doneButton"]) {btnLbl = @"Done";}
	UIBarButtonItem* doneBtn = [[[UIBarButtonItem alloc] initWithTitle:btnLbl style:UIBarButtonItemStyleDone target:self action:@selector(actionDone)] autorelease];
	
	UIToolbar* toolbar = [[[UIToolbar alloc] init] autorelease];	
	[toolbar setItems: [NSArray arrayWithObjects:prevBtn, nextBtn, flexItem, doneBtn, nil] animated:YES];
	[toolbar setTintColor: [UIColor colorWithRed:0.569 green:0.6 blue:0.643 alpha:1.0]];
	CGSize navSize = [toolbar sizeThatFits:CGSizeZero];
	
	
	//Big gray view that contains all input
	panel = [UIView new];
	CGRect panelFrame = CGRectMake(0.0,
										screenRect.size.height - (196.0 + navSize.height),
										navSize.width,
										navSize.height + 196.0
										);	
	panel.frame = panelFrame;
	[[UIViewUtils rootViewOf:[self.formController tableView]] addSubview:panel];	
	panel.backgroundColor = [UIColor colorWithRed:0.569 green:0.6 blue:0.643 alpha:1.0];
	
	//Set the navigaiton frame inside the panel
	CGRect navigationFrame = CGRectMake(0.0,
										0.0,
										navSize.width,
										navSize.height
										);
	toolbar.frame = navigationFrame;
	[panel addSubview:toolbar];	
	
}

-(void)hideToolbar{
	[panel removeFromSuperview];	
	[panel release];
	panel = nil;	
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
