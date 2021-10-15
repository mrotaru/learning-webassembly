# learning WebAssembly

- create a WAT file
```
$ ~/code/learning-wasm/hello.wat <<EOF
(module
   (func $add (param $a i32) (param $b i32) (result i32) 
      get_local $a 
      get_local $b 
      i32.add
   )
   (export "add" (func $add))
)
EOF
```
- to run it from the command line, you need an environment which supports WASM; ex: wasmer (https://wasmer.io/) or nodejs
```
$ curl https://get.wasmer.io -sSfL | sh # install wasmer 
```
- a WAT file can be compiled to a WASM binary, or executed directly
- when compiling with wasmer, default target is "universal"; looks like other options are `--dylib` and `--staticlib`
```
$ wasmer compile add.wat -o add.wasm
warning: the output file has a wrong extension. We recommend using `add.wasmu` for the chosen target
Engine: universal
Compiler: cranelift
Target: x86_64-unknown-linux-gnu
✔ File compiled successfully to `add.wasm`.
```
- to execute a function exported from a wasm binary on the CLI and give it arguments:
```
$ wasmer run add.wasm --invoke add -- 2 3
5
```
- however, looks like `wasmer` doesn't generate bytecode that can be executed from Node:
```
$ node hello.js 
[CompileError: WebAssembly.instantiate(): expected magic word 00 61 73 6d, found 00 77 61 73 @+0]
```
- tried a few different compiler options (`--cranelift`, `--llvm`, ...) but no luck
- from `wasmer` docs it's unclear if it can be used for simply translating the WAT to WASM bytecode
- need to use `wat2wasm` from https://github.com/WebAssembly/wabt
- 
```
$ cd ~/code && git clone --recursive https://github.com/WebAssembly/wabt
$ cd wabt/
$ git submodule update --init
$ mkdir build
$ cd build/
$ cmake ..
$ cmake --build . # this takes a few minutes
$ cp wat2wasm ~/bin # put the resulting binary somewhere in your path
$ cd ~/code/learning-webassembly
$ wat2wasm hello.wat
$ file hello.wasm 
hello.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)

$ node hello.js
hello from wasm!
```

## Resources
### WASM
home: https://webassembly.org/
core spec: https://webassembly.github.io/spec/core/ (includes bin and text)
binary format (WASM) spec: https://webassembly.github.io/spec/core/binary/index.html
text format (WAT) spec: https://webassembly.github.io/spec/core/text/index.html

## WASI
- home: https://github.com/WebAssembly/WASI
- usable from Rust and C/C++
- https://github.com/bytecodealliance/wasmtime/blob/main/docs/WASI-intro.md
- https://github.com/WebAssembly/WASI/blob/main/docs/WASI-overview.md
- https://github.com/WebAssembly/WASI/blob/main/docs/HighLevelGoals.md
- https://github.com/WebAssembly/WASI/blob/main/docs/DesignPrinciples.md
- https://github.com/WebAssembly/meetings/tree/main/wasi

