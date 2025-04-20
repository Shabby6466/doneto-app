part of '../r.dart';

/// this class is used to handle icon and graphic data
class Assets {
  final IconsData _icons;
  final Graphics _graphics;

  Assets._() : _icons = const IconsData._(), _graphics = Graphics._();

  IconsData get icons => _icons;

  Graphics get graphics => _graphics;
}

class IconsData {
  const IconsData._();

  Icon get allTales => const Icon(Icons.add);
}

/// this class is used to save handle directory path for the svg and png
class Graphics {
  final SvgAssets _svgIcons;
  final PngAssets _pngIcon;
  final LottieAssets _lottieAssets;

  Graphics._()
    : _svgIcons = const SvgAssets._(),
      _pngIcon = const PngAssets._(),
      _lottieAssets = const LottieAssets._();

  SvgAssets get svgIcons => _svgIcons;

  PngAssets get pngIcons => _pngIcon;

  LottieAssets get lottieAssets => _lottieAssets;
}

class SvgAssets {
  const SvgAssets._();

  String get cameraIcon => 'assets/svg/camera_icon.svg';

  String get charity => 'assets/svg/charity.svg';

  String get easypaisa => 'assets/svg/easypaisa.svg';

  String get exploreIcon => 'assets/svg/explore_icon.svg';

  String get greenArrow => 'assets/svg/green_arrow.svg';

  String get facebookLogo => 'assets/svg/facebook_logo.svg';

  String get filterIcon => 'assets/svg/filter_icon.svg';

  String get googleLogo => 'assets/svg/google_logo.svg';

  String get gpsIcon => 'assets/svg/gps_icon.svg';

  String get heartIcon => 'assets/svg/heart_icon.svg';

  String get homeIcon => 'assets/svg/home_icon.svg';

  String get jazzcash => 'assets/svg/jazzcash.svg';

  String get nothingFound => 'assets/svg/nothing_found.svg';

  String get organizerGrey => 'assets/svg/organizer_grey.svg';

  String get profileIcon => 'assets/svg/profile_icon.svg';

  String get protected => 'assets/svg/protected.svg';

  String get recentDonations => 'assets/svg/recent_donations.svg';

  String get redCross => 'assets/svg/red_cross.svg';

  String get ruppeeCountLine => 'assets/svg/ruppee_count_line.svg';

  String get searchIcon => 'assets/svg/search_icon.svg';

  String get sendIcon => 'assets/svg/send_icon.svg';

  String get someoneElse => 'assets/svg/someone_else.svg';

  String get walletIcon => 'assets/svg/wallet_icon.svg';

  String get whiteDone => 'assets/svg/white_done.svg';

  String get yourselfIcon => 'assets/svg/yourself_icon.svg';
}

class PngAssets {
  const PngAssets._();

  String get donetoLogo => 'assets/png/img.png';

  String get donetoWhiteLogo => 'assets/png/doneto_white.png';

  String get flowers => 'assets/png/flowers.png';

  String get bgFlowers => 'assets/png/bg_flowers.png';

  String get img => 'assets/png/img.png';
}

class LottieAssets {
  const LottieAssets._();

  String get theme => 'assets/lottie/theme.json';

  String get noInternet => 'assets/lottie/no_net.json';

  String get warning => 'assets/lottie/warning.json';
}
