# Native Protocol Binding
Project is used as workaround for solving the bug in Xamarin.iOS [Bugzilla.Xamarin](https://bugzilla.xamarin.com/show_bug.cgi?id=52379).

Application becomes freeze and unresponsive when NSUrlProtocol and UIWebView are used.

## Build Dll
To build dll file run:
```
make -f Makefile
```
## Deployment

### Link dll to project
Add mobix.nativeprotocol.dll to References

### Create class for proxying requests
MyInterceptorProtocol not intended to have state. It methods could be invoked from different threads.
```
//MyInterceptorProtocol.cs
using NativeProtocol;

public class MyInterceptorProtocol : NSURLProtocolProxy
{
    public override bool CanInitWithRequest(NSUrlRequest request)
    {
        // check request here
        return false;
    }

    public override void StartLoadingWithProtocol(NSUrlProtocol protocol)
    {
        // load data here
        NSData data = ....;
        
        if (loadedSuccessfull) {
            var headers = new NSMutableDictionary();
            var response = new NSHttpUrlResponse(protocol.Request.Url, (nint)200, "1.1", headers);
            protocol.Client.ReceivedResponse(protocol, response, NSUrlCacheStoragePolicy.NotAllowed);
            protocol.Client.DataLoaded(protocol, data);
            protocol.Client.FinishedLoading(protocol);
        } else {
            protocol.Client.FailedWithError(protocol, new NSError((NSString)protocol.Request.Url.AbsoluteString, (nint)((int)NSUrlError.Unknown)));
        }
    }
}
```

### Register NativeRequestInterceptorProtocol and setup proxy object
```
//AppDelegate.cs
using NativeProtocol;

public partial class MainAppDelegate : UIApplicationDelegate
{
    private MyInterceptorProtocol proxyForNativeProtocol;
    public override bool FinishedLaunching (UIApplication application, NSDictionary launchOptions)
	{
        SetupUrlNSURLProtocol();
        //do other stuff
        return true;
    }

    private void SetupUrlNSURLProtocol() {
        NSUrlProtocol.RegisterClass(new ObjCRuntime.Class(typeof(NativeRequestInterceptorProtocol)));
        proxyForNativeProtocol = new RequestInterceptorProtocol();
        NativeRequestInterceptorProtocol.SetProxyProxy(proxyForNativeProtocol);
    }
}
```

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details