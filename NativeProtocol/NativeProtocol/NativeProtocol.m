
#import "NativeProtocol.h"

@interface NativeRequestInterceptorProtocol ()

@end

@implementation NativeRequestInterceptorProtocol

static id<NSURLProtocolProxy>  proxy;

+ (void)setProxyProxy:(id<NSURLProtocolProxy>)_proxy {
    proxy = _proxy;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [proxy canInitWithRequest:request];
}

- (void)startLoading {
    [proxy startLoadingWithProtocol:self];
}

- (void)stopLoading {}

@end
