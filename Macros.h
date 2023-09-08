#import "KittyMemory/writeData.hpp"
#import "KittyMemory/MemoryPatch.hpp"
#include <substrate.h>
#include <mach-o/dyld.h>


#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^
#define HOOK(offset, ptr, orig) MSHookFunction((void *)getRealOffset(offset), (void *)ptr, (void **)&orig)
#define HOOK_NO_ORIG(offset, ptr) MSHookFunction((void *)getRealOffset(offset), (void *)ptr, NULL)
#define HOOKSYM(sym, ptr, org) MSHookFunction((void*)dlsym((void *)RTLD_DEFAULT, sym), (void *)ptr, (void **)&org)
#define HOOKSYM_NO_ORIG(sym, ptr)  MSHookFunction((void*)dlsym((void *)RTLD_DEFAULT, sym), (void *)ptr, NULL)
#define getSym(symName) dlsym((void *)RTLD_DEFAULT, symName)



uint64_t getRealOffset(uint64_t offset)
{
	return KittyMemory::getAbsoluteAddress("UnityFramework", offset);
}


bool patchOffset(uint64_t offset, unsigned long long data) {
	if(data < 0xFFFFFFFF) {
		data = _OSSwapInt32(data);
		return MemoryPatch("UnityFramework",offset, &data, sizeof(uint32_t)).Modify();
	} else {
		data = _OSSwapInt64(data);
		return MemoryPatch("UnityFramework",offset, &data, sizeof(uint64_t)).Modify();
	}
}

