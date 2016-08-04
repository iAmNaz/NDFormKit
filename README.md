# NDFormKit
A simple framework for simple form validation.

The purpose of building this framework is to have the ability to quickly build a form where customized field validation can be easily integrated. The framework was written in Swift using Xcode 7.2. 

The framework is NOT a form UI builder while it is what you'll need to manage your data and validation.

### Some of the benefits
- Instant form and field level feedback if form is valid or not
- Set user defined validation rules
- Set user defined errors(NSError)

## In the box
**NDDataWrapper**

This is the class where you can wrap your data with then can be used in a NDFormDataSet.

**NDFormDataSet**

This class makes it convenient to organize data for UITableViews

**NDFormValidator**

Facilitates the validation of individual validation objects. Form validation results can be handled by delegate objects conformating to the NDFormValidationDelegate protocol.

**NDValidator Protocol**

Protocol for user defined validation rules and errors.

**NDFormValidationDelegate**

Protocol for form validation events

## How to use it?

You can refer to the demo project you will find after you obtain a copy. I have provided comments that will help you understand how you could use it on your apps.

## Installation

There are many ways to add the framework to a project such as creating a workspace and having both your project and the framework project side by side but it takes a lot of steps to accomplish. The easiest would be to open your project and dragging the framework project file into your project then from Build Phases > Link Binary with Libraries locate the framework and add it.

***Using in your Objective-C project***

In your podfile add
pod 'NDFormKit', :git => 'https://github.com/iAmNaz/NDFormKit', :tag => '0.0.1'

Then in your Objective-C import
'#import <NDFormKit/NDFormKit-Swift.h>'

