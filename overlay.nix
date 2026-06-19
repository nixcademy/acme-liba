final: prev: {
  acme = prev.acme.overrideScope (
    acmeFinal: acmePrev: {
      liba = acmeFinal.callPackage ./a { };
    }
  );
}
