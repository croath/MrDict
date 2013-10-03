//
//  AppDelegate.m
//  mrdict
//
//  Created by croath on 13-10-3.
//  Copyright (c) 2013年 Croath. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate(){
    NSTimer *_timer;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self activateStatusMenu];
}

- (void)activateStatusMenu
{
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    NSStatusItem *theItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    
    [theItem setTitle:@"(´･_･`)"];
    [theItem setHighlightMode:YES];
    [theItem setMenu:_menu];
    _statusItem = theItem;
}

@end
