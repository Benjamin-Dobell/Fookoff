#import "SwizzleHelper.h"
#import <objc/runtime.h>

@implementation SwizzleHelper

+ (NSArray *)subclassesForClass:(Class)klass
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;

    classes = malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);

    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];

        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != klass);

        if (superClass == nil)
        {
            continue;
        }

        [result addObject:classes[i]];
    }

    free(classes);

    return result;
}

+ (void)swizzleInstanceMethod:(SEL)fromSel toSelector:(SEL)toSel inClass:(Class)klass
{
    Method originalMethod = class_getInstanceMethod(klass, fromSel);
    Method swizzledMethod = class_getInstanceMethod(klass, toSel);

    BOOL didAddMethod = class_addMethod(klass, fromSel,
            method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (didAddMethod)
    {
        class_replaceMethod(klass,
                toSel,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }

    NSLog(@"FOOKOFF: [%@ %@] replaced with %@", NSStringFromClass(klass), NSStringFromSelector(fromSel), NSStringFromSelector(toSel));
}

@end
