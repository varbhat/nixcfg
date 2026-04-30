{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      OfferToSaveLoginsDefault = false;
      Preferences = {
        "browser.link.open_newwindow.override.external" = {
          "Value" = 1;
          "Status" = "locked";
        };
        "browser.compactmode.show" = {
          "Value" = true;
          "Status" = "locked";
        };
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "@testpilot-containers" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "keepassxc-browser@keepassxc.org" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
  };
}
