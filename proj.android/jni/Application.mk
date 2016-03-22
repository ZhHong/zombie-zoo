APP_STL := gnustl_static
APP_CPPFLAGS := -frtti -std=c++11 -Wno-literal-suffix -fsigned-char -Os $(CPPFLAGS)

APP_DEBUG := $(strip $(NDK_DEBUG))
ifeq ($(APP_DEBUG),1)
  APP_CPPFLAGS += -DCOCOS2D_DEBUG=1
  APP_OPTIM := debug
else
  APP_CPPFLAGS += -DNDEBUG
  APP_OPTIM := release
endif

APP_ABI := armeabi
APP_PLATFORM := android-14
NDK_TOOLCHAIN_VERSION = 4.8

CC_USE_CURL := 1
APP_CPPFLAGS += -DCC_USE_CURL=1

CC_USE_JPEG := 1
APP_CPPFLAGS += -DCC_USE_JPEG=1

CC_USE_TIFF := 1
APP_CPPFLAGS += -DCC_USE_TIFF=1

CC_USE_WEBP := 1
APP_CPPFLAGS += -DCC_USE_WEBP=1

CC_USE_TGA := 1
APP_CPPFLAGS += -DCC_USE_TGA=1

CC_USE_PHYSICS := 1
APP_CPPFLAGS += -DCC_USE_PHYSICS=1

CC_USE_WEBSOCKET := 1
APP_CPPFLAGS += -DCC_USE_WEBSOCKET=1

CC_USE_JSON := 1
APP_CPPFLAGS += -DCC_USE_JSON=1
APP_CFLAGS += -DCC_USE_JSON=1

CC_USE_SQLITE := 1
APP_CPPFLAGS += -DCC_USE_SQLITE=1
APP_CFLAGS += -DCC_USE_SQLITE=1

CC_USE_CCS_ARMATURE := 1
APP_CPPFLAGS += -DCC_USE_CCS_ARMATURE=1

CC_USE_EXTRA_FILTERS := 1
APP_CPPFLAGS += -DCC_USE_EXTRA_FILTERS=1

$(warning $(APP_CPPFLAGS))