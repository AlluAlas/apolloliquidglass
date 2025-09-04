#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define ApolloLog(fmt, ...) NSLog(@" [ApolloFix] " fmt, ##__VA_ARGS__)

@interface ASImageNode : NSObject
+ (UIImage *)createContentsForKey:(id)key drawParameters:(id)parameters isCancelled:(id)cancelled;
@end

%ctor {
    ApolloLog(@"=== TWEAK CONSTRUCTOR CALLED ===");
    ApolloLog(@"Bundle: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
    Class asClas = objc_getClass("ASImageNode");
    if (asClas) {
        ApolloLog(@"ASImageNode class found!");
        
        Method method = class_getClassMethod(asClas, @selector(createContentsForKey:drawParameters:isCancelled:));
        if (method) {
            ApolloLog(@"createContentsForKey method found!");
        } else {
            ApolloLog(@"createContentsForKey method NOT found!");
            
            unsigned int methodCount;
            Method *methods = class_copyMethodList(object_getClass(asClas), &methodCount);
            ApolloLog(@"Available class methods:");
            for (unsigned int i = 0; i < methodCount; i++) {
                SEL selector = method_getName(methods[i]);
                ApolloLog(@"  - %@", NSStringFromSelector(selector));
            }
            free(methods);
        }
    } else {
        ApolloLog(@"ASImageNode class NOT found!");
    }
}

%hook ASImageNode

+ (UIImage *)createContentsForKey:(id)key drawParameters:(id)parameters isCancelled:(id)cancelled {
    ApolloLog(@"HOOK INTERCEPTED! Method called with key: %@", key);
    
    @try {
        UIImage *result = %orig;
        if (result) {
            ApolloLog(@"Original implementation succeeded");
            return result;
        } else {
            ApolloLog(@"Original implementation returned nil");
            return nil;
        }
    }
    @catch (NSException *exception) {
        ApolloLog(@"Exception caught: %@", exception.reason);
        return nil;
    }
}

%end
