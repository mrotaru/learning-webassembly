(module
  ;; import a function, as the "printToConsole" property of an "env" js object
  (import "env" "printToConsole" (func $print_to_console(param i32)))

  ;; import a page (64k) of memory - a js typed array
  (import "env" "buffer" (memory 1))

  ;; global vars
  (global $start_memory_offset (import "env" "startMemoryOffset") i32)
  (global $len i32 (i32.const 17))

  ;; data - put something in memory
  (data (global.get $start_memory_offset) "hello from wasm!")

  ;; export func which calls an imported function
  (func (export "hello")
    ;; no stable way of passing references; in this case, the WAT and
    ;; the JS both "agree" beforehand on where this particular data
    ;; will be located in the shared memory - $start_memory_offset
    (call $print_to_console (global.get $len))
  )
)
