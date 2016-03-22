.PHONY: all debug install clean

debug:
	sh build_native.sh
	ant debug
	adb install -r bin/zombie-zoo-debug.apk

release:
	sh build_native
	ant release
	adb install -r bin/zombie-zoo-release.apk

clean:
	sh clean.sh
	ant clean

install:
	adb install -r bin/zombie-zoo-debug.apk