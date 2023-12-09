#include <imgui.h>
#include <misc/cpp/imgui_stdlib.h>

#include "shaderview.h"


const std::time_t shader_hot_reload_interval_secs = 2;

void ShaderView::guiShaders() {
    ImGui::Begin("Shaders", nullptr, ImGuiWindowFlags_AlwaysAutoResize);
    Shader* shader_just_selected = nullptr;
    int shader_current_idx = -1;

    for (int i = 0; auto &it : this->shaders) {
        if (it.isCurrent) {
            shader_current_idx = i;
            break;
        }
        i++;
    }

    if (ImGui::BeginCombo("##Shaders",
                          (shader_current_idx < 0) ? "(Select a shader...)"
                                                   : this->shaders[shader_current_idx].filePath.filename().c_str(),
                          ImGuiComboFlags_HeightLargest)) {
        for (int i = 0; auto &it : this->shaders) {
            if (ImGui::Selectable(it.filePath.filename().c_str(), it.isCurrent)) {
                shader_current_idx = i;
                shader_just_selected = &it;
                break;
            }
            i++;
        }
        ImGui::EndCombo();
    }
    if (shader_just_selected != nullptr)
        for (auto &it : this->shaders)
            it.isCurrent = (&it == shader_just_selected);
    if (shader_current_idx >= 0) {
        const auto shader_current = &this->shaders[shader_current_idx];
        if (shader_just_selected != nullptr) {
            if (!shader_current->didUserModifyLive)
                this->maybeReloadCurrentShader(shader_current, true);
            else
                shader_current->didLoadFail = !this->shader.loadFromMemory(shader_current->src, sf::Shader::Fragment);
        } else if (ImGui::InputTextMultiline((std::string("##") + shader_current->filePath.filename().string()).c_str(),
                                             &shader_current->src)) {
            shader_current->didUserModifyLive = true;
            shader_current->didLoadFail = !this->shader.loadFromMemory(shader_current->src, sf::Shader::Fragment);
        } else if (!shader_current->didUserModifyLive) {
            const auto cur_sec = time(nullptr);
            if (((cur_sec % shader_hot_reload_interval_secs) == 0) && (cur_sec != shader_current->timeLastReloadedFromFs))
                maybeReloadCurrentShader(shader_current, false);
        }
        if (shader_current->didUserModifyLive && ImGui::Button("Reload from FS"))
            this->maybeReloadCurrentShader(shader_current, true);
    }
    ImGui::End();
}
