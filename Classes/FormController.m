#import "FormController.h"
#import "FormFieldCell.h"
#import "FormPickerCell.h"
#import "FormDatePickerCell.h"
#import "FormCreditCardExpirationPicker.h"
#import "FormFieldCellLabel.h"
#import "FormPickerCellLabel.h"
#import "FieldStyle.h"

@implementation FormController

@synthesize formControllerDelegate, containingController;

#pragma mark -
#pragma mark Allocation / Deallocation

- (id) init
{
	self = [super init];
	if (self != nil) {
		catalog = [FieldCatalog new];
		isEditing = NO;
		
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
	int nextIndex = indexPath.row;
	[self enableFieldAt: nextIndex withAnimation:YES];
	
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
	}
	currentlyEditing = [catalog fieldAtIndex:nextIndex];
	
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
		//shrink table
		tableFrame = self.tableView.frame;
		CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
		CGRect formRect = tableFrame;
		int inputHeight = 216.0 + 44.0; //keyboard + toolbar
		NSAssert(containingController, @"Please set a containing controller");
		if(containingController.navigationController){
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

@end

