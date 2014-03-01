//
//  realjkAppDelegate.h
//  ios-avplayer-http-proxy
//
//  Created by Joseph Kiok on 2/28/14.
//  Copyright (c) 2014 RealJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MongooseDaemon.h"

@class MongooseDaemon;

@interface realjkAppDelegate : UIResponder <UIApplicationDelegate> {
    MongooseDaemon *mongooseDaemon;
}

@property (strong, nonatomic) UIWindow *window;

@end
