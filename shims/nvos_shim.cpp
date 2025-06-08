#include <unistd.h>

extern "C" uint32_t NvOsGetConfigString(const char *name, char *value, uint32_t size);

extern "C" uint32_t NvOsConfigGetState(int dummy1, const char *name, char *value, int size, int dummy2) {
  return NvOsGetConfigString(name, value, size);
}
