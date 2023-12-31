#include <cmath>
#include <cstdio>

#include <ctime>
#include <noise/noise.h>
#include <noise/module/perlin.h>
#include <noise/module/select.h>
#include <noise/module/turbulence.h>
#include "noiseutils.h"




void tut_2() {
    noise::module::Perlin module_perlin;
    double value = module_perlin.GetValue(14.5, 20.25, 75.75);
    printf("%f\n", value);
}

void tut_3_4() {
    noise::module::Perlin module_perlin;
    module_perlin.SetPersistence(0.55);

    utils::NoiseMap height_map;
    utils::NoiseMapBuilderPlane height_map_builder;
    height_map_builder.SetSourceModule(module_perlin);
    height_map_builder.SetDestNoiseMap(height_map);
    height_map_builder.SetDestSize(1024, 512);
    height_map_builder.SetBounds(2.0, 10.0, 1.0, 5.0);
    height_map_builder.Build();

    utils::RendererImage renderer;
    utils::Image image;
    renderer.SetSourceNoiseMap(height_map);
    renderer.SetDestImage(image);
    {
        renderer.ClearGradient();
        renderer.AddGradientPoint(-1.0000, utils::Color(0, 0, 128, 255));    // deeps
        renderer.AddGradientPoint(-0.2500, utils::Color(0, 0, 255, 255));    // shallow
        renderer.AddGradientPoint(0.0000, utils::Color(0, 128, 255, 255));   // shore
        renderer.AddGradientPoint(0.0625, utils::Color(240, 240, 64, 255));  // sand
        renderer.AddGradientPoint(0.1250, utils::Color(32, 160, 0, 255));    // grass
        renderer.AddGradientPoint(0.3750, utils::Color(224, 224, 0, 255));   // dirt
        renderer.AddGradientPoint(0.7500, utils::Color(128, 128, 128, 255)); // rock
        renderer.AddGradientPoint(1.0000, utils::Color(255, 255, 255, 255)); // snow
        renderer.EnableLight();
        renderer.SetLightContrast(4.0);
        renderer.SetLightBrightness(2.0);
    }
    renderer.Render();

    utils::WriterBMP writer_bmp;
    writer_bmp.SetSourceImage(image);
    writer_bmp.SetDestFilename("../.local/tut_3_4.bmp");
    writer_bmp.WriteDestFile();

    printf("%fsec\n", ((double_t)(clock())) / ((double_t)(CLOCKS_PER_SEC)));
}

void tut_5() {
    module::RidgedMulti mountainTerrain;
    module::Billow baseFlatTerrain;
    baseFlatTerrain.SetFrequency(2.0);
    module::ScaleBias flatTerrain;
    flatTerrain.SetSourceModule(0, baseFlatTerrain);
    flatTerrain.SetScale(0.125);
    flatTerrain.SetBias(-0.75);
    module::Perlin terrainType;
    terrainType.SetFrequency(0.5);
    terrainType.SetPersistence(0.25);
    module::Select finalTerrain;
    finalTerrain.SetSourceModule(0, flatTerrain);
    finalTerrain.SetSourceModule(1, mountainTerrain);
    finalTerrain.SetControlModule(terrainType);
    finalTerrain.SetBounds(0.0, 1000.0);
    finalTerrain.SetEdgeFalloff(0.125);

    utils::NoiseMap heightMap;
    utils::NoiseMapBuilderPlane heightMapBuilder;
    // heightMapBuilder.SetSourceModule(mountainTerrain);
    // heightMapBuilder.SetSourceModule(baseFlatTerrain);
    // heightMapBuilder.SetSourceModule(flatTerrain);
    heightMapBuilder.SetSourceModule(finalTerrain);
    heightMapBuilder.SetDestNoiseMap(heightMap);
    heightMapBuilder.SetDestSize(1024, 512);
    heightMapBuilder.SetBounds(2.0, 10.0, 1.0, 5.0);
    heightMapBuilder.Build();

    utils::RendererImage renderer;
    utils::Image image;
    renderer.SetSourceNoiseMap(heightMap);
    renderer.SetDestImage(image);
    {
        renderer.ClearGradient();
        renderer.AddGradientPoint(-1.00, utils::Color(32, 160, 0, 255));   // grass
        renderer.AddGradientPoint(-0.25, utils::Color(224, 224, 0, 255));  // dirt
        renderer.AddGradientPoint(0.25, utils::Color(128, 128, 128, 255)); // rock
        renderer.AddGradientPoint(1.00, utils::Color(255, 255, 255, 255)); // snow
        renderer.EnableLight();
        renderer.SetLightContrast(3.0);
        renderer.SetLightBrightness(2.0);
    }
    renderer.Render();

    utils::WriterBMP writer_bmp;
    writer_bmp.SetSourceImage(image);
    writer_bmp.SetDestFilename("../.local/tut_5_4.bmp");
    writer_bmp.WriteDestFile();

    printf("%fsec\n", ((double_t)(clock())) / ((double_t)(CLOCKS_PER_SEC)));
}

