# Upstream Nix only compiles main.tsx; syntax highlighting needs highlightWorkerEntry.ts
# bundled the same way as scripts/build/build-bin.ts. Remove this wrapper when modem-dev/hunk
# ships the fix in nix/package.nix.
{hunk, lib}: hunk.overrideAttrs (old: {
  buildPhase = lib.replaceStrings
    [
      ''"./packages/hunk/src/main.tsx" \
  --outfile "hunk-bin"''
    ]
    [
      ''"./packages/hunk/src/main.tsx" \
  "./packages/hunk/src/highlightWorkerEntry.ts" \
  --outfile "hunk-bin"''
    ]
    old.buildPhase;
})
