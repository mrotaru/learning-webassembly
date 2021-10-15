const fs = require('fs')

const wasmBytecode = fs.readFileSync('./hello.wasm')

const buffer = new WebAssembly.Memory({ initial: 1 })
const startMemoryOffset = 0

// build the object to be passed to WASM as "env"
const env = {
  printToConsole: (strLen) => {
    // read bytes that were placed in the buffer from WASM
    const bytes = new Uint8Array(buffer.buffer, startMemoryOffset, strLen)

    // convert bytes to a string
    const string = new TextDecoder('utf8').decode(bytes)

    // log the string
    console.log(string)
  },
  startMemoryOffset,
  buffer,
}

// build a WASM module
WebAssembly.instantiate(new Uint8Array(wasmBytecode), { env }).then(instance => {
  // invoke a function exported from the WASM module; the WASM function ("hello")
  // will invoke a JS function we provided in the env object - "printToConsole".
  instance.instance.exports.hello()
}).catch(err => console.error(err))