void tut_6() {
    module::RidgedMulti mountainTerrain;
    module::Billow baseFlatTerrain;
    baseFlatTerrain.SetFrequency(2.0);
    module::ScaleBias flatTerrain;
    flatTerrain.SetSourceModule(0, baseFlatTerrain);
    flatTerrain.SetScale(0.125);
    flatTerrain.SetBias(-0.75);
    module::Perlin terrainType;
    terrainType.SetFrequency(0.5);
    terrainType.SetPersistence(0.25);
    module::Select terrainSelector;
    terrainSelector.SetSourceModule(0, flatTerrain);
    terrainSelector.SetSourceModule(1, mountainTerrain);
    terrainSelector.SetControlModule(terrainType);
    terrainSelector.SetBounds(0.0, 1000.0);
    terrainSelector.SetEdgeFalloff(0.125);
    module::Turbulence finalTerrain;
    finalTerrain.SetSourceModule(0, terrainSelector);
    finalTerrain.SetFrequency(4.0);
    finalTerrain.SetPower(0.125);

    utils::NoiseMap heightMap;
    utils::NoiseMapBuilderPlane heightMapBuilder;
    // heightMapBuilder.SetSourceModule(mountainTerrain);
    // heightMapBuilder.SetSourceModule(baseFlatTerrain);
    // heightMapBuilder.SetSourceModule(flatTerrain);
    heightMapBuilder.SetSourceModule(finalTerrain);
    heightMapBuilder.SetDestNoiseMap(heightMap);
    heightMapBuilder.SetDestSize(1024, 512);
    heightMapBuilder.SetBounds(2.0, 10.0, 1.0, 5.0);
    heightMapBuilder.Build();

    utils::RendererImage renderer;
    utils::Image image;
    renderer.SetSourceNoiseMap(heightMap);
    renderer.SetDestImage(image);
    {
        renderer.ClearGradient();
        renderer.AddGradientPoint(-1.00, utils::Color(32, 160, 0, 255));   // grass
        renderer.AddGradientPoint(-0.25, utils::Color(224, 224, 0, 255));  // dirt
        renderer.AddGradientPoint(0.25, utils::Color(128, 128, 128, 255)); // rock
        renderer.AddGradientPoint(1.00, utils::Color(255, 255, 255, 255)); // snow
        renderer.EnableLight();
        renderer.SetLightContrast(3.0);
        renderer.SetLightBrightness(2.0);
    }
    renderer.Render();

    utils::WriterBMP writer_bmp;
    writer_bmp.SetSourceImage(image);
    writer_bmp.SetDestFilename("../.local/tut_6.bmp");
    writer_bmp.WriteDestFile();

    printf("%fsec\n", ((double_t)(clock())) / ((double_t)(CLOCKS_PER_SEC)));
}

void tut_8() {
    module::Perlin myModule;
    utils::NoiseMap heightMap;
    utils::NoiseMapBuilderSphere heightMapBuilder;
    heightMapBuilder.SetSourceModule(myModule);
    heightMapBuilder.SetDestNoiseMap(heightMap);
    heightMapBuilder.SetDestSize(1024, 512);
    heightMapBuilder.SetBounds(-90.0, 90.0, -180.0, 180.0);
    heightMapBuilder.Build();

    utils::RendererImage renderer;
    utils::Image image;
    renderer.SetSourceNoiseMap(heightMap);
    renderer.SetDestImage(image);
    {
        renderer.ClearGradient();
        renderer.AddGradientPoint(-1.0000, utils::Color(0, 0, 128, 255));    // deeps
        renderer.AddGradientPoint(-0.2500, utils::Color(0, 0, 255, 255));    // shallow
        renderer.AddGradientPoint(0.0000, utils::Color(0, 128, 255, 255));   // shore
        renderer.AddGradientPoint(0.0625, utils::Color(240, 240, 64, 255));  // sand
        renderer.AddGradientPoint(0.1250, utils::Color(32, 160, 0, 255));    // grass
        renderer.AddGradientPoint(0.3750, utils::Color(224, 224, 0, 255));   // dirt
        renderer.AddGradientPoint(0.7500, utils::Color(128, 128, 128, 255)); // rock
        renderer.AddGradientPoint(1.0000, utils::Color(255, 255, 255, 255)); // snow
        renderer.EnableLight();
        renderer.SetLightContrast(3.0);
        renderer.SetLightBrightness(2.0);
    }
    renderer.Render();

    utils::WriterBMP writer;
    writer.SetSourceImage(image);
    writer.SetDestFilename("../.local/tut_8.bmp");
    writer.WriteDestFile();

    printf("%fsec\n", ((double_t)(clock())) / ((double_t)(CLOCKS_PER_SEC)));
}
