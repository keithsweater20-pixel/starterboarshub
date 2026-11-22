# StarterBoard Hub

A small SwiftUI iOS hub for public system destinations and information about protected iOS components.

## What it does
- Provides a dark dashboard for system destinations.
- Offers a best-effort link to iOS Settings.
- Explains the roles and limitations of SpringBoard, PreBoard, and BackBoard.

## Important iOS limitation
SpringBoard, PreBoard, and BackBoard are protected Apple system components. An ordinary third-party app signed with a normal certificate (including signing through KSign) cannot obtain Apple's private entitlements or launch/control these processes. This project does not claim to bypass those protections.

## Build locally
Requires macOS, Xcode, and XcodeGen:

```sh
brew install xcodegen
xcodegen generate
xcodebuild -project StarterBoardHub.xcodeproj -scheme StarterBoardHub -sdk iphoneos -configuration Release -derivedDataPath build CODE_SIGNING_ALLOWED=NO
```

## GitHub Actions
The workflow builds an unsigned app and packages it as `StarterBoardHub-unsigned.ipa`. Download it from the Actions run artifacts, then sign it with KSign using a certificate and provisioning profile valid for your device. An unsigned IPA is not directly installable.

Deployment target: iOS 17.0 or later.
