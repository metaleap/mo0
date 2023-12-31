#pragma once

#include <SFML/Window/Event.hpp>
#include <filesystem>

#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/Shader.hpp>
#include <SFML/Graphics/Texture.hpp>
#include <SFML/System/Time.hpp>

#include "../appview.h"


const auto shaderSrcScratchpadDefault = "uniform vec2 u_resolution;"
                                        "\nvoid main() {"
                                        "\n  vec2 st = gl_FragCoord.xy/u_resolution;"
                                        "\n  gl_FragColor = vec4(st.x,st.y,0.0,1.0);"
                                        "\n}";
const auto glslBuiltins1DShaderFilePath =
    "../mo2d/appviews/shaderview/shaders/glsl_builtin_1d_cheatsheet_preview_dont_rename.frag";
const auto glslBuiltins2DShaderFilePath =
    "../mo2d/appviews/shaderview/shaders/glsl_builtin_2d_cheatsheet_preview_dont_rename.frag";


struct Shader {
    std::filesystem::path filePath = "";
    std::string src = "";
    bool didLoadFail = false;
    bool isCurrent = false;
    bool didUserModifyLive = false;
    std::time_t timeLastReloadedFromFs = 0;
};


struct ShaderView : AppView {
    void ensureGlslBuiltinsCheatsheetImageFiles();

    ShaderView();

    void onUpdate(const sf::Time &delta);
    void onRender(sf::RenderWindow &window);
    void onInput(const sf::Event &evt);

    bool setupAndLoadResources();
    void maybeReloadCurrentShader(Shader* curShader, bool force, bool load = true);
    void guiShaders();
    void guiCheatSheets();

    std::time_t timeStarted = std::time(nullptr);
    sf::Texture bgTexture;
    sf::RectangleShape rect;
    sf::Shader shader;
    std::vector<Shader> shaders;
};
