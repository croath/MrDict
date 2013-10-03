//
//  AppDelegate.h
//  mrdict
//
//  Created by croath on 13-10-3.
//  Copyright (c) 2013年 Croath. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (strong) IBOutlet NSMenu *menu;

@property (unsafe_unretained) IBOutlet NSMenuItem *startItem;
- (IBAction)startPressed:(id)sender;
- (IBAction)aboutPressed:(id)sender;
- (IBAction)closePressed:(id)sender;
@end
