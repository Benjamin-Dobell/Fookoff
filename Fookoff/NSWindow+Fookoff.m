//
//  NSWindow.m
//  Fookoff
//
//  Created by Benjamin Dobell on 13/02/2015.
//  Copyright (c) 2015 Glass Echidna Pty Ltd. All rights reserved.
//

#import "NSWindow+Fookoff.h"
#import "objc/runtime.h"
#import "SwizzleHelper.h"

@implementation NSWindow (Fookoff)

+ (void)fookoff
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *classes = [NSMutableArray array];
        [classes addObject:[self class]];

        NSArray *subclasses = [SwizzleHelper subclassesForClass:[self class]];

        for (Class klass in subclasses)
        {
            [classes addObject:klass];
        }

        for (Class klass in classes)
        {
            [SwizzleHelper swizzleInstanceMethod:@selector(canBecomeKeyWindow)
                                      toSelector:@selector(cantBecomeKeyWindow)
                                         inClass:klass];

            [SwizzleHelper swizzleInstanceMethod:@selector(makeKeyAndOrderFront:)
                                      toSelector:@selector(dontMakeKeyAndOrderFront:)
                                         inClass:klass];

            [SwizzleHelper swizzleInstanceMethod:@selector(makeKeyWindow)
                                      toSelector:@selector(dontMakeKeyWindow)
                                         inClass:klass];
        }
    });
}

- (BOOL)cantBecomeKeyWindow
{
    NSLog(@"FOOKOFF: [%@ cantBecomeKeyWindow]", NSStringFromClass([self class]));
    return NO;
}

- (void)dontMakeKeyAndOrderFront:(id)sender
{
    NSLog(@"FOOKOFF: [%@ dontMakeKeyAndOrderFront:]", NSStringFromClass([self class]));
}

- (void)dontMakeKeyWindow
{
    NSLog(@"FOOKOFF: [%@ dontMakeKeyWindow]", NSStringFromClass([self class]));
}

@end
