# abledecoder

Decrypts Ableton DRM-protected `*.aif` files

## Installation

This works on *nix like systems. Replace `apt` by your package provider and it should work. On Windows the easiest way to make this work is using Ubuntu Subsystem (TODO doc).

Install dependencies, then run the build file.

```bash
# Installs gcc, make, etc.
sudo apt install build-essential

# Installs libssl for crypto functions
sudo apt install libssl-dev

# Runs the build script
./build.sh
```

The build script might fail with this error:

```
/usr/bin/ld: AbleChunk.o: in function `AbleChunk::decryptKey(Array<unsigned char> const&)':
/home/alex/Projects/abledecoder/AbleChunk.cpp:24: undefined reference to `EVP_CIPHER_CTX_new'
/usr/bin/ld: /home/alex/Projects/abledecoder/AbleChunk.cpp:26: undefined reference to `EVP_bf_cbc'
...
```

Then change the [library linker flags order](https://stackoverflow.com/a/56658568) in the build script, placing `-lcrypto -lssl` at the end of the compiling command (see comment in build.sh).

## Usage

```bash
# Runs the abledecoder
./abledecoder myaiffile.aif myaifile-decoded.aif

# Runs the abledecoder on a hierrachy of folder
./rabledecoder myaiffolder myaiffolder-decoded
```

