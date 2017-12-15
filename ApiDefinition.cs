
using Foundation;

namespace NativeProtocol
{
	[BaseType(typeof(NSObject))]
	[Model]
	public partial interface NSURLProtocolProxy {
    	[Export ("canInitWithRequest:")]
		bool CanInitWithRequest(NSUrlRequest request);
		
		[Export ("startLoadingWithProtocol:")]
		void StartLoadingWithProtocol(NSUrlProtocol protocol);
	}

	[BaseType (typeof (NSUrlProtocol))]
	public partial interface NativeRequestInterceptorProtocol {
		[Static, Export ("setProxyProxy:")]
		void SetProxyProxy(NSURLProtocolProxy proxy);
	}
}
