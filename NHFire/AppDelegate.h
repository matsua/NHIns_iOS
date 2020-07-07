//
//  AppDelegate.h
//  NHFire
//
//  Created by NH on 2020/07/06.
//  Copyright © 2020 NH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;

@end

