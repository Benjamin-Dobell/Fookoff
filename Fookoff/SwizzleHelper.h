#import <Foundation/Foundation.h>

@interface SwizzleHelper : NSObject

+ (NSArray *)subclassesForClass:(Class)klass;
+ (void)swizzleInstanceMethod:(SEL)fromSel toSelector:(SEL)toSel inClass:(Class)klass;

@end
