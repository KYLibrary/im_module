//
//  IMAppDelegate.h
//  im_module
//
//  Created by kyleboy on 03/31/2020.
//  Copyright (c) 2020 kyleboy. All rights reserved.
//

@import UIKit;

@interface IMAppDelegate : UIResponder <UIApplicationDelegate>
{
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) UIWindow *window;

@end
