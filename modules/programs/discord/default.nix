{ platform, ... }: {
  imports = if platform.isDarwin
    then [ ./darwin.nix ]
    else [ ./linux.nix ];
}
