# kandy-cpaas2-sample-reactnative-ios
Sample app of CPaaS2 modules (Login, SMS)

## Introduction
It is a sample app where CPaaS2 APIs are used to make the following modules

- [x] Login
- [x] SMS

## Installation
Instructions to install the .ipa on iPhone using Xcode

1. Connect your device to your PC.
2. Open Xcode, go to Window → Devices .
3. Then, the Devices screen will appear. Choose the device you want to install the app on.
4. Drag and drop your .ipa file into the Installed Apps section.

## Usage
Instructions to use this app

1. Open this iOS application on iPhone
2. Enter the user details created at [AT&T API Marketplace](https://apimarket.att.com/)
3. Proceed further as required

### Pre-requistie
If you don't have [CocoaPods](https://cocoapods.org/) installed on your system already, then install it.
If you don't have [Node](https://nodejs.org/en/download/) installed on your system already, then install it.


For troubleshooting, please refer this link [How to install cocoapods?](https://stackoverflow.com/questions/20755044/how-to-install-cocoapods).

### Setup repository
To setup the project repository, run these commands

```
git clone  https://github.com/hclsampleapps/kandy-cpaas2-sample-reactnative-ios.git
cd kandy-cpaas2-sample-reactnative-ios then move cd folder kandy_sample_reactnative_ios
```

### Build application
Instructions to build the app

1. Open the project folder(kandy_sample_reactnative_ios) in terminal.
2. Run 'npm install' it will add all the node packages required.
3. Then move to ios folder.
4. Run 'pod install' it will add all the pods required.
4. Open RibbonSample.xcworkspace from Xcode or run react-native run-ios from terminal in root folder.
5. Build and deploy the app.

