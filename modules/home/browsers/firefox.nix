let
  arkenfox = {
    # Enable ETP for decent security (makes firefox containers and many
    # common security/privacy add-ons redundant).
    "browser.contentblocking.category" = "strict";
    "privacy.donottrackheader.enabled" = true;
    "privacy.purge_trackers.enabled" = true;

    # Don't use the built-in password manager. A nixos user is more likely
    # using an external one (you are using one, right?).
    "signon.rememberSignons" = false;

    # Do not check if Firefox is the default browser
    "browser.shell.checkDefaultBrowser" = false;

    "browser.newtab.url" = "about:blank";
    "browser.newtab.preload" = false;
    "browser.newtabpage.enabled" = false;
    "browser.newtabpage.activity-stream.enabled" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.enhanced" = false;
    "browser.newtabpage.introShown" = true;
    "browser.newtabpage.directory.ping" = "";
    "browser.newtabpage.directory.source" = "data:text/plain,{}";

    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.shortcuts.bookmarks" = true;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;
    "browser.urlbar.showSearchSuggestionsFirst" = false;
    "browser.urlbar.speculativeConnect.enabled" = false;
    "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.trimURLs" = false;

    # Disable some not so useful functionality.
    "browser.disableResetPrompt" = true;
    "browser.onboarding.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
    "extensions.pocket.enabled" = false;
    "extensions.shield-recipe-client.enabled" = false;
    "reader.parse-on-load.enabled" = false; # "reader view"

    "security.family_safety.mode" = 0;
    "security.pki.sha1_enforcement_level" = 1;
    "security.tls.enable_0rtt_data" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
      false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "extensions.htmlaboutaddons.discover.enabled" = false;
    "extensions.getAddons.showPane" = false; # uses Google Analytics
    "browser.discovery.enabled" = false;

    "dom.battery.enabled" = false;
    "beacon.enabled" = false;
    "browser.send_pings" = false;
    # Disable gamepad API to prevent USB device enumeration
    "dom.gamepad.enabled" = false;
    # Don't try to guess domain names when entering an invalid domain name in URL bar
    "browser.fixup.alternate.enabled" = false;
    # Disable telemetry
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.server" = "data:,";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.coverage.opt-out" = true;
    "toolkit.coverage.opt-out" = true;
    "toolkit.coverage.endpoint.base" = "";
    "experiments.supported" = false;
    "experiments.enabled" = false;
    "experiments.manifest.uri" = "";
    "browser.ping-centre.telemetry" = false;
    # https://mozilla.github.io/normandy/
    "app.normandy.enabled" = false;
    "app.normandy.api_url" = "";
    "app.shield.optoutstudies.enabled" = false;
    # Disable health reports (basically more telemetry)
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.healthreport.service.enabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;

    # Disable crash reports
    "breakpad.reportURL" = "";
    "browser.tabs.crashReporting.sendReport" = false;
    "browser.crashReports.unsubmittedCheck.autoSubmit2" =
      false; # don't submit backlogged reports

    # Disable Form autofill
    # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.creditCards.available" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;

    # Security
    "webgl.disabled" = false;
    "privacy.resistFingerprinting" = false;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.cookies" = false;
    "network.cookie.lifetimePolicy" = 0;
  };
  custom = {
    # UI
    "browser.translations.automaticallyPopup" = false;
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "browser.tabs.firefox-view" = false;
    "browser.tabs.firefox-view-newIcon" = false;
    "browser.tabs.firefox-view-next" = false;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.startup.page" = 3; # restore previous session

    # Reduce File IO / SSD abuse
    # Otherwise, Firefox bombards the HD with writes. Not so nice for SSDs.
    # This forces it to write every 30 minutes, rather than 15 seconds.
    "browser.sessionstore.interval" = 1800000;

    # Search
    "accessibility.typeaheadfind.casesensitive" = 1; # match case
    "findbar.highlightAll" = true;
  };
in {
  programs.firefox = {
    enable = true;
    profiles = {
      alx = {
        id = 0;
        isDefault = true;
        name = "alx";
        settings = arkenfox // custom;
      };
      alx360 = {
        id = 1;
        name = "alx-360";
        settings = arkenfox // custom;
      };
    };
  };
}
