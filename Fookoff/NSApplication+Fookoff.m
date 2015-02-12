#import "NSApplication+Fookoff.h"
#import "SwizzleHelper.h"

@implementation NSApplication (Fookoff)

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
            [SwizzleHelper swizzleInstanceMethod:@selector(activateIgnoringOtherApps:)
                                      toSelector:@selector(dontActivateIgnoringOtherApps:)
                                         inClass:klass];
        }
    });
}

- (void)dontActivateIgnoringOtherApps:(BOOL)flag
{
    NSLog(@"FOOKOFF: [%@ dontActivateIgnoringOtherApps:%@]", NSStringFromClass([self class]), flag ? @"YES" : @"NO");
}

@end
