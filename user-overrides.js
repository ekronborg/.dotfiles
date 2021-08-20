/*** MY OVERRIDES ***/
user_pref("_user.js.parrot", "overrides section syntax error");

user_pref("privacy.resistFingerprinting.letterboxing", false); // Remove white borders
user_pref("app.update.auto", true); // Automatic updates
user_pref("keyword.enabled", true); // Enable searching in the location bar
// user_pref("browser.safebrowsing.downloads.remote.enabled", true); // [SECURITY]
// user_pref("browser.safebrowsing.downloads.remote.url", "https://sb-ssl.google.com/safebrowsing/clientreport/download?key=%GOOGLE_SAFEBROWSING_API_KEY%"); // [SECURITY]
user_pref("browser.cache.disk.enable", true); // Performance
user_pref("javascript.options.asmjs", true); // Performance
// user_pref("javascript.options.wasm", true); // Performance
// user_pref("network.prefetch-next", true); // Performance
// user_pref("network.dns.disablePrefetch", false); // Performance
// user_pref("network.dns.disablePrefetchFromHTTPS", true); // [DEFAULT: true] Performance
// user_pref("network.predictor.enabled", true); // Performance
// user_pref("network.predictor.enable-prefetch", false); // Performance
// user_pref("network.http.speculative-parallel-limit", 6); // Performance

user_pref("_user.js.parrot", "overrides section successful");
