
#import <Foundation/Foundation.h>

@protocol NSURLProtocolProxy
- (BOOL)canInitWithRequest:(NSURLRequest *)request;
- (void)startLoadingWithProtocol:(NSURLProtocol*)protocol;
@end

@interface NativeRequestInterceptorProtocol : NSURLProtocol
+ (void)setProxyProxy:(id<NSURLProtocolProxy>)_proxy;
@end
