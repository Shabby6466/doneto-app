part of '../r.dart';

/// this class is used to check orientation isMobile isTablet and screen size
class Device {
  final Orientation orientation;
  final bool isMobile;
  final bool isTablet;
  final Size screenSize;

  Device._({
    required this.screenSize,
    required this.orientation,
  })  : isMobile = screenSize.shortestSide < 600,
        isTablet = screenSize.shortestSide >= 600;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isAndroid => Platform.isAndroid;

  bool get isIos => Platform.isIOS;
}
