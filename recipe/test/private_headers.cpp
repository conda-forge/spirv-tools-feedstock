// Uses the internal spvtools::opt API the way Tint (Dawn) does.
#include "source/opt/build_module.h"
#include "source/opt/ir_context.h"
#include "source/opt/split_combined_image_sampler_pass.h"

int main() {
    // OpCapability Shader; OpMemoryModel Logical GLSL450
    const uint32_t words[] = {0x07230203, 0x00010000, 0, 1, 0,
                              0x00020011, 1, 0x0003000e, 0, 1};
    auto context = spvtools::BuildModule(SPV_ENV_UNIVERSAL_1_0, nullptr, words,
                                         sizeof(words) / sizeof(words[0]));
    if (!context) {
        return 1;
    }
    spvtools::opt::SplitCombinedImageSamplerPass pass;
    return pass.Run(context.get()) == spvtools::opt::Pass::Status::Failure ? 1 : 0;
}
