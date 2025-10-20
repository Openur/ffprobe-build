#!/usr/bin/env bash

set -ex

build_dav1d() {
  case "$ARCHITECTURE" in
    x64)
      DAV1D_MESON_ARGS+=(
        --cross-file=./package/crossfiles/x86_64-w64-mingw32.meson
        --prefix=/usr/lib/x86_64-w64-mingw32
        --libdir=/usr/lib/x86_64-w64-mingw32/lib
      )
      ;;
    x86)
      DAV1D_MESON_ARGS+=(
        --cross-file=./package/crossfiles/i686-w64-mingw32.meson
        --prefix=/usr/lib/i686-w64-mingw32
        --libdir=/usr/lib/i686-w64-mingw32/lib
      )
      ;;
    *)
      echo "Unsupported architecture $ARCHITECTURE"
      exit 1
      ;;
  esac

  rm -rf "${BUILD_DIRECTORY}"/dav1d
  mkdir -p "${BUILD_DIRECTORY}"/dav1d
  wget -qO- https://download.videolan.org/videolan/dav1d/1.5.1/dav1d-1.5.1.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/dav1d" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/dav1d
  meson setup build . "${DAV1D_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  popd
}
