# DO NOT EDIT: auto-generated by makemake.go via build_*.sh

CXX = g++
CXXFLAGS = --debug -std=c++20 -march=native


bin/mo2d.exec: bin/mo2d_main.o bin/mo2d_appviews_liveview_liveview.o bin/mo2d_appviews_mapgenview_libnoise_utils_noiseutils.o bin/mo2d_appviews_mapgenview_mapgenview.o bin/mo2d_appviews_shaderview_gui_cheatsheets.o bin/mo2d_appviews_shaderview_gui_shaders.o bin/mo2d_appviews_shaderview_shaderview.o bin/mo2d_gui_gui.o bin/mo_mo.o bin/mo_util_imgui_nodes_nodes.o
	$(CXX) $(CXXFLAGS) -Lbin -lnoise -limgui -limgui-sfml -lsfml-graphics -lsfml-window -lsfml-system -lGL bin/mo2d_gui_gui.o bin/mo2d_main.o bin/mo2d_appviews_liveview_liveview.o bin/mo2d_appviews_mapgenview_libnoise_utils_noiseutils.o bin/mo2d_appviews_mapgenview_mapgenview.o bin/mo2d_appviews_shaderview_gui_cheatsheets.o bin/mo2d_appviews_shaderview_gui_shaders.o bin/mo2d_appviews_shaderview_shaderview.o bin/mo_mo.o bin/mo_util_imgui_nodes_nodes.o -o bin/mo2d.exec

bin/mo_noiselib_tuts.exec: bin/mo_noiselib_tuts_main.o bin/mo_noiselib_tuts_noiseutils.o bin/mo_noiselib_tuts_tuts.o bin/mo_util_imgui_nodes_nodes.o bin/mo_mo.o
	$(CXX) $(CXXFLAGS) -Lbin -lnoise -limgui bin/mo_noiselib_tuts_main.o bin/mo_noiselib_tuts_noiseutils.o bin/mo_noiselib_tuts_tuts.o bin/mo_util_imgui_nodes_nodes.o bin/mo_mo.o -o bin/mo_noiselib_tuts.exec


clean:
	rm -f bin/*.o
	rm -f bin/*.exec
# NOTE on clean: bin isn't to be emptied, all bin/*.so files _stay_! they're rarely or never updated 3rd-party deps, and they're rebuilt not with this generated makefile but the manually-written sibline one.

bin/mo_mo.o: mo/mo.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo/mo.cpp -o bin/mo_mo.o

bin/mo_util_imgui_nodes_nodes.o: mo/util/imgui_nodes/nodes.cpp mo/util/imgui_nodes/nodes.h mo/util/imgui_nodes/nodes.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo/util/imgui_nodes/nodes.cpp -o bin/mo_util_imgui_nodes_nodes.o

bin/mo2d_appviews_liveview_liveview.o: mo2d/appviews/liveview/liveview.cpp mo2d/appviews/liveview/liveview.h mo2d/appviews/liveview/liveview.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/liveview/liveview.cpp -o bin/mo2d_appviews_liveview_liveview.o

bin/mo2d_appviews_mapgenview_libnoise_utils_noiseutils.o: mo2d/appviews/mapgenview/libnoise_utils/noiseutils.cpp mo2d/appviews/mapgenview/libnoise_utils/noiseutils.h mo2d/appviews/mapgenview/libnoise_utils/noiseutils.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/mapgenview/libnoise_utils/noiseutils.cpp -o bin/mo2d_appviews_mapgenview_libnoise_utils_noiseutils.o

bin/mo2d_appviews_mapgenview_mapgenview.o: mo2d/appviews/mapgenview/mapgenview.cpp mo2d/appviews/mapgenview/mapgenview.h mo2d/appviews/mapgenview/mapgenview.cpp mo2d/appviews/mapgenview/libnoise_utils/noiseutils.h mo2d/appviews/mapgenview/libnoise_utils/noiseutils.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/mapgenview/mapgenview.cpp -o bin/mo2d_appviews_mapgenview_mapgenview.o

bin/mo2d_appviews_shaderview_gui_cheatsheets.o: mo2d/appviews/shaderview/gui_cheatsheets.cpp mo2d/appviews/shaderview/shaderview.h mo2d/appviews/shaderview/shaderview.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/shaderview/gui_cheatsheets.cpp -o bin/mo2d_appviews_shaderview_gui_cheatsheets.o

bin/mo2d_appviews_shaderview_gui_shaders.o: mo2d/appviews/shaderview/gui_shaders.cpp mo2d/appviews/shaderview/shaderview.h mo2d/appviews/shaderview/shaderview.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/shaderview/gui_shaders.cpp -o bin/mo2d_appviews_shaderview_gui_shaders.o

bin/mo2d_appviews_shaderview_shaderview.o: mo2d/appviews/shaderview/shaderview.cpp mo2d/appviews/shaderview/shaderview.h mo2d/appviews/shaderview/shaderview.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/appviews/shaderview/shaderview.cpp -o bin/mo2d_appviews_shaderview_shaderview.o

bin/mo2d_gui_gui.o: mo2d/gui/gui.cpp mo2d/gui/gui.h mo2d/gui/gui.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/gui/gui.cpp -o bin/mo2d_gui_gui.o

bin/mo2d_main.o: mo2d/main.cpp mo2d/appviews/mapgenview/mapgenview.h mo2d/appviews/mapgenview/mapgenview.cpp mo2d/appviews/shaderview/shaderview.h mo2d/appviews/shaderview/shaderview.cpp mo2d/appviews/liveview/liveview.h mo2d/appviews/liveview/liveview.cpp mo2d/gui/gui.h mo2d/gui/gui.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo2d/main.cpp -o bin/mo2d_main.o

bin/mo_noiselib_tuts_main.o: mo_noiselib_tuts/main.cpp mo_noiselib_tuts/tuts.h mo_noiselib_tuts/tuts.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo_noiselib_tuts/main.cpp -o bin/mo_noiselib_tuts_main.o

bin/mo_noiselib_tuts_noiseutils.o: mo_noiselib_tuts/noiseutils.cpp mo_noiselib_tuts/noiseutils.h mo_noiselib_tuts/noiseutils.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo_noiselib_tuts/noiseutils.cpp -o bin/mo_noiselib_tuts_noiseutils.o

bin/mo_noiselib_tuts_tuts.o: mo_noiselib_tuts/tuts.cpp mo_noiselib_tuts/noiseutils.h mo_noiselib_tuts/noiseutils.cpp
	$(CXX) -c $(CXXFLAGS) -Ilibdeps/imgui -Ilibdeps/imgui/backends -Ilibdeps/imgui/misc -Ilibdeps/imgui/misc/cpp -Ilibdeps/imgui/misc/freetype -Ilibdeps/imgui/misc/single_file -Ilibdeps/imgui-sfml -Ilibdeps/libnoise -Ilibdeps/libnoise/include -Ilibdeps/libnoise/include/noise -Ilibdeps/libnoise/include/noise/model -Ilibdeps/libnoise/include/noise/module mo_noiselib_tuts/tuts.cpp -o bin/mo_noiselib_tuts_tuts.o

