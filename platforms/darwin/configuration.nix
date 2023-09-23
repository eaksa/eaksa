_: {
  imports = [ ./homebrew ];

  services.nix-daemon.enable = true;
  system.stateVersion = 4;

  system.defaults = {
    LaunchServices = {
      LSQuarantine = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      NSDocumentSaveNewDocumentsToCloud = false;
      "com.apple.mouse.tapBehavior" = 1;
      # _HIHideMenuBar = true;
    };
    dock = {
      autohide = true;
      orientation = "left";
      static-only = true;
    };
    loginwindow = {
      GuestEnabled = false;
    };
    magicmouse = {
      MouseButtonMode = "TwoButton";
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      # See https://developer.apple.com/library/archive/technotes/tn2450/_index.html
      # for documentation on key remapping in MacOS
      {
        # Caps Lock -> Escape
        HIDKeyboardModifierMappingSrc = 30064771129;
        HIDKeyboardModifierMappingDst = 30064771113;
      }
      {
        # Function -> Left GUI (Command)
        HIDKeyboardModifierMappingSrc = 1095216660483;
        HIDKeyboardModifierMappingDst = 30064771299;
      }
      {
        # Left GUI (Command) -> Left Alt (Option)
        HIDKeyboardModifierMappingSrc = 30064771299;
        HIDKeyboardModifierMappingDst = 30064771298;
      }
      {
        # Right GUI (Command) -> Right Alt (Option)
        HIDKeyboardModifierMappingSrc = 30064771303;
        HIDKeyboardModifierMappingDst = 30064771302;
      }
      {
        # Left Alt (Option) -> Function
        HIDKeyboardModifierMappingSrc = 30064771298;
        HIDKeyboardModifierMappingDst = 1095216660483;
      }
      {
        # Right Alt (Option) -> Function
        HIDKeyboardModifierMappingSrc = 30064771302;
        HIDKeyboardModifierMappingDst = 1095216660483;
      }
    ];
  };
}
