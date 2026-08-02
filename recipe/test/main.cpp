#include <spirv-tools/libspirv.h>
#include <spirv-tools/optimizer.hpp>

int main() {
    spvtools::Optimizer optimizer(SPV_ENV_UNIVERSAL_1_0);
    return spvSoftwareVersionString() == nullptr ? 1 : 0;
}
