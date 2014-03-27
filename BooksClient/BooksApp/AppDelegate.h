//
//  AppDelegate.h
//  ModelsApp1
//
//  Created by chandrikagole on 1/14/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LoopBack/LoopBack.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ ( LBRESTAdapter *) adapter;
@end
