{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "lock-time";

  dontUnpack = true;

  buildPhase = ''
    cat > lock-time.c << 'EOF'
    #include <stdio.h>
    #include <time.h>
    #include <sys/time.h>

    int main() {
        struct timeval tv;
        struct tm *tm_info;

        gettimeofday(&tv, NULL);
        tm_info = localtime(&tv.tv_sec);

        int centiseconds = tv.tv_usec / 10000;

        printf("<span>%02d:%02d:%02d:%02d:%02d:%02d:%02d</span>\n",
               tm_info->tm_year % 100,
               tm_info->tm_mon + 1,
               tm_info->tm_mday,
               tm_info->tm_hour,
               tm_info->tm_min,
               tm_info->tm_sec,
               centiseconds);

        return 0;
    }
    EOF
    $CC -o lock-time lock-time.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp lock-time $out/bin/
  '';
}
