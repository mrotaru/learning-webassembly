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

