{ pkgs, lib, ... }:
{
  home-manager.users.danielmarbach = {
    programs.firefox = {
      enable = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            languagetool
          ];
      profiles = {
        default = {
          isDefault = true;
          settings = {
            # Do not save passwords to Firefox...
            "security.ask_for_password" = 0;

            # We handle this elsewhere
            "browser.shell.checkDefaultBrowser" = false;

            # Disable site reading installed plugins.
            "plugins.enumerable_names" = "";

            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.urlbar.placeholderName" = "DuckDuckGo";
            "browser.search.defaultenginename" = "DuckDuckGo";

            # Perf
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
            "gfx.webrender.compositor.force-enabled" = true;
            "media.navigator.mediadatadecoder_vpx_enabled" = true;
            "webgl.force-enabled" = true;
            "layers.acceleration.force-enabled" = true;
            "layers.offmainthreadcomposition.enabled" = true;
            "layers.offmainthreadcomposition.async-animations" = true;
            "layers.async-video.enabled" = true;
            "html5.offmainthread" = true;
          };
        };
      };
    };
  };
}
