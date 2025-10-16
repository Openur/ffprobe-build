#!/usr/bin/env bash

set -ex

build_dav1d() {
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  mkdir -p "${BUILD_DIRECTORY}"/dav1d
  fetch -qo- https://download.videolan.org/videolan/dav1d/1.5.1/dav1d-1.5.1.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/dav1d" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/dav1d
  meson setup build . "${DAV1D_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  popd
}
