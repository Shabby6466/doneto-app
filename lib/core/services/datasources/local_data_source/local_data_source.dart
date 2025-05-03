// import 'package:flutter/services.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_data_source_impl.dart';

abstract class LocalDataSource {
  /// This method returns the image path picked from gallery
  /// Output : if operation successful returns [String] tells image is picked successfully
  /// may throw exception
  Future<String> getImageFromGallery();

  /// This method returns the image path taken from camera
  /// Input: [GetImageFromCameraParams] contains camera preference which is rear or front cameras.
  /// Output : if operation successful returns [String] tells image is taken successfully
  /// may throw exception
  Future<String> getImageFromCamera(CameraDevice cameraDevice);

  /// This method set data with key
  /// Input: [String] contains
  /// Output : if operation successful returns [bool]
  /// may throw exception
  Future<bool> setValue(String key, String data);

  Future<String> getValue(String key);

  /// This method get data with key
  /// Input: [String] contains
  /// Output : if operation successful returns [bool]
  /// may throw exception
  

  /// This method will delete all data
  Future<bool> deleteAll();

  /// This method will delete specific key data
  Future<bool> deleteData(String token);

  /// This method is used to update Onboarding status in [SharedPreferences]
  /// Input: [bool] The status of language_region
  /// Output: if successful the response will be [bool]
  /// if unsuccessful the response will be [Failure]
  Future<bool> updateOnboardingStatus(bool params);

  /// This method is used to get Onboarding status in [SharedPreferences]
  /// Input: [NoParams]
  /// Output: if successful the response will be [bool]
  /// if unsuccessful the response will be [Failure]
  Future<bool> getOnboardingStatus();

  /// This method is used to save passcode that user enter
  /// Input: [passcode] The [passcode] which user wants to set
  /// Output: if successful the response will be success in setting passcode
  /// if unsuccessful the response will be [Failure]
  Future<bool> saveToken(String params);

  /// This method is used to clear local storage
  /// Input: [NoParams]
  /// Output: if successful the response will status [bool]
  /// if unsuccessful the response will be [DefaultFailure]
  Future<bool> clearLocalStorage();

  Future<String> getToken(String key);

  Future<bool> getThemeMode();

  Future<bool> setThemeMode(String params);

}
