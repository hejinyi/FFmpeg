#include <limits.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>

#include <cutils/ashmem.h>
#include <cutils/log.h>
#include <cutils/atomic.h>

#include <hardware/hardware.h>
#include <hardware/gralloc.h>

#include "gralloc_priv.h"
#include "gr.h"

int main(int, char**) {
    alloc_device_t  *mAllocDev;
    hw_module_t const* module;

    int err = hw_get_module(GRALLOC_HARDWARE_MODULE_ID, &module);
    if (err == 0) {
        gralloc_device_open(module, GRALLOC_HARDWARE_FB0, &mAllocDev);
    }

    int outStride = 0;
    buffer_handle_t *handle;
    mAllocDev->alloc(mAllocDev, 100,
            100, HAL_PIXEL_FORMAT_RGBA_8888, GRALLOC_USAGE_HW_FB, handle,
            &outStride);
    private_handle_t const* hnd = reinterpret_cast<private_handle_t const*>(*handle);
    memset((void*)hnd->base, 128, hnd->size);

    return 0;
}
