# Telegram iOS Source Code Compilation Guide

1. Install the brew package manager, if you haven’t already.
2. Install the packages yasm, cmake:
```
brew install yasm cmake
```
3. Clone the project from GitHub:

```
git clone --recursive https://github.com/TelegramMessenger/Telegram-iOS.git
```
4. Open Telegram-iOS.workspace.
5. Open the Telegram-iOS-Fork scheme.
6. Start the compilation process.
7. To run the app on your device, you will need to set the correct values for the signature, .entitlements files and package IDs in accordance with your developer account values.


```
1.Need to install buck, and buck project can run normally.

2.Execute make project
```
![Preview](https://upload-images.jianshu.io/upload_images/1979970-d859f539301f9038.gif?imageMogr2/auto-orient/strip)
