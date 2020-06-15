<img src="https://cdn.discordapp.com/attachments/691570992472129566/721851288333189141/Icon.png" width="100"/> 

# libappearancecell
libappearancecell is a library for jailbroken iOS devices that allows developers to use an iOS 13-style appearance selector in their Preferences. 

## Usage
The setup of libappearancecell is very simple, just follow these 5 simple steps and you should be good to go!
- 1: Clone or [download](https://github.com/cbyrne/libappearancecell/archive/master.zip) this repository
    - ``git clone https://github.com/cbyrne/libappearancecell.git``
- 2: ``cd libapperancecell && make do``
    - This will setup libappearancecell inside theos and will install it to your device.
    - **Make sure you have the THEOS_DEVICE_IP variable set**
- 3: Add ``$(BUNDLE_NAME)_LIBRARIES = appearancecell`` to your Preferences Makefile
- 4: Import AppearanceSelectionTableCell.h
    - ```objc
        #import <libappearancecell/libappearancecell.h>
      ```
- 5: Check out the example below for how to use it in your Preferences!

## Documentation
### AppearanceSelectionTableCell
This is the main class for libappearancecell, it handles everything.
+ Example of usage in a Preferences Specifier:
```xml
<dict>
    <key>cell</key>
    <string>PSDefaultCell</string>
    <key>cellClass</key>
    <string>AppearanceSelectionTableCell</string>
    <key>options</key>
    <array>
        <dict>
            <key>text</key>
            <string>Light</string>
            <key>image</key>
            <string>light.png</string>
        </dict>
        <dict>
            <key>text</key>
            <string>Dark</string>
            <key>image</key>
            <string>dark.png</string>
        </dict>
        <dict>
            <key>text</key>
            <string>Default</string>
            <key>image</key>
            <string>default.png</string>
        </dict>
    </array>
    <key>defaults</key>
    <string>me.conorthedev.libappearancecell.demo</string>
    <key>PostNotification</key>
    <string>me.conorthedev.libappearancecell.demo/reload</string>
    <key>key</key>
    <string>appearance</string>
</dict>
```
#### All keys listed above are *required*, failing to supply these will make it not work.

## Preference Bundle Example
If you're a bit stuck on the integration, there's an example of a working Preference Bundle [here](https://github.com/cbyrne/libappearancecell/tree/master/PreferencesExample).
