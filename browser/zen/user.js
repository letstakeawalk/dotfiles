// Zen Browser — user preferences backup
// Copy to profile dir to restore. Zen reads user.js on startup.

// --- Privacy & Security ---
user_pref("browser.contentblocking.category", "strict");
user_pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.lna.blocking", true);
user_pref("network.prefetch-next", false);
user_pref("privacy.annotate_channels.strict_list.enabled", true);
user_pref("privacy.bounceTrackingProtection.mode", 1);
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.fingerprintingProtection", true);
user_pref("privacy.globalprivacycontrol.was_ever_enabled", true);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.query_stripping.enabled.pbmode", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("signon.rememberSignons", false);

// --- UI & Behavior ---
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("general.smoothScroll", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// --- Zen-specific ---
user_pref("zen.urlbar.behavior", "normal");
user_pref("zen.view.compact.enable-at-startup", false);
user_pref("zen.view.compact.hide-toolbar", true);
user_pref("zen.view.show-newtab-button-top", false);
user_pref("zen.view.use-single-toolbar", false);

// --- Extensions ---
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("privacy.userContext.extension", "@testpilot-containers");

// --- Devtools ---
user_pref("devtools.toolbox.zoomValue", "1.3");
