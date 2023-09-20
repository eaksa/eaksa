{ pkgs, ... }: let
  firefoxConfigPath = if pkgs.stdenv.isDarwin then
    "Library/Application Support/Firefox"
  else
    ".mozilla/firefox";

  profilesPath = if pkgs.stdenv.isDarwin then
    "${firefoxConfigPath}/Profiles"
  else
      firefoxConfigPath;

  firefoxPackage = if pkgs.stdenv.isLinux then
    # pkgs.firefox-wayland
    pkgs.wrapFirefox
    pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = true;
        OfferToSaveLoginsDefault = true;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    }
  else
    pkgs.firefox-bin;

  defaultProfile = {
    # Hardened Firefox configuration
    # See https://brainfucksec.github.io/firefox-hardening-guide
    settings = {
      # == STARTUP SETTINGS ==
      # Disable about:config warning
      "browser.aboutConfig.showWarning" = false;
      # Set startup home page:
      #   0 = blank
      #   1 = home
      #   2 = last visited page
      #   3 = resume previous session
      "browser.startup.page" = 0;
      "browser.startup.homepage" = "about:blank";
      # Disable Activity Stream on new windows and tab pages
      "browser.newtab.preload" = false;
      "browser.newtabpage.enabled" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;

      # == GEOLOCATION ==
      # Use Mozilla geolocation service instead of Google if permission is granted
      "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
      # Disable using the OS's geolocation service
      "geo.provider.use_corelocation" = false;
      "geo.provider.use_geoclue" = false;
      "geo.provider.use_gpsd" = false;
      # Disable region updates
      "browser.region.network.url" = "";
      "browser.region.update.enabled" = false;

      # == LOCALE ==
      # Set language for displaying web pages
      "intl.accept_languages" = "en-GB, en";
      "javascript.use_us_english_locale" = true;

      # == AUTO-UPDATES / RECOMMENDATIONS ==
      # Disable auto-installing Firefox updates
      "app.update.auto" = false;
      # Disable addons recommendations (uses Google Analytics)
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.discovery.enabled" = false;

      # == TELEMETRY ==
      # Disable telemetry
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.coverage.opt-out" = true;
      "toolkit.coverage.endpoint.base" = "";
      "browser.ping-centre.telemetry" = false;
      "beacon.enabled" = false;

      # == STUDIES ==
      # Disable studies
      "app.shield.optoutstudies.enabled" = false;
      # Disable Normandy/Shield
      "app.normandy.enabled" = false;
      "app.normandy.api_url" = "";

      # == CRASH REPORTS ==
      # Disable crash reports
      "breakpad.reportURL" = "";
      "browser.tabs.crashReporting.sendReport" = false;

      # == CAPTIVE PORTAL DETECTION / NETWORK CHECKS ==
      # Disable captive portal detection
      "captivedetect.canonicalURL" = "";
      "network.captive-portal-service.enabled" = false;
      # Disable network connections checks
      "network.connectivity-service.enabled" = false;

      # == SAFE BROWSING ==
      # Disable safe browsing service
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      # Disable list of blocked URI
      "browser.safebrowsing.blockedURIs.enabled" = false;
      "browser.safebrowsing.provider.google.getHashURL" = "";
      "browser.safebrowsing.provider.google.updateURL" = "";
      "browser.safebrowsing.provider.google4.getHashURL" = "";
      "browser.safebrowsing.provider.google4.updateURL" = "";
      "browser.safebrowsing.provider.google4.dataSharingURL" = "";
      # Disable checks for downloads
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.allowOverride" = false;

      # == NETWORK: DNS, PROXY, IPv6 ==
      # Disable link prefetching
      "network.prefetch-next" = false;
      # Disable DNS prefetching
      "network.dns.disablePrefetch" = true;
      # Disable predictor
      "network.predictor.enabled" = false;
      # Disable link-mouseover opening connection to linked server
      "network.http.speculative-parallel-limit" = 0;
      # Disable mousedown speculative connections on bookmarks and history
      "browser.places.speculativeConnect.enabled" = false;
      # Disable IPv6
      "network.dns.disableIPv6" = true;
      # Disable GIO protocols as potential proxy bypass vectors
      "network.gio.supported-protocols" = "";
      # Disable using UNC (Uniform Naming Convention) paths (prevent proxy bypass)
      "network.file.disable_unc_paths" = true;
      # Remove special permissions for certain Mozilla domains
      "permissions.manager.defaultsUrl" = "";
      # Use Punycode in Internationalized Domain Names to eliminate possible
      # spoofing
      "network.IDN_show_punycode" = true;

      # == SEARCH BAR: SUGGESTIONS, AUTOFILL ==
      # Disable search suggestions
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      # Disable location bar domain guessing
      "browser.fixup.alternate.enabled" = false;
      # Disable location bar making speculative connections
      "browser.urlbar.speculativeConnect.enabled" = false;
      # Disable form autofill
      "browser.formfill.enable" = false;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.available" = "off";
      "extensions.formautofill.creditCards.available" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "extensions.formautofill.heuristics.enabled" = false;
      # Disable location bar contextual suggestions
      "browser.urlbar.quicksuggest.scenario" = "history";
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;

      # == PASSWORDS ==
      # Disable saving passwords
      "signon.rememberSignons" = false;
      # Disable autofill login and passwords
      "signon.autofillForms" = false;
      # Disable formless login capture for Password Manager
      "signon.formlessCapture.enabled" = false;
      # Hardens against potential credentials phishing
      #   0 = don't allow sub-resources to open HTTP authentication credentials
      #       dialogues
      #   1 = don't allow cross-origin sub-resources to open HTTP authentication
      #       credentials dialogues
      #   2 = allow sub-resources to open HTTP authentication credentials
      #       dialogues (default)
      "network.auth.subresource-http-auth-allow" = 1;

      # == DISK CACHE / MEMORY ==
      # Disable disk cache
      "browser.cache.disk.enable" = false;
      # Disable storing extra session data
      #   0 = everywhere
      #   1 = unencrypted sites
      #   2 = nowhere
      "browser.sessionstore.privacy_level" = 2;
      # Disable resuming session from crash
      "browser.sessionstore.resume_from_crash" = false;
      # Disable page thumbnail collection
      "browser.pagethumbnails.capturing_disabled" = true;
      # Disable favicons in profile folder
      "browser.shell.shortcutFavicons" = false;
      # Delete temporary files opened with external apps
      "browser.helperApps.deleteTempFileOnExit" = true;

      # == HTTPS / SSL/TLS / OSCP / CERTS ==
      # Enable HTTPS-only mode in all windows
      "dom.security.https_only_mode" = true;
      # Disable sending HTTP request for checking HTTPS support by the server
      "dom.security.https_only_mode_send_http_background_request" = false;
      # Display advanced information on insecure connection warning pages
      "browser.xul.error_pages.expert_bad_cert" = true;
      # Disable TLS1.3 0-RTT (round-trip time)
      "security.tls.enable_0rtt_data" = false;
      # Set OSCP to terminate the connection when a CA isn't validated
      "security.OSCP.require" = true;
      # Disable SHA-1 certificates
      "security.pki.sha1_enforcement_level" = 1;
      # Enable strict pinning (PKP (Public Key Pinning)):
      #   0 = disabled
      #   1 = allow user MiTM (i.e. your antivirus)
      #   2 = strict
      "security.cert_pinning.enforcement_level" = 2;
      # Enable CRLite:
      #   0 = disabled
      #   1 = consult CRLite but only collect telemetry (default)
      #   2 = consult CRLite and enforce both "Revoked" and "Not Revoked" results
      #   3 = consult CRLite and enforce "Not Revoked" results, but defer to OSCP
      #       for "Revoked"
      "security.remote_settings.crlite_filters.enabled" = true;
      "security.pki.crlite_mode" = 2;

      # == HEADERS / REFERERS ==
      # Control when to send a referer:
      #   0 = always (default)
      #   1 = only if base domains match
      #   2 = only if hosts match
      "network.http.referer.XOriginPolicy" = 2;
      # Control the amount of information to send:
      #   0 = send full URI (default):
      #       https://example.com:8888/foo/bar.html?id=1234
      #   1 = scheme+host+port+path:
      #       https://example.com:8888/foo/bar.html
      #   2 = scheme+host+port:
      #       https://example.com:8888
      "network.http.referer.XOrigin.TrimmingPolicy" = 2;

      # == AUDIO/VIDEO: WEBRTC, WEBGL, DRM ==
      # Disable WebRTC
      "media.peerconnection.enabled" = false;
      # Force WebRTC inside the proxy
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      # Force a single network interface for ICE candidates generation
      "media.peerconnection.ice.default_address_only" = true;
      # Force exclusion of private IPs from ICE candidates
      "media.peerconnection.ice.no_host" = true;
      # Disable WebGL
      "webgl.disabled" = true;
      # Disable autoplay of HTML5 media:
      #   0 = allow all
      #   1 = block non-muted media (default)
      #   5 = block all
      "media.autoplay.default" = 5;
      # Disable DRM content
      "media.eme.enabled" = false;

      # == DOWNLOADS ==
      # Disable adding downloads to system's "recent documents" list
      "browser.download.manager.addToRecentDocs" = false;

      # == COOKIES ==
      # Enable ETP (Enchanced Tracking Protection), ETP strict mode enables Total
      # Cookie Protection (TCP)
      "browser.contentblocking.category" = "strict";
      # Enable state partitioning of service workers
      "privacy.partition.serviceWorkers" = true;
      # Enable APS (Always Partitioning Storage)
      "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
      "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;

      # == UI FEATURES ==
      # Block popup windows
      "dom.disable_open_during_load" = true;
      # Limit events that can cause a popup
      "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
      # Disable Pocket extension
      "extensions.pocket.enabled" = false;
      # Disable Screenshots extension
      "extensions.Screenshots.disabled" = true;
      # Disable PDF.js scripting
      "pdfjs.enableScripting" = false;
      # Enable Containers and show the UI settings
      "privacy.userContext.enabled" = true;

      # == EXTENSIONS ==
      # Set extensions to work on restricted domains, and their scopeis to
      # "profile+applications"
      "extensions.enabledScopes" = 5;
      "extensions.webextensions.restrictedDomains" = "";
      # Display always the installation prompt
      "extensions.postDownloadThirdPartyPrompt" = false;

      # == SHUTDOWN SETTINGS ==
      # Clear history, cookies, and site data when Firefox closes
      "network.cookie.lifetimePolicy" = 2;
      "privacy.sanitize.sanitizeOnShutdown" = true;
      "privacy.sanitize.timeSpan" = 0;
      "privacy.clearOnShutdown.cache" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.formdata" = true;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.offlineApps" = true;
      "privacy.clearOnShutdown.sessions" = true;
      "privacy.clearOnShutdown.sitesettings" = true;

      # # == FINGERPRINTING (RFP) ==
      # # Enable RFP
      # "privacy.resistFingerprinting" = true;
      # # Set new window size rounding max values
      # "privacy.window.maxInnerWidth" = 1600;
      # "privacy.window.maxInnerHeight" = 900;
      # # Disable mozAddonManager Web API
      # "privacy.resistFingerprinting.block_mozAddonManager" = true;

      # == UI ==
      # Compatibility with legacy userChrome.css (necessary for legacy themes)
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    # search.default = "DuckDuckGo";
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      vimium
    ];
    # userChrome = builtins.readFile ./userChrome.css;
  };

in {
  home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;
  programs.firefox = {
    package = firefoxPackage;
    enable = true;
    profiles.default = {
      inherit (defaultProfile) settings extensions;
    };
  };
  # home.file."${profilesPath}/default/chrome/window" = {
  #   source = ./window;
  #   recursive = true;
  # };
}
