{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    historyWidget.options = [
      "--no-preview"
      "--with-nth=3.."
    ];
  };
}
