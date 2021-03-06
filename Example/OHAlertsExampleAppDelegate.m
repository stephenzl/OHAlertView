//
//  AlertsExExampleAppDelegate.m
//  AlertsExExample
//
//  Created by Olivier on 31/01/11.
//  Copyright 2011 AliSoftware. All rights reserved.
//

#import "OHAlertsExampleAppDelegate.h"
#import "OHAlertView.h"


@implementation OHAlertsExampleAppDelegate

-(IBAction)showAlert1
{
	[OHAlertView showAlertWithTitle:@"Alert Demo"
                            message:@"Welcome to this sample"
                       cancelButton:nil
                           okButton:@"Thanks!"
                      buttonHandler:^(OHAlertView* alert, NSInteger buttonIndex)
	 {
		 self.status.text = @"Welcome !";
	 }];
}

/////////////////////////////////////////////////////////////////////////////


-(IBAction)showAlert2
{
	[OHAlertView showAlertWithTitle:@"Your order"
                            message:@"Want some ice cream?"
                       cancelButton:@"No thanks"
                           okButton:@"Yes please!"
                      buttonHandler:^(OHAlertView *alert, NSInteger buttonIndex)
	 {
		 NSLog(@"button tapped: %d",buttonIndex);
		 
		 if (buttonIndex == alert.cancelButtonIndex)
         {
			 self.status.text = @"Your order has been cancelled";
		 }
         else
         {	 
			 NSArray* flavors = [NSArray arrayWithObjects:@"chocolate",@"vanilla",@"strawberry",@"coffee",nil];
			 [OHAlertView showAlertWithTitle:@"Flavor"
                                     message:@"Which flavor do you prefer?"
                                cancelButton:@"Cancel"
                                otherButtons:flavors
                               buttonHandler:^(OHAlertView *alert, NSInteger buttonIndex)
			  {
				  NSLog(@"button tapped: %d",buttonIndex);
				  if (buttonIndex == alert.cancelButtonIndex)
                  {
					  self.status.text = @"Your order has been cancelled";
				  }
                  else
                  {
					  NSString* flavor = [flavors objectAtIndex:(buttonIndex-alert.firstOtherButtonIndex)];
					  self.status.text = [NSString stringWithFormat:@"You ordered a %@ ice cream.",flavor];  
				  }
			  }];
		 }
	 }];
}

-(IBAction)showAlert3
{
    [[[OHAlertView alloc] initWithTitle:@"Alert Demo"
                                message:@"This is a demo message"
                           cancelButton:nil
                           otherButtons:[NSArray arrayWithObject:@"OK"]
                          buttonHandler:^(OHAlertView* alert, NSInteger buttonIndex)
      {
          if (buttonIndex == -1)
          {
              self.status.text = @"Demo alert dismissed automatically after timeout!";
          }
          else
          {
              self.status.text = @"Demo alert dismissed by user!";
          }
      }] showWithTimeout:12 timeoutButtonIndex:-1 timeoutMessageFormat:@"(Alert dismissed in %lus)"];
}



/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: App LifeCycle
/////////////////////////////////////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

@end
