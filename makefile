# DO NOT EDIT: auto-generated by makemake.go via build_*.sh

CXX = g++
CXXFLAGS = --debug -std=c++20 -march=native


bin/mo2d: bin/mo2d_main.o bin/mo2d_gui_gui.o bin/mo2d_game_game.o
	$(CXX) $(CXXFLAGS) -Lbin -lsfml-graphics -lsfml-window -lsfml-system -lGL -limgui -limgui-sfml bin/mo2d_main.o bin/mo2d_gui_gui.o bin/mo2d_game_game.o -o bin/mo2d

clean:
	rm -f bin/*.o
	rm -f bin/mo2d
# NOTE on clean: all bin/*.so files _stay_! they're rarely or never updated 3rd-party deps.


bin/mo2d_game_game.o: mo2d/game/game.cpp mo2d/game/game.h mo2d/game/game.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui-sfml mo2d/game/game.cpp -o bin/mo2d_game_game.o

bin/mo2d_gui_gui.o: mo2d/gui/gui.cpp mo2d/gui/gui.h mo2d/gui/gui.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui-sfml mo2d/gui/gui.cpp -o bin/mo2d_gui_gui.o

bin/mo2d_main.o: mo2d/main.cpp mo2d/gui/gui.h mo2d/gui/gui.cpp mo2d/game/game.h mo2d/game/game.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui-sfml mo2d/main.cpp -o bin/mo2d_main.o

