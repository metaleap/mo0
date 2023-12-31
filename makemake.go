package main

import (
	"encoding/json"
	"io/fs"
	"os"
	"path/filepath"
	"slices"
	"strings"
)

type Prog struct {
	name         string
	libs         []string
	inclDirPaths []string
}

type MakeRule struct {
	outPath      string
	inPath       string
	makeDepPaths []string
	inclDirPaths []string
}

type ClangCompileCommand struct {
	Dir  string   `json:"directory"`
	File string   `json:"file"`
	Args []string `json:"arguments"`
}

const makefilePrelude = `# DO NOT EDIT: auto-generated by makemake.go via build_*.sh

CXX = c++
CXXFLAGS = --debug -std=c++20 -march=native -O0 -DSDL2=1 -DLUA_USE_POSIX=1 -DWI_UNORDERED_MAP_TYPE=2

`

var (
	clangCompileCommandBegin = []string{"c++", // keep in-sync as makes sense with the above `makefilePrelude`
		"--debug", "-std=c++20", "-march=native", "-O0",
		"-DSDL2=1", "-DLUA_USE_POSIX=1", "-DWI_UNORDERED_MAP_TYPE=2",
		"-c"}

	strEnds   = strings.HasSuffix
	strBegins = strings.HasPrefix
	strIdx    = strings.IndexByte

	progs = []Prog{
		{name: "mo_noiselib_tuts",
			libs:         []string{"noise"},
			inclDirPaths: []string{"libnoise/include"}},

		{name: "mo2d",
			libs:         []string{"noise", "imgui", "imgui-sfml", "sfml-graphics", "sfml-window", "sfml-system", "GL"},
			inclDirPaths: []string{"libnoise/include", "imgui", "imgui-sfml"}},

		{name: "mo3d",
			libs:         []string{"imgui", "SDL2", "WickedEngine"},
			inclDirPaths: []string{"imgui", "/usr/include/SDL2", "WickedEngine/WickedEngine"}},
	}
)

