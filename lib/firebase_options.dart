import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXA-ac0gmdKzgc0oIjRaBmzindGUibL3w',
    appId: '1:247631837332:web:d196c1cd53dd1b3d311c81',
    messagingSenderId: '247631837332',
    projectId: 'spoonshare-10',
    authDomain: 'spoonshare-10.firebaseapp.com',
    storageBucket: 'spoonshare-10.appspot.com',
    measurementId: 'G-EZGKLJT7RF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDERHyVbBJSm8matFIuZpTYPPqJQ5HbLMQ',
    appId: '1:247631837332:android:1ba855f7386a048b311c81',
    messagingSenderId: '247631837332',
    projectId: 'spoonshare-10',
    storageBucket: 'spoonshare-10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYH2Vmm2Ts41-Utj5aYdAuiWDqRkSWurg',
    appId: '1:247631837332:ios:9eb13eed86b5beb8311c81',
    messagingSenderId: '247631837332',
    projectId: 'spoonshare-10',
    storageBucket: 'spoonshare-10.appspot.com',
    iosClientId: '247631837332-d29a3itsoe7ja2ei6oem0rtmhlq9k9ba.apps.googleusercontent.com',
    iosBundleId: 'com.example.spoonshare',
  );
}
