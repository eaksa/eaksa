{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cargo
    lldb
    rust-analyzer
    rustc
    rustfmt
  ];
}
