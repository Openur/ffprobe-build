#!/usr/bin/env bash

export MAKEFLAGS=-j6

export FFMPEG_CONFIGURE_ARGS=(
  --extra-version=Openur

  --prefix=/opt/ffmpeg

  --enable-version3

  --disable-programs
  --disable-everything
  --disable-autodetect
  --disable-iconv
  --disable-network
  --disable-avdevice
  --disable-avfilter
  --disable-swresample
  --disable-swscale
  --disable-doc
  --disable-debug

  --enable-ffprobe
  --enable-protocol=file
  --enable-demuxers
  --enable-parsers
  --enable-decoders
  --enable-bsf=av1_frame_split
  --enable-bsf=av1_frame_merge
  --enable-bsf=av1_metadata

  --enable-static
  --disable-shared

  # AV1
  --enable-libdav1d
)

export DAV1D_MESON_ARGS=(
  --buildtype release
  --default-library=static
  -Denable_tools=false
  -Denable_examples=false
  -Denable_tests=false
  -Denable_docs=false
  -Dxxhash_muxer=disabled
)
