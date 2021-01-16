import 'dart:io';

// TODO: Refactor to read from manifest
class AdManager {
  static const String unsupportedError = "unsupported-platform";
  static const String androidAppId = "ca-app-pub-7090741652176321~3319952236";
  static const String androidBannerId =
      "ca-app-pub-7090741652176321/7470950234";
  static const String iOSAppId = "ca-app-pub-7090741652176321~8100779277";
  static const String iOSBannerId = "ca-app-pub-7090741652176321/9713970195";

  static String get appId {
    if (Platform.isAndroid) {
      return androidAppId;
    } else if (Platform.isIOS) {
      return iOSAppId;
    } else {
      throw new UnsupportedError(unsupportedError);
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return androidBannerId;
    } else if (Platform.isIOS) {
      return iOSBannerId;
    } else {
      throw new UnsupportedError(unsupportedError);
    }
  }
}
