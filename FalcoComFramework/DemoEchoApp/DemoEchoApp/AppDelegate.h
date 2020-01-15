//
//  AppDelegate.h
//  DemoEchoApp
//
//  Created by applechang on 2018/11/22.
//  Copyright © 2018年 applechang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

