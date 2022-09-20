{ lib
, stdenv
, fetchgit
, meson
, pkg-config
, cmake
, ninja
, glslang
, vulkan-headers
, vulkan-loader
, vulkan-validation-layers
, vapoursynth
}:
stdenv.mkDerivation rec {
  name = "vapoursynth-vsrife";
  version = "9";
  src = fetchgit {
    url = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan";
    rev = "r${version}";
    fetchSubmodules = true;
    sha256 = "sha256-X1c2Eo5QkDELMHo9tP1ue2iZu5qeLatQessfsqmSl60=";
  };

  patches = [ ./fix_lib_path.patch ];

  VULKAN_SDK = "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";

  nativeBuildInputs = [
    meson
    pkg-config
    cmake
    ninja
    glslang
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vapoursynth
  ];

  enableParallelBuilding = true;

  postUnpack = ''
    ls -l 
  '';

  # postInstall = ''
  #   mkdir -p $out/lib/vapoursynth
  #   cp -r lib/* $out/lib/vapoursynth/
  # '';

  meta = with lib; {
    homepage = "";
    license = licenses.gpl2;
    maintainers = [ "volodiapg" ];
    platforms = platforms.all;
  };
}
