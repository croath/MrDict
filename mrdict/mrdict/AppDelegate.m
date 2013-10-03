//
//  AppDelegate.m
//  mrdict
//
//  Created by croath on 13-10-3.
//  Copyright (c) 2013年 Croath. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabase.h"

@interface AppDelegate(){
    NSTimer *_timer;
    FMDatabase *_db;
    NSInteger _wordsCount;
    NSMutableDictionary *_dict;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self activateStatusMenu];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                              target:self
                                            selector:@selector(updateStatus)
                                            userInfo:nil
                                             repeats:YES];
}


- (void)makeDBAlive{
    if (_db == nil) {
        [self initDatabase];
        if (_db == nil) {
            [self initDatabase];
        }
    }
}

- (void)makeDBDead{
    if (_db == nil) {
        return;
    }
    
    if (![_db close]) {
        [_db close];
    }
    
    _db = nil;
}

- (void)initDatabase{
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"toefl.db"];
    _db = [FMDatabase databaseWithPath:databasePathFromApp];
    
    if (_db != nil) {
        if (![_db open]) {
            if (![_db open]) {
                if (![_db open]) {
                    [_db open];
                }
            }
        }
    }
    
    FMResultSet *set = [_db executeQuery:@"select count(*) from words"];
    if ([set next]) {
        int totalCount = [set intForColumnIndex:0];
        _wordsCount = totalCount;
    }
}

- (void)pushIntoMem{
    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionary];
    } else {
        [_dict removeAllObjects];
    }
    
    [self makeDBAlive];
    
    FMResultSet *set = [_db executeQuery:@"select * from words order by random() limit 10"];
    while ([set next]) {
        NSString *en = [[set stringForColumn:@"en"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *zh = [[set stringForColumn:@"zh"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [_dict setObject:zh forKey:en];
    }
    
    [self makeDBDead];
}

- (NSString*)popWords{
    if (_dict == nil || [_dict count] == 0) {
        [self pushIntoMem];
    }
    
    NSString *en = [[_dict allKeys] objectAtIndex:0];
    NSString *zh = [_dict objectForKey:en];
    [_dict removeObjectForKey:en];
    return [NSString stringWithFormat:@"%@#%@", en, zh];
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

- (void)updateStatus{
    [_statusItem setTitle:[self popWords]];
}

- (IBAction)startPressed:(id)sender {
}

- (IBAction)aboutPressed:(id)sender {
    [NSApp orderFrontStandardAboutPanel:nil];
}

- (IBAction)closePressed:(id)sender {
    [NSApp terminate:nil];
}
@end
