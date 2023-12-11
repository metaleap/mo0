#pragma once

#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/Graphics/Texture.hpp>

#include "../appview.h"


struct MapGenView : AppView {
    MapGenView();

    void onUpdate(sf::Time delta);
    void onRender(sf::RenderWindow &window);

    sf::Texture previewTinyTex;
    sf::RectangleShape previewTinyRect;
    sf::Texture previewFullTex;
    sf::RectangleShape previewFullRect;
};