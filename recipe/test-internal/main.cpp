// Uses the internal spvtools::opt API through the private headers, the way
// Tint (Dawn's shader compiler) does.
#include <cstdio>

#include "source/opt/build_module.h"
#include "source/opt/ir_context.h"
#include "source/opt/resolve_binding_conflicts_pass.h"
#include "source/opt/split_combined_image_sampler_pass.h"

namespace {

// OpCapability Shader; OpMemoryModel Logical GLSL450
const uint32_t kWords[] = {0x07230203, 0x00010000, 0, 1, 0,
                           0x00020011, 1, 0x0003000e, 0, 1};

void consumer(spv_message_level_t, const char*, const spv_position_t&, const char* message) {
    std::printf("spirv-tools: %s\n", message);
}

bool run(spvtools::opt::Pass& pass) {
    auto context = spvtools::BuildModule(SPV_ENV_UNIVERSAL_1_0, consumer, kWords,
                                         sizeof(kWords) / sizeof(kWords[0]));
    if (!context) {
        std::printf("BuildModule failed\n");
        return false;
    }
    context->get_def_use_mgr();
    context->get_type_mgr();
    const auto status = pass.Run(context.get());
    std::printf("%s: status %d\n", pass.name(), static_cast<int>(status));
    return status != spvtools::opt::Pass::Status::Failure;
}

}  // namespace

int main() {
    spvtools::opt::SplitCombinedImageSamplerPass split;
    spvtools::opt::ResolveBindingConflictsPass resolve;
    const bool ok = run(split) && run(resolve);
    return ok ? 0 : 1;
}
