# kandy-cpaas2-sample-reactnative-ios
ReactNative based communication app is used to create communication channel between two users via Voice/Video APIs

## Introduction
Sample app made using CPaaS2 APIs to make these modules

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

```shell
git clone https://github.com/hclsampleapps/kandy-cpaas2-sample-reactnative-ios.git
cd kandy-cpaas2-sample-reactnative-ios 
cd kandy_sample_reactnative_ios
```

### Build application
Instructions to build the app

1. Open the project folder `kandy_sample_reactnative_ios` in terminal.
2. Run `npm install` that will add all the node packages required.
3. Then move to `ios` folder.
4. Run `pod install` that will add all the pods required.
5. Open `RibbonSample.xcworkspace` from Xcode or run `react-native run-ios` from terminal in root folder.
6. Build and deploy the app.


