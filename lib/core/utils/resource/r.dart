import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'asset/assets.dart';
part 'device/device.dart';
part 'palette/palette.dart';
part 'storage_keys/storage_key.dart';
part 'string_apis/api_strings.dart';
part 'theme/theme_data.dart';

class R {
  const R._();

  static late Assets _assets;
  static late Device _device;
  static late Palette _palette;
  static late ApiString _apiString;
  static late StorageKeys _storageKeys;

  static int passLength = 8;

  /// will be called first
  static void setData(MediaQueryData mediaQuery) {
    _apiString = ApiString._();
    _device = Device._(
      screenSize: mediaQuery.size,
      orientation: mediaQuery.orientation,
    );
    _storageKeys = StorageKeys._();
    _assets = Assets._();
    _palette = Palette._();
  }

  static Assets get assets => _assets;

  static Device get device => _device;

  static Palette get palette => _palette;

  static ApiString get apiString => _apiString;

  static StorageKeys get storageKeys => _storageKeys;

}
