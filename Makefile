export THEOS=/theos


ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# 0 to treat warnings as errors, 1 otherwise.
IGNORE_WARNINGS=1



#export TARGET_CC=<YOUR_TOOLCHAINS>/clang
#export TARGET_CXX=<YOUR_TOOLCHAINS>/clang++

copsm_CFLAGS = -fobjc-arc -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function
copsm_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function

#copsm_CFLAGS += -mllvm -enable-bcfobf -mllvm -enable-strcry -mllvm -enable-indibran -mllvm -enable-subobf -mllvm -bcf_prob=99 -mllvm -bcf_loop=2 -mllvm -split_num=9


## Common frameworks ##
PROJ_COMMON_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics CoreText

## source files ##
FLOATNG_SRC = $(wildcard Floating/*.mm)
IMGUI_SRC = $(wildcard imgui/*.mm) $(wildcard imgui/imgui/*.cpp) $(wildcard imgui/imgui/render/*.mm)
UTILS_SRC = $(wildcard Utils/*.m) $(wildcard Utils/*.cpp)
KITTYMEMORY_SRC = $(wildcard KittyMemory/*.cpp) $(wildcard KittyMemory/*.mm)


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = copsm


ifeq ($(IGNORE_WARNINGS),1)
  copsm_CFLAGS += -w
  copsm_CCFLAGS += -w
endif


copsm_FILES = Drawzb.mm Drawst.xm UTFMaster/ConvertUTF.c $(FLOATNG_SRC) $(UTILS_SRC) $(IMGUI_SRC) $(KITTYMEMORY_SRC) #UTFMaster/utf.c

copsm_LIBRARIES += substrate

copsm_FRAMEWORKS = $(PROJ_COMMON_FRAMEWORKS)
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
