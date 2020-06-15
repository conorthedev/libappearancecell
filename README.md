<img src="https://cdn.discordapp.com/attachments/691570992472129566/721851288333189141/Icon.png" width="100"/> 

# libappearancecell
libappearancecell is a library for jailbroken iOS devices that allows developers to use an iOS 13-style appearance selector in their Preferences. 

## Usage
The setup of libappearancecell is very simple, just follow these 5 simple steps and you should be good to go!
- 1: Copy neccessary files
    - Copy ``libappearancecell.h`` to ``$THEOS/include/libappearancecell`` 
    - Copy ``libappearancecell.dylib`` to ``$THEOS/lib``
- 2: Link libappearancecell in your bundle
    - Add ``appearancecell`` to your LIBRARIES in Preferences Makefile
    - Example:
        ```
        MyBundle_LIBRARIES = appearancecell
        ```
- 3: Make sure your project depends on libappearancecell
    - control:
      ```
      Depends: me.conorthedev.libappearancecell
      ```
- 4: Import libappearancecell
    ```objc
    #import <libappearancecell/libappearancecell.h>
    ```
- 5: Check out the example below for how to use it in your Preferences!

## Documentation
### AppearanceSelectionTableCell
This is the main class for libappearancecell, it handles everything
+ Example of usage in a Preferences Plist:
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
            <string>light</string>
        </dict>
        <dict>
            <key>text</key>
            <string>Dark</string>
            <key>image</key>
            <string>dark</string>
        </dict>
        <dict>
            <key>text</key>
            <string>Default</string>
            <key>image</key>
            <string>default</string>
        </dict>
    </array>
    <key>defaults</key>
    <string>me.conorthedev.libappearancecell.demo</string>
    <key>PostNotification</key>
    <string>me.conorthedev.libappearancecell.demo/reload</string>
    <key>key</key>
    <string>appearance</string>
    <key>height</key>
    <integer>160</integer>
</dict>
```

**Actual Documentation is coming soon!**

## Preference Bundle Example
If you're a bit stuck on the integration, there's an example of a working Preference Bundle [here](https://github.com/cbyrne/libappearancecell/tree/master/Example).
