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
[You can find details on setting up and using libappearancecell on the wiki](https://github.com/cbyrne/libappearancecell/wiki)

## Preference Bundle Example
If you're a bit stuck on the integration, there's an example of a working Preference Bundle [here](https://github.com/cbyrne/libappearancecell/tree/master/Example).
