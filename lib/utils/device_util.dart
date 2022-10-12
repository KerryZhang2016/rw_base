import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

/// 设备信息工具类
class DeviceUtil {
  static IosDeviceInfo? _iosDeviceInfo;
  static AndroidDeviceInfo? _androidDeviceInfo;
  static const bool inProduction = bool.fromEnvironment("dart.vm.product");

  static void initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
      _iosDeviceInfo = await deviceInfo.iosInfo;
    }else if(Platform.isAndroid){
      _androidDeviceInfo = await deviceInfo.androidInfo;
    }
  }

  static String getChannel() => "default";

  static String getPlatform() {
    return Platform.isIOS ? "iOS" : "Android";
  }

  static String getBrand() {
    if (Platform.isIOS && _iosDeviceInfo != null) {
      return _iosDeviceInfo!.model ?? "";
    } else if (Platform.isAndroid && _androidDeviceInfo != null) {
      return "${_androidDeviceInfo!.brand}";
    } else {
      return "unknown";
    }
  }

  /// return [H8296] [iPhone]
  static String getDevice() {
    if (Platform.isIOS && _iosDeviceInfo != null) {
      return _iosDeviceInfo!.model ?? "";
    } else if (Platform.isAndroid && _androidDeviceInfo != null) {
      return "${_androidDeviceInfo!.brand}_${_androidDeviceInfo!.model}";
    } else {
      return "unknown";
    }
  }

  static String getDeviceId() {
    if (Platform.isIOS && _iosDeviceInfo != null) {
      return _iosDeviceInfo!.identifierForVendor ?? "";
    } else if (Platform.isAndroid && _androidDeviceInfo != null) {
      return _androidDeviceInfo!.androidId ?? "";
    } else {
      return "unknown";
    }
  }

  /// return [27] [11.3]
  static String getOsVersion() {
    if (Platform.isIOS && _iosDeviceInfo != null) {
      return _iosDeviceInfo!.systemVersion ?? "";
    } else if (Platform.isAndroid && _androidDeviceInfo != null) {
      return _androidDeviceInfo!.version.sdkInt.toString();
    } else {
      return "unknown";
    }
  }

  static void setOrientationLandLeft() {
    SystemChrome.setPreferredOrientations([
      Platform.isAndroid ? DeviceOrientation.landscapeLeft : DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  static void setOrientationPort() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

/// androidId → String
///The Android hardware device ID that is unique between the device + user and app signing.
///
///board → String
///The name of the underlying board, like "goldfish".
///
///bootloader → String
///The system bootloader version number.
///The consumer-visible brand with which the product/hardware will be associated, if any.
///
///device → String
///The name of the industrial design.
///
///display → String
///A build ID string meant for displaying to the user.
///
///fingerprint → String
///A string that uniquely identifies this build.
///
///hardware → String
///The name of the hardware (from the kernel command line or /proc).
///
///host → String
///Hostname.
///
///id → String
///Either a changelist number, or a label like "M4-rc20".
///
///isPhysicalDevice → bool
///false if the application is running in an emulator, true otherwise.
///
///manufacturer → String
///The manufacturer of the product/hardware.
///
///model → String
///The end-user-visible name for the end product.
///
///product → String
///The name of the overall product.
///
///supported32BitAbis → List<String>
///An ordered list of 32 bit ABIs supported by this device.
///
///supported64BitAbis → List<String>
///An ordered list of 64 bit ABIs supported by this device.
///
///supportedAbis → List<String>
///An ordered list of ABIs supported by this device.
///
///tags → String
///Comma-separated tags describing the build, like "unsigned,debug".
///
///type → String
///The type of build, like "user" or "eng".
///
///version → AndroidBuildVersion
///Android operating system version values derived from android.os.Build.VERSION.


///identifierForVendor → String
///Unique UUID value identifying the current device.
///
///isPhysicalDevice → bool
///false if the application is running in a simulator, true otherwise.
///
///localizedModel → String
///Localized name of the device model.
///
///model → String
///Device model.
///
///name → String
///Device name.
///
///systemName → String
///The name of the current operating system.
///
///systemVersion → String
///The current operating system version.
///
///utsname → IosUtsname
///Operating system information derived from sys/utsname.h.
}