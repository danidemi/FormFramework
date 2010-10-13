#import "FormController.h"
#import "FormFieldCell.h"
#import "FormPickerCell.h"
#import "FormDatePickerCell.h"
#import "FormCreditCardExpirationPicker.h"
#import "FormFieldCellLabel.h"
#import "FormPickerCellLabel.h"
#import "FieldStyle.h"
#import "UIViewUtils.h"
#import "math.h"

@implementation FormController

@synthesize formControllerDelegate, containingController;

-(BOOL)writeable{
	return isWriteable;
}

-(void)setWriteable:(BOOL)newWriteable{
	isWriteable = newWriteable;
	if (!isWriteable) {
		[self dismissForm];
	}
}

#pragma mark -
#pragma mark Allocation / Deallocation

- (id) init
{
	self = [super init];
	if (self != nil) {
		catalog = [FieldCatalog new];
		isEditing = NO;
		isWriteable = YES;
		
	}
	return self;
}

- (void)dealloc {
	[catalog release];
    [super dealloc];
}


#pragma mark -
#pragma mark Form Configuration

-(void)addTextField:(NSString*)identifier placeholder:(NSString*)placeholder initialValue:(NSString*)value keyboardType:(UIKeyboardType)keyboardType styled:(id<FieldStyle>)style{
	
	//Form Cell
	FormFieldCellLabel* mycell = [[FormFieldCellLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		
	//Placeholder label
	UILabel* label = [style buildLabel:mycell.bounds];
	
	//Value textfield
	UITextField* textoField = [style buildValueTextField:mycell.bounds];	
	textoField.keyboardType = keyboardType;
	textoField.returnKeyType = UIReturnKeyNext;		
	textoField.enabled = NO;
	textoField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		
	//Adding styled subviews
	if (label) {
		[mycell addSubview:label];
		[mycell setLabel:label];
	}
	if (textoField) {
		[mycell addSubview:textoField];		
		[mycell setTextField:textoField];	
	}

	//Set properties that makes this cell behave as expected
	mycell.selectionStyle = UITableViewCellSelectionStyleNone;
	mycell.placeholder = placeholder;
	mycell.value = value;
	mycell.formController = self;
	
	
	[catalog addField:mycell withIdentifier:identifier];			
}


-(void)addPasswordField:(NSString*)identifier placeholder:(NSString*)placeholder initialValue:(NSString*)value keyboardType:(UIKeyboardType)keyboardType styled:(id<FieldStyle>)style{
	[self addTextField:identifier placeholder:placeholder initialValue:value keyboardType:keyboardType styled:style];
	FormFieldCellLabel* f = (FormFieldCellLabel*)[catalog fieldForIdentifier:identifier];
	f.textField.secureTextEntry = YES;
}


-(void)addPickerField:(NSString*)identifier placeholder:(NSString*)placeholder dataSource:(id)newDelegate styled:(id<FieldStyle>)style{
	//Form Cell
	FormPickerCellLabel* mycell = [[[FormPickerCellLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
	
	//Placeholder label
	UILabel* label = [style buildLabel:mycell.bounds];
	
	//Value textfield
	UITextField* textoField = [style buildValueTextField:mycell.bounds];	
	textoField.enabled = NO;
	
	//Adding styled subviews
	if (label) {
		[mycell addSubview:label];
		[mycell setLabel:label];
	}
	if (textoField) {
		[mycell addSubview:textoField];		
		[mycell setTextField:textoField];	
	}
	
	//Set properties that makes this cell behave as expected	
	mycell.selectionStyle = UITableViewCellSelectionStyleNone;
	mycell.pickerCellDelegate = newDelegate;		
	mycell.placeholder = placeholder;
	mycell.formController = self;	
	
	[catalog addField:mycell withIdentifier:identifier];	
}


-(void)addDatePickerField:(NSString*)identifier placeholder:(NSString*)placeholder styled:(id<FieldStyle>)style{
	//Form Cell
	FormDatePickerCell* mycell = [[[FormDatePickerCell alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
	
	//Placeholder label
	UILabel* label = [style buildLabel:mycell.bounds];
	
	//Value textfield
	UITextField* textoField = [style buildValueTextField:mycell.bounds];	
	textoField.enabled = NO;
	
	//Adding styled subviews
	if (label) {
		[mycell addSubview:label];
		[mycell setLabel:label];
	}
	if (textoField) {
		[mycell addSubview:textoField];		
		[mycell setTextField:textoField];	
	}
	
	//Set properties that makes this cell behave as expected	
	mycell.selectionStyle = UITableViewCellSelectionStyleNone;		
	mycell.placeholder = placeholder;
	mycell.formController = self;	
	
	[catalog addField:mycell withIdentifier:identifier];	
}

#pragma mark -
#pragma mark Setting And Getting Form Values

-(NSString*)valueForField:(NSString*)identifier{
	FormCell* cell = [catalog fieldForIdentifier:identifier];	
	return [[cell value] description];
}

-(NSObject*)valueForFieldAsObject:(NSString*)identifier{
	FormCell* cell = [catalog fieldForIdentifier:identifier];	
	return [cell value];	
}

-(void)setValue:(NSString*)newValue forField:(NSString*)identifier{
	FormCell* cell = [catalog fieldForIdentifier:identifier];	
	[cell setValue:newValue];
}

#pragma mark -
#pragma mark Callbacks From Fields

-(BOOL)actionDone{
	if(currentlyEditing){
		[currentlyEditing stopEditing];
		[self endFormEditing];	
		[formControllerDelegate formFillingTerminated:self];
	}
	return YES;	
}

-(void)actionNext{
	if(currentlyEditing){
		int cellIndex = [catalog indexOfField:currentlyEditing];
		cellIndex = cellIndex < [catalog count]-1 ? cellIndex+1 : 0;		
		[self enableFieldAt:cellIndex withAnimation:YES];		
	}
}

-(void)actionPrevious{
	if(currentlyEditing){
		int cellIndex = [catalog indexOfField:currentlyEditing];
		cellIndex = cellIndex > 0 ? cellIndex-1 : [catalog count] -1;
		[self enableFieldAt:cellIndex withAnimation:YES];
	}
}


/*
-(BOOL)actionDone:(FormCell*)cell{
	[cell stopEditing];
	[self endFormEditing];	
	[formControllerDelegate formFillingTerminated:self];
	return YES;
}

-(void)actionNextCell:(FormCell*)cell{
	int cellIndex = [catalog indexOfField:cell];
	cellIndex = cellIndex < [catalog count]-1 ? cellIndex+1 : 0;
	[self enableFieldAt:cellIndex withAnimation:YES];
}

-(void)actionPreviousCell:(FormCell*)cell{
	int cellIndex = [catalog indexOfField:cell];
	cellIndex = cellIndex > 0 ? cellIndex-1 : [catalog count] -1;
	[self enableFieldAt:cellIndex withAnimation:YES];
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [catalog count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [catalog fieldAtIndex:indexPath.row];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.writeable) {
		int nextIndex = indexPath.row;
		[self enableFieldAt: nextIndex withAnimation:YES];
	}
}

#pragma mark -
#pragma mark Field Coordination

-(void)enableFirstField{
	//Animation does not work if user is not editing the form.
	[self enableFieldAt:0 withAnimation:NO];
}

- (void) enableFieldAt:(int)nextIndex withAnimation:(BOOL)animated {
	[self beginFormEditing];
	if(currentlyEditing){
		[currentlyEditing stopEditing];
		[currentlyEditing release];
	}
	currentlyEditing = [[catalog fieldAtIndex:nextIndex] retain];
	
	if (animated) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:[catalog indexOfField:currentlyEditing] inSection:0];
		[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
	
	[currentlyEditing startEditing];
}

-(void)dismissForm{
	if(currentlyEditing){
		[currentlyEditing stopEditing];
	}
	[self endFormEditing];
}

-(void)reloadData{
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Form Validation
-(NSInteger)countEmptyFields{
	NSInteger count = 0;
	for (FormCell* cell in [catalog fields]) {
		if ([self isFormCellEmpty:cell]) {
			count++;
		}
	}
	return count;
}


-(BOOL)isCellByIdentifierEmpty:(NSString*)identifier{
	return [self isFormCellEmpty:[catalog fieldForIdentifier:identifier]];
}

-(BOOL)isFormCellEmpty:(FormCell*)cell{
	return [cell isBlank];
}


#pragma mark -
#pragma mark Status Management

/**
 Used internally to ensure the form has been shrunk.
 Not intended to be called from clients.
 */
-(void)beginFormEditing{
	if(!isEditing){
		
		//Shrink the form.		
		CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
		
		tableFrame = self.tableView.frame;
		CGRect formRect = tableFrame;
		
		int inputHeight = 216.0; //keyboard + toolbar
		NSAssert(containingController, @"Please set a containing controller");
		if(containingController.navigationController){
			inputHeight = inputHeight + 44;
		}
		if(containingController.tabBarController){
			inputHeight = inputHeight + 44;
		}
		
		int newHeight = screenRect.size.height - inputHeight - formRect.origin.y;
		CGRect newRect = CGRectMake(formRect.origin.x, formRect.origin.y, formRect.size.width, newHeight);
		self.tableView.frame = newRect;
		NSLog(@"start Editing");
		isEditing = YES;
	}
}

/**
 Used internally to ensure the form has been expanded to its original size after editing.
 Not intended to be called from clients.
 */
-(void)endFormEditing{
	if (isEditing) {
		self.tableView.frame = tableFrame;
		//expand table
		NSLog(@"stop Editing");
		isEditing = NO;
	}
}

#pragma mark Toolbar

-(void)showToolbar{
	
	//Screen 
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	
	//Toolbar should be built firstly to discover its heigh
	UIBarButtonItem* prevBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForPrevious] style:UIBarButtonItemStyleBordered target:self action:@selector(actionPrevious)] autorelease];
	UIBarButtonItem* nextBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForNext] style:UIBarButtonItemStyleBordered target:self action:@selector(actionNext)] autorelease];		
	UIBarButtonItem* flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];	
	UIBarButtonItem* doneBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForDone] style:UIBarButtonItemStyleDone target:self action:@selector(actionDone)] autorelease];
	
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
	[[UIViewUtils rootViewOf:[self tableView]] addSubview:panel];	
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

-(UIView*)panel{
	return panel;
}

#pragma mark orientation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	if (isEditing) {
		panel.hidden = YES;
	}
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	if (isEditing) {
		panel.hidden = NO;
		[self drawToolbar];
	}
}

-(NSString*)labelForPrevious{
	NSString* btnLbl = NSLocalizedString(@"form.toolbar.previousButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.previousButton"]) {
		btnLbl = @"Prev";
	}	
	return btnLbl;
}

-(NSString*)labelForNext{
	NSString* btnLbl = NSLocalizedString(@"form.toolbar.nextButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.nextButton"]) {
		btnLbl = @"Next";
	}	
	return btnLbl;	
}

-(NSString*)labelForDone{
	NSString* btnLbl = NSLocalizedString(@"form.toolbar.doneButton", nil);
	if ([btnLbl isEqualToString:@"form.toolbar.doneButton"]) {
		btnLbl = @"Done";
	}	
	return btnLbl;	
}

-(void)drawToolbar{
	
	//Screen dimensions
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];	
	
	//Toolbar buttons
	UIBarButtonItem* prevBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForPrevious] style:UIBarButtonItemStyleBordered target:self action:@selector(actionPrevious)] autorelease];
	UIBarButtonItem* nextBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForNext] style:UIBarButtonItemStyleBordered target:self action:@selector(actionNext)] autorelease];		
	UIBarButtonItem* flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];		
	UIBarButtonItem* doneBtn = [[[UIBarButtonItem alloc] initWithTitle:[self labelForDone] style:UIBarButtonItemStyleDone target:self action:@selector(actionDone)] autorelease];

	
	//Set the navigaiton frame inside the panel
	UIToolbar* toolbar = [[UIToolbar alloc] init];
	[toolbar setItems: [NSArray arrayWithObjects:prevBtn, nextBtn, flexItem, doneBtn, nil] animated:YES];
	[toolbar setTintColor: [UIColor colorWithRed:0.569 green:0.6 blue:0.643 alpha:1.0]];
	CGSize navSize = [toolbar sizeThatFits:CGSizeZero];
	CGRect navigationFrame = CGRectMake(0.0,
										0.0,
										navSize.width,
										navSize.height
										);
	toolbar.frame = navigationFrame;	
	
	//Big gray view that contains all input
	if (panel) {
		[panel removeFromSuperview];
		[panel release];
	}	
	
	CGRect panelFrame;
	if (containingController.interfaceOrientation == UIInterfaceOrientationPortrait){
		panelFrame = CGRectMake(0.0,
									   screenRect.size.height - (196.0 + navSize.height),
									   navSize.width,
									   navSize.height + 196.0
									   );			
	}else if (containingController.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
		
		panelFrame = CGRectMake(150.0,
								0.0,
								200.0,
								screenRect.size.height
								);				
		NSLog(@"left");		
		toolbar.transform = CGAffineTransformMakeRotation(M_PI);
		
	}else if (containingController.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
		panelFrame = CGRectMake(0.0,
									   0.0,
									   navSize.width,
									   navSize.height + 196.0
									   );			
	}else if (containingController.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
		//iPhone button on the right
		
		panelFrame = CGRectMake(0.0,
								0.0,
								200.0,
								screenRect.size.height
								);		
		toolbar.transform = CGAffineTransformMakeRotation(-M_PI);		
				
	}
			
	panel = [UIView new];
	panel.frame = panelFrame;
	[[UIViewUtils rootViewOf:[self tableView]] addSubview:panel];	
	panel.backgroundColor = [UIColor colorWithRed:0.569 green:0.6 blue:0.643 alpha:1.0];
	
	[panel addSubview:toolbar];	
	[toolbar release];	
	
}


@end

