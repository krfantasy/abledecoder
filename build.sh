#!/bin/sh
set -ex
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
g++ -Wall -g -std=c++11 -I/usr/local/opt/openssl/include -I/Users/chainz/Documents/Projects/abledecoder -c FileChunk.cpp CommonChunk.cpp AbleChunk.cpp FormChunk.cpp SoundDataChunk.cpp FormatVersionChunk.cpp main.cpp
g++ -Wall -g -std=c++11 -I/usr/local/opt/openssl/include -I/Users/chainz/Documents/Projects/abledecoder -L/usr/local/opt/openssl/lib -lssl -lcrypto -o abledecoder FileChunk.o CommonChunk.o AbleChunk.o FormChunk.o SoundDataChunk.o FormatVersionChunk.o main.o
