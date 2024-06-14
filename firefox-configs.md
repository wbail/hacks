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

### video / windows terminal

widget.windows.window_occlusion_tracking.enabled = false
