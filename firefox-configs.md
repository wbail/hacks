## Firefox

1. download and install firefox

## Configs

### Tabs

1. type about:config into the address bar and then toolkit.legacyUserProfileCustomizations.stylesheets into the search on that page. Turn the setting from false to true.
2. find your user profile folder by typing about:support in the address bar.
3. edit/create chrome/userChrome.css in your profile and add these lines...

```css 
.tabbrowser-tab {
    min-width: initial !important;
}
.tab-content {
    overflow: hidden !important;
}
```

4. restart firefox

### startup previous sessions

browser.startup.page = 3

### confirm before closing

services.sync.prefs.sync.browser.tabs.warnOnClose = true

### do not track

privacy.donottrackheader.enabled = true

### tell websites not sell

privacy.globalprivacycontrol.was_ever_enabled = true

services.sync.prefs.sync-seen.privacy.globalprivacycontrol.enabled = true

### disable WebRTC [implement STUN (Session Traversal Utilities for Nat), a protocol that allows to discover the public IP address]:  

media.peerconnection.enabled = false

### video / windows terminal

widget.windows.window_occlusion_tracking.enabled = false

### ui density

browser.uidensity = 1

### acrylic
widget.windows.mica = true

### open tab right side

browser.tabs.insertRelatedAfterCurrent = false

### enable update logs

app.update.log = true

### Update url

https://aus5.mozilla.org/update/6/Firefox/[VERSION]/20240416043247/WINNT_x86_64-msvc-x64/en-US/release/Windows_NT%252010.0.0.0.22631.3447%2520(x64)/ISET:SSE4_2,MEM:32702/default/default/update.xml?force=1

