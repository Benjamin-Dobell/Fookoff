//
//  FookoffPlugin.m
//  Fookoff
//
//  Created by Benjamin Dobell on 13/02/2015.
//  Copyright (c) 2015 Glass Echidna Pty Ltd. All rights reserved.
//

#import "NSWindow+Fookoff.h"
#import "FookoffPlugin.h"
#import "NSApplication+Fookoff.h"

@implementation FookoffPlugin

+ (void)load
{
    @autoreleasepool
    {
        [NSApplication fookoff];
        [NSWindow fookoff];
        NSLog(@"FOOKOFF: Injected");
    }
}

@end
