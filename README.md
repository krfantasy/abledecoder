# abledecoder

Decrypts Ableton DRM-protected `*.aif` files

## Installation

This works on `*nix` like systems. Replace `apt` by your package provider and it should work. On Windows the easiest way to make this work is using Ubuntu Subsystem (TODO doc).

Install dependencies, then run the build file.

```bash
# Installs gcc, make, etc.
sudo apt install build-essential

# Installs libssl for crypto functions
sudo apt install libssl-dev

# ffmpeg
sudo apt install ffmpeg

# Runs the build script
./build.sh
```

The build script might fail with this error:

```
/usr/bin/ld: AbleChunk.o: in function `AbleChunk::decryptKey(Array<unsigned char> const&)':
/home/alex/Projects/abledecoder/AbleChunk.cpp:24: undefined reference to `EVP_CIPHER_CTX_new'
/usr/bin/ld: /home/alex/Projects/abledecoder/AbleChunk.cpp:26: undefined reference to `EVP_bf_cbc'
```

Then change the [library linker flags order](https://stackoverflow.com/a/56658568) in the build script, placing `-lcrypto -lssl` at the end of the compiling command (see comment in build.sh).

## Openssl configuration

On modern version of Openssl (>3.0), some older algorythm are no longer supported by default.
When running abledecoder, it will fail with this error:

```
40A7D0B9637F0000:error:0308010C:digital envelope routines:inner_evp_generic_fetch:unsupported:../crypto/evp/evp_fetch.c:349:Global default library context, Algorithm (BF-CBC : 11), Properties ()
error decrypting data
reading file examples/Raylon-190-Full.aif failed
```

To resolve this, enable legacy provider.

Find the Openssl config location by running this command
```
$ openssl version -d
OPENSSLDIR: "/usr/lib/ssl"
$ ls /usr/lib/ssl
certs  misc  openssl.cnf  private
```

Edit the 'openssl.cnf' file and update 2 sections:

```
# List of providers to load
[provider_sect]
default = default_sect 
```

to 

```
# List of providers to load
[provider_sect]
default = default_sect
**legacy = legacy_sect**
```

and this:

```
[default_sect]
# activate = 1
```

to
```
[default_sect]
activate = 1

[legacy_sect]
activate = 1
```

You can verify that the legacy provider is now activate:

```
$  openssl list -providers
Providers:
  default
    name: OpenSSL Default Provider
    version: 3.0.2
    status: active
  legacy
    name: OpenSSL Legacy Provider
    version: 3.0.2
    status: active
```

## Usage

```bash
# Runs the abledecoder
./abledecoder my-aif-file.aif my-aif-file-decoded.aif

# Runs the abledecoder on a hierrachy of folder
./rabledecoder my-aif-folder my-aif-folder-decoded
```

If you want to convert the aif to wav (requires `ffmpeg`), will create `.wav` files along the `.aif` files:

```bash
./aif_to_wav my-aif-folder-decoded
```

You can then listen to the wav, make a selection, and save as m3u playlist, then execute the m3u playlist:

```bash
./m3u_copy my-m3u-playlist.m3u my-destination-folder
```bash