func main() {
	var clang_compile_commands []ClangCompileCommand
	cur_dir_path := fsAbs(".")
	var all_cpp_source_file_paths []string
	molib_obj_paths := map[string]bool{}

	fs.WalkDir(os.DirFS(cur_dir_path), ".", func(fsPath string, fsEntry fs.DirEntry, err error) error {
		if err != nil {
			panic(err)
		}
		idx_slash := strIdx(fsPath, '/')
		if (idx_slash <= 0) || !strBegins(fsPath, "mo") {
			return nil
		}
		prog_name := fsPath[:idx_slash]
		prog := prog(prog_name)
		if prog == nil {
			return nil
		}

		if is_cpp, is_h := strEnds(fsPath, ".cpp"), strEnds(fsPath, ".h"); strBegins(fsPath, "mo") && (!fsEntry.IsDir()) && (is_cpp || is_h) {
			if strBegins(fsPath, "mo/") {
				molib_obj_paths[fsCppPathToObjPath(fsPath)] = true
			}
			if is_cpp {
				all_cpp_source_file_paths = append(all_cpp_source_file_paths, fsPath)
				cccmd := ClangCompileCommand{
					Dir:  cur_dir_path,
					File: fsPath,
					Args: append(clangCompileCommandBegin, fsPath, "-o", "/dev/null/dummy"),
				}
				cccmd.Args = append(cccmd.Args, inclDirectives(prog.inclDirPaths)...)
				clang_compile_commands = append(clang_compile_commands, cccmd)
			}
		}
		return nil
	})

	var rules []MakeRule
	for _, source_file_path := range all_cpp_source_file_paths {
		prog := prog(source_file_path[:strIdx(source_file_path, '/')])
		rule := MakeRule{
			inPath:  source_file_path,
			outPath: fsCppPathToObjPath(source_file_path),
		}
		if prog != nil {
			rule.inclDirPaths = prog.inclDirPaths
		}
		src := fsRead(rule.inPath)
		for again, needle_incl := true, "#include \""; again; {
			idx_incl := strings.LastIndex(src, needle_incl)
			if again = (idx_incl >= 0); again {
				idx_off := idx_incl + len(needle_incl)
				idx_quot := strIdx(src[idx_off:], '"')
				if again, idx_quot = (idx_quot > 0), idx_off+idx_quot; again {
					h_file_path := filepath.Join(filepath.Dir(rule.inPath), src[idx_off:idx_quot])
					cpp_file_path := h_file_path[:len(h_file_path)-len(".h")] + ".cpp"
					for _, src_file_path := range []string{h_file_path, cpp_file_path} {
						if fsIsFile(src_file_path) && slices.Index(rule.makeDepPaths, src_file_path) < 0 {
							rule.makeDepPaths = append(rule.makeDepPaths, src_file_path)
						}
					}
					src = src[:idx_incl]
				}
			}
		}
		rules = append(rules, rule)
	}

	var buf strings.Builder
	buf.WriteString(makefilePrelude)
	{
		for _, rule := range rules {
			for _, prog := range progs {
				if rule.outPath == "bin/"+prog.name+"_main.o" {
					obj_file_paths, is_first := []string{rule.outPath}, true
					for _, src_file_path := range all_cpp_source_file_paths {
						if strBegins(src_file_path, prog.name+"/") {
							if out_path := "bin/" + fsCppPathToObjName(src_file_path) + ".o"; (out_path != rule.outPath) && !slices.Contains(obj_file_paths, out_path) {
								obj_file_paths = append(obj_file_paths, out_path)
							}
						}
					}

					buf.WriteString("bin/" + prog.name + ".exec")
					for _, obj_file_path := range obj_file_paths {
						buf.WriteString(iIf(is_first, ": ", " ") + obj_file_path)
						is_first = false
					}
					for obj_file_path := range molib_obj_paths {
						buf.WriteString(" " + obj_file_path)
					}
					buf.WriteByte('\n')
					buf.WriteString("\t$(CXX) $(CXXFLAGS) -Lbin")
					for _, lib_name := range prog.libs {
						buf.WriteString(" -l" + lib_name)
					}
					for _, obj_file_path := range obj_file_paths {
						buf.WriteString(" " + obj_file_path)
					}
					for obj_file_path := range molib_obj_paths {
						buf.WriteString(" " + obj_file_path)
					}
					buf.WriteString(" -o bin/" + prog.name + ".exec\n")
					buf.WriteByte('\n')
					break
				}
			}
		}
	}
	{
		buf.WriteString(`
clean:
	rm -f bin/*.o
	rm -f bin/*.exec
# NOTE on clean: bin dir is NOT to be emptied — eg. all bin/*.so files _stay_! they're more-seldomly updated 3rd-party deps, and they're rebuilt not with this generated makefile but the manually-written sibling one.
`)
		buf.WriteByte('\n')
	}
	for _, rule := range rules {
		buf.WriteString(rule.outPath + ": " + rule.inPath)
		for _, dep := range rule.makeDepPaths {
			if dep != rule.inPath {
				buf.WriteString(" " + dep)
			}
		}
		buf.WriteString("\n\t$(CXX) -c $(CXXFLAGS)")
		for _, incl_directive := range inclDirectives(rule.inclDirPaths) {
			buf.WriteString(" " + incl_directive)
		}
		buf.WriteString(" " + rule.inPath + " -o " + rule.outPath + "\n")
		buf.WriteByte('\n')
	}
	fsWrite("makefile", buf.String())

	src_clang_compile_commands, _ := json.MarshalIndent(clang_compile_commands, "", "  ")
	fsWrite("compile_commands.json", string(src_clang_compile_commands))
}

func iIf[T any](b bool, t T, f T) T {
	if b {
		return t
	}
	return f
}

func fsCppPathToObjPath(fsPath string) string {
	return "bin/" + fsCppPathToObjName(fsPath) + ".o"
}

func fsCppPathToObjName(fsPath string) string {
	idx := strings.LastIndexByte(fsPath, '.')
	return strings.ReplaceAll(fsPath[:idx], "/", "_")
}

func fsIsFile(fsPath string) bool {
	stat, err := os.Stat(fsPath)
	return (err == nil) && (stat != nil) && !stat.IsDir()
}

func fsRead(fsPath string) string {
	raw, err := os.ReadFile(fsPath)
	if err != nil {
		panic(err)
	}
	return string(raw)
}

func fsWrite(fsPath string, src string) {
	err := os.WriteFile(fsPath, []byte(src), os.ModePerm)
	if err != nil {
		panic(err)
	}
}

func fsAbs(fsPath string) string {
	ret, err := filepath.Abs(fsPath)
	if err != nil {
		panic(err)
	}
	return ret
}

func prog(name string) *Prog {
	for i := range progs {
		if progs[i].name == name {
			return &progs[i]
		}
	}
	return nil
}

func inclDirectives(inclDirPaths []string) []string {
	return sl(inclDirPaths, func(s string) string {
		return "-I" + iIf(strBegins(s, "/"), s, "libdeps/"+s)
	})
}

func sl[TIn any, TRet any](sl []TIn, f func(TIn) TRet) (ret []TRet) {
	ret = make([]TRet, len(sl))
	for i := range sl {
		ret[i] = f(sl[i])
	}
	return
}
