(module
   (;
    - this is a mult-line comment
    - another line here
   ;)
   (func $add (param $a i32) (param $b i32) (result i32) 
      ;; single line comment
      get_local $a 
      get_local $b 
      i32.add
   )
   (export "add" (func $add))
)
