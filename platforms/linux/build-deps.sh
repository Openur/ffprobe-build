#!/usr/bin/env bash

set -ex

build_dav1d() {
  case "$ARCHITECTURE" in
    arm)
      DAV1D_MESON_ARGS+=(
        --cross-file="$SCRIPT_DIRECTORY/arm-linux-gnueabihf.meson"
        --prefix=/usr/lib/arm-linux-gnueabihf
        --libdir=/usr/lib/arm-linux-gnueabihf/lib
      )
      ;;
    arm64)
      DAV1D_MESON_ARGS+=(
        --cross-file=./package/crossfiles/aarch64-linux.meson
        --prefix=/usr/lib/aarch64-linux-gnu
        --libdir=/usr/lib/aarch64-linux-gnu/lib
      )
      ;;
    x64) ;;
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
