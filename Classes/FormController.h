@interface FormController : UITableViewController {
	FieldCatalog *catalog;
	FormCell *currentlyEditing;
	id<FormControllerDelegate> formControllerDelegate;
	BOOL isEditing;
	CGRect tableFrame;	
	UIViewController* containingController;
}
@property(nonatomic, retain)id formControllerDelegate;
@property(nonatomic, retain)IBOutlet UIViewController* containingController;

#pragma mark -
#pragma mark Form Configuration
-(void)addTextField:(NSString*)identifier placeholder:(NSString*)placeholder initialValue:(NSString*)value keyboardType:(UIKeyboardType)keyboardType styled:(id<FieldStyle>)style;
-(void)addPasswordField:(NSString*)identifier placeholder:(NSString*)placeholder initialValue:(NSString*)value keyboardType:(UIKeyboardType)keyboardType styled:(id<FieldStyle>)style;
-(void)addPickerField:(NSString*)identifier placeholder:(NSString*)placeholder dataSource:(id)newDelegate styled:(id<FieldStyle>)style;
-(void)addDatePickerField:(NSString*)identifier placeholder:(NSString*)placeholder styled:(id<FieldStyle>)style;

#pragma mark -
#pragma mark Setting And Getting Form Values

-(NSString*)valueForField:(NSString*)identifier;
-(NSObject*)valueForFieldAsObject:(NSString*)identifier;
-(void)setValue:(NSString*)newValue forField:(NSString*)identifier;

#pragma mark -
#pragma mark Callbacks From Fields

/**
 Callback invoked whenever the user press the done button on the toolbar.
 */
-(BOOL)actionDone:(FormCell*)cell;

/**
 Callback invoked whenever the user press the next button on the toolbar.
 */
-(void)actionNextCell:(FormCell*)cell;

/**
 Callback invoked whenever the user press the prev button on the toolbar.
 */
-(void)actionPreviousCell:(FormCell*)cell;

#pragma mark -
#pragma mark Form Validation

-(BOOL)isFormCellEmpty:(FormCell*)cell;
-(BOOL)isCellByIdentifierEmpty:(NSString*)identifier;
-(NSInteger)countEmptyFields;

#pragma mark -
#pragma mark Field Coordination

-(void)enableFirstField;
-(void)enableFieldAt:(int)nextIndex withAnimation:(BOOL)animated;
-(void)dismissForm;
-(void)reloadData;

#pragma mark -
#pragma mark Not Clear

-(void)beginFormEditing;
-(void)endFormEditing;

@end
