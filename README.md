# React Native Video360

React Native Video360 is a react-native library that allows rendering of 360 degree videos on iOS and Android.  It relies on [Google VR](https://github.com/googlevr/gvr-android-sdk) to render on Android and [SG Player](https://github.com/libobjc/SGPlayer) to render on iOS.  SG Player was specifically chosen on iOS because, unlike Google VR, it does not rely on UIWebViews (which have been deprecated).

## Installation

`$ yarn add @uscsf/react-native-video360` or `$ npm install @uscsf/react-native-video360`

### Linking

This package supports [autolinking](https://reactnative.dev/docs/linking-libraries-ios#automatic-linking).  Consequently, a simple `yarn install` followed by `cd pods && pod install` should automatically link the package.  If you are using a version of react-native that does not support autolinking, then follow the [manual linking instructions](https://reactnative.dev/docs/linking-libraries-ios#manual-linking).

## Usage

```javascript
const source = { uri: 'http://path.to/myVideo.mp4' };

<Video360 source={myVideo} style={{ flex: 1}} />
```

```javascript
import myVideo from './assets/myVideo.mp4';

<Video360 source={myVideo} style={{ flex: 1}} />
```

## No iOS Simulator support

360 Videos will _not_ be visible on an iOS simulator. SGPlayer relies on Apple's [Metal API](https://developer.apple.com/documentation/metal) for 3D rendering.  Unfortunately, interactions with the metal API are poorly supported on iOS simulators.  To test 360 degree videos, be sure you load the application on a real device.  On simulators, rendering a 360 degree video will not work correctly.
