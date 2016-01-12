# NDFormKit
A simple form validation and data wrapper framework

The purpose of building this framework is to have the ability to quickly build a form where customized field validation can be easily integrated. The framework was written in Swift using Xcode 7.2.

## In the box
**NDDataWrapper**

This is the class where you can wrap your data with then can be used in a NDFormDataSet.

**NDFormDataSet**

This class makes it convenient to organize data for UITableViews

**NDFormValidator**

Facilitates the validation of individual validation objects. Form validation results can be handled by delegate objects conformating to the NDFormValidationDelegate protocol.

**NDValidator Protocol**

Protocol for user defined validation objects.

**NDFormValidationDelegate**

Protocol for form validation events

## How to use it?

You can refer to the demo project you will find after you obtain a copy. I have provided comments that will help you understand how you could use it on your apps.

## Installation

There are many ways to add the framework to a project such as creating a workspace and having both your project and the framework project side by side but it takes a lot of steps to accomplish. The easiest would be to open your project and dragging the framework project file into your project then from Build Phases > Link Binary with Libraries locate the framework and add it.
