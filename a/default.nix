{
  stdenv,
  lib,
  cmake,
  libc,
  libd,
}:

stdenv.mkDerivation {
  name = "liba";

  nativeBuildInputs = [ cmake ];

  # With CMake's default (static) linking, a static archive can't encapsulate
  # its dependencies, so every transitive dep must be available at the final
  # link of consumers like myapp. Hence both propagate:
  #   libd - public (a.hpp exposes d.hpp)
  #   libc - private impl dep, but static linking can't hide it
  propagatedBuildInputs = [ libc libd ];

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./CMakeLists.txt
      ./main.cpp
      ./include
    ];
  };
}
