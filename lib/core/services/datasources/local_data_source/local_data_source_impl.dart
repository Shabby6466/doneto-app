part of 'local_data_source.dart';

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  SharedPreferences sharedPreferences;

  LocalDataSourceImpl({
  
    required this.sharedPreferences,
  });

  /// This method returns the image path picked from gallery
  /// Output : if operation successful returns [String] tells image is picked successfully
  /// may throw exception
  @override
  Future<String> getImageFromCamera(CameraDevice cameraDevice) async {
    throw UnimplementedError();
  }

  /// This method returns the image path taken from camera
  /// Input: [GetImageFromCameraParams] contains camera preference which is rear or front cameras.
  /// Output : if operation successful returns [String] tells image is taken successfully
  /// may throw exception
  @override
  Future<String> getImageFromGallery() async {
    // return await localImagePicker.getImageFromGallery();
    throw UnimplementedError();
  }

  /// This method set data with key
  /// Input: [String] contains
  /// Output : if operation successful returns [bool]
  /// may throw exception
  @override
  Future<bool> setValue(String key, String data) async {
    await sharedPreferences.setString(key, data);
    return true;
  }

  /// This method get data with key
  /// Input: [String] contains
  /// Output : if operation successful returns [bool]
  /// may throw exception
  // @override
  // Future<String> getToken(String key) async {
  //   try {
  //     final jwtToken = sharedPreferences.getString(key) ?? '';

  //     if (jwtToken.isEmpty) {
  //       sl<Logger>().f('Token Not Found');
  //       // throw const DefaultFailure('token_not_found');
  //     }
  //     return jwtToken;
  //   } on PlatformException catch (_) {
     
  //   } on Exception catch (_) {
      
  //   }
  // }

  /// This method will delete all data
  @override
  Future<bool> deleteAll() async {
    await sharedPreferences.clear();
    return true;
  }

  /// This method will delete specific key data
  @override
  Future<bool> deleteData(String key) async {
    await sharedPreferences.remove(key);
    return true;
  }

  /// This method is used to update Onboarding status in [SharedPreferences]
  /// Input: [bool] The status of language_region
  /// Output: if successful the response will be [bool]
  /// if unsuccessful the response will be [Failure]
  @override
  Future<bool> updateOnboardingStatus(bool params) async {
    await sharedPreferences.setBool(R.storageKeys.onboardingStatus, params);
    return true;
  }

  /// This method is used to get Onboarding status in [SharedPreferences]
  /// Input: [NoParams]
  /// Output: if successful the response will be [bool]
  /// if unsuccessful the response will be [Failure]
  @override
  Future<bool> getOnboardingStatus() async {
    var data = false;
    data = sharedPreferences.getBool(R.storageKeys.onboardingStatus) ?? false;
    return data;
  }

  /// This method is used to save passcode that user enter
  /// Input: [passcode] The [passcode] which user wants to set
  /// Output: if successful the response will be success in setting passcode
  /// if unsuccessful the response will be [Failure]
  @override
  Future<bool> saveToken(String params) async {
    await sharedPreferences.setString(R.storageKeys.authToken, params);
    sl<Logger>().d('Token saved $params');
    return true;
  }

  /// This method is used to clear local storage
  /// Input: [NoParams]
  /// Output: if successful the response will status [bool]
  /// if unsuccessful the response will be [DefaultFailure]
  @override
  Future<bool> clearLocalStorage() async {
    await sharedPreferences.clear();
    return true;
  }

  @override
  Future<String> getToken(String key) async {
    try {
      final jwtToken = sharedPreferences.getString(key) ?? '';

      if (jwtToken.isEmpty) {
        throw const DefaultFailure('token_not_found');
      }
      return jwtToken;
    } on PlatformException catch (_) {
      throw const DefaultFailure('token_not_found');
    } on Exception catch (_) {
      throw const DefaultFailure('token_not_found');
    }
  }

  @override
  Future<String> getValue(String key) async {
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<bool> getThemeMode() async {
    var value = sharedPreferences.getString(R.storageKeys.themeMode) ?? 'light';
    return value == 'dark';
  }

  @override
  Future<bool> setThemeMode(String params) async {
    await sharedPreferences.setString(R.storageKeys.themeMode, params);
    return true;
  }

// @override
// Future<File> downloadQrView(ShareQrCodeInput params) async {
//   try {
//     var pngBytes = params.byteDataI.buffer.asUint8List();
//     if (!R.device.isAndroid) {
//       var output = await getApplicationDocumentsDirectory();
//       final file = await File('${output.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png').create(recursive: true);
//       if (!params.getFile) {
//         final _ = await file.writeAsBytes(pngBytes);
//       }
//       return file;
//     } else {
//       var directory = Directory('/storage/emulated/0/Download');
//       if (await directory.exists()) {
//         final file = await File('${directory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg').create(recursive: true);
//         if (!params.getFile) {
//           final _ = await file.writeAsBytes(pngBytes);
//         }
//         return file;
//       } else {
//         throw const DefaultFailure('Directory Path Not Found');
//       }
//     }
//   } catch (_) {
//     throw const DefaultFailure('QR Download Failed');
//   }
// }
}
