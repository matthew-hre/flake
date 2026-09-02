{inputs, ...}: let
  user = {
    name = "Matthew Hrehirchuk";
    email = "me@matthew-hre.com";
  };
in {
  programs.jujutsu = {
    enable = true;
    package = inputs.jj.packages.x86_64-linux.jujutsu;

    settings = {
      inherit user;

      aliases = {
        init = ["git" "init" "--colocate"];
        tug = ["bookmark" "advance"];
        jj = ["util" "exec" "--" "jj"];
        set-trunk = ["config" "set" "--repo" "'revset-aliases.\"trunk()\"'"];
      };

      templates.git_push_bookmark = "\"matthew-hre/jj-\" ++ change_id.short()";
      revsets.bookmark-advance-to = "@-";

      fix.tools = {
        oxfmt = {
          command = ["$root/node_modules/oxfmt/bin/oxfmt" "--stdin-filepath=$path"];
          patterns = [
            ''
              (
                glob:'**/*.{js,jsx,mjs,cjs,ts,tsx,mts,cts}'
                | glob:'**/*.{json,jsonc,json5}'
                | glob:'**/*.{css,scss,less,pcss,postcss}'
                | glob:'**/*.toml'
                | glob:'**/*.{html,htm,xhtml}'
                | glob:'**/*.{md,markdown,mdx}'
                | glob:'**/*.{yml,yaml}'
              )
              ~ glob:'**/pnpm-lock.yaml'
              ~ glob:'**/package-lock.json'
              ~ glob:'**/yarn.lock'
            ''
          ];
        };

        oxlint = {
          # Temp files cannot live in .jj/: oxlint treats it as a VCS dir and
          # reports "No files found to lint". Remaining diagnostics also exit 1;
          # jj fix only keeps stdout when the wrapper exits 0.
          command = [
            "sh"
            "-c"
            ''set -e; root="$1"; path="$2"; oxlint="$3"; tmpdir=$(mktemp -d); trap 'rm -rf "$tmpdir"' EXIT; out="$tmpdir/$path"; mkdir -p "$(dirname "$out")"; cat > "$out"; "$oxlint" --fix "$out" >/dev/null || true; cat "$out"''
            "_"
            "$root"
            "$path"
            "$root/node_modules/oxlint/bin/oxlint"
          ];
          patterns = ["glob:'**/*.ts'" "glob:'**/*.tsx'"];
        };

        "sync-claude-rules" = {
          command = [
            "sh"
            "-c"
            ''set -e; root="$1"; path="$2"; t="$root/$path"; mkdir -p "$(dirname "$t")"; cat > "$t"; if [ -f "$root/scripts/sync-claude-rules.cjs" ]; then script="$root/scripts/sync-claude-rules.cjs"; elif [ -f "$root/scripts/sync-claude-rules.js" ]; then script="$root/scripts/sync-claude-rules.js"; else echo "sync-claude-rules: missing scripts/sync-claude-rules.{cjs,js}" >&2; exit 1; fi; node "$script" "$path"; "$3" "$root/.claude/rules" >/dev/null; cat "$t"''
            "_"
            "$root"
            "$path"
            "$root/node_modules/oxfmt/bin/oxfmt"
          ];
          patterns = ["glob:'.cursor/rules/*.mdc'"];
        };
      };

      ui = {
        editor = "hx";
        "default-command" = "log";
      };
    };
  };
}
