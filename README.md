iPhone FormFramework helps you to easily include well designed forms in your iPhone apps.

Example
=======
Here's the code you should write to have a good looking login form with username and password fields.

    [formController 
        addTextField:@"nickname" 
        placeholder:@"Nickname" 
        initialValue:nil 
        keyboardType:UIKeyboardTypeASCIICapable 
        styled:[LabelStyle style]];
    [formController 
        addPasswordField:@"password" 
        placeholder:@"Password" 
        initialValue:nil 
        keyboardType:UIKeyboardTypeASCIICapable 
        styled:[LabelStyle style]];

Features
========

To see FormFramework in action you can check the following [video](http://youtu.be/MNd3WI1_mHg "You Tube Video")

* Integrated with Interface Builder.
* Form fields are rendered with the help of styles, to guarantee the same aspect.
* Nice "prev", "next", "done" buttons to move around the form.
* Currently the FormFramework supports:
 * Clear text fields.
 * Password fields.
 * Date fields.
 * Picker fields.

