BINDDIR=/src/binding
XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
PROJECT_ROOT=NativeProtocol
PROJECT=$(PROJECT_ROOT)/NativeProtocol.xcodeproj
TARGET=NativeProtocol
BTOUCH=/Developer/MonoTouch/usr/bin/btouch-native


all: mobix.nativeprotocol.dll

libNativeProtocol-i386.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphonesimulator/lib$(TARGET).a $@

libNativeProtocol-armv7.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7 -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $@

libNativeProtocol-armv64.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch arm64 -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $@

libNativeProtocolUniversal.a: libNativeProtocol-armv7.a libNativeProtocol-armv64.a libNativeProtocol-i386.a 
	lipo -create -output $@ $^

mobix.nativeprotocol.dll: linkwith.cs ApiDefinition.cs  libNativeProtocolUniversal.a
	$(BTOUCH) -unsafe -out:$@ ApiDefinition.cs -x=linkwith.cs --link-with=libNativeProtocolUniversal.a,libNativeProtocolUniversal.a

clean:
	-rm -f *.a *.dll
