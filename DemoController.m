//
//  DemoController.m
//  FormFramework
//
//  Created by Daniele Demichelis on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DemoController.h"


@implementation DemoController
@synthesize formController;

-(void)viewDidLoad{
	[formController 
	 addTextField:@"user" 
	 placeholder:@"Username" 
	 initialValue:nil 
	 keyboardType:UIKeyboardTypeDefault 
	 styled:[LabelStyle style]
	];
}

-(void)formFillingTerminated:(FormController*)form{
	//Called upon "Done" button pressed.
}

@end
