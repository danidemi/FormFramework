#import <UIKit/UIKit.h>
@class FormController;

@interface FormCell : UITableViewCell {
	
	NSObject *value;
	NSString *identifier;
	NSString *placeholder;
		
	/** FormController that managing this cell. */
	FormController *formController;
}
@property(nonatomic,retain) NSObject *value;
@property(nonatomic,retain, readonly) NSString *identifier;
@property(nonatomic,retain) NSString *placeholder;
@property(nonatomic,retain) FormController *formController;

#pragma mark -
#pragma mark Callbacks invoked by Form Controller 

-(void)startEditing;
-(void)stopEditing;

#pragma mark -
#pragma mark Field Validation

-(BOOL)isBlank;

#pragma mark -
#pragma mark Hooks For Sub Class

/** 
 Panel containing the toolbar and the place where subclasses should show their input window.
 */
/*
-(UIView*)panel;
*/

#pragma mark -
#pragma mark Toolbar Events
-(void)actionDone;
-(void)actionNext;
-(void)actionPrevious;

#pragma mark -
#pragma mark Toolbar Management

/** To be invoked by  subclasses to show the toolbar. */
-(void)showToolbar;

/** To be invoked by  subclasses to hide the toolbar. */
-(void)hideToolbar;

@end
