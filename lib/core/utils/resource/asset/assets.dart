part of '../r.dart';

/// this class is used to handle icon and graphic data
class Assets {
  final IconsData _icons;
  final Graphics _graphics;

  Assets._()
      : _icons = const IconsData._(),
        _graphics = Graphics._();

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

  String get uniceLogo => 'assets/svg/unice_logo.svg';

  String get profileRoundIcon => 'assets/svg/profile_icon.svg';

  String get galleryIcon => 'assets/svg/gallery_icon.svg';

  String get flashTurnedOff => 'assets/svg/flash_turned_off.svg';

  String get qrCameraFrame => 'assets/svg/qr_camera_frame.svg';

  String get downloadBtn => 'assets/svg/download_btn.svg';

  String get lightRightArrow => 'assets/svg/light_right_arrow.svg';

  String get shareIcon => 'assets/svg/share_icon.svg';

  String get facebook => 'assets/svg/facebook.svg';

  String get reloadIcon2 => 'assets/svg/reload_icon2.svg';

  String get emojiIcon => 'assets/svg/emoji.svg';

  String get messenger => 'assets/svg/messenger.svg';

  String get microphone => 'assets/svg/microphone.svg';

  String get attachment => 'assets/svg/attachment.svg';

  String get whatsapp => 'assets/svg/whatsapp.svg';

  String get copyIcon => 'assets/svg/copy_icon.svg';

  String get copyIcon2 => 'assets/svg/copy_icon2.svg';

  String get people => 'assets/svg/people.svg';

  String get sendIcon => 'assets/svg/send_icon.svg';

  String get redGiftBox => 'assets/svg/red_gift_box.svg';

  String get addAsContact => 'assets/svg/add_as_contact.svg';

  String get qrCodeBlack => 'assets/svg/qr_code_black.svg';

  String get qrBottomTab => 'assets/svg/qr_bottom_tab.svg';

  String get profileIcon => 'assets/svg/profile.svg';

  String get addressIcon => 'assets/svg/address.svg';

  String get addById => 'assets/svg/add_by_id.svg';

  String get idRecommended => 'assets/svg/id_recommended.svg';

  String get closeIcon2 => 'assets/svg/close_icon2.svg';

  String get editIcon => 'assets/svg/edit_icon.svg';

  String get walletCart => 'assets/svg/wallet_cart.svg';


  String get walletSwapIcon => 'assets/svg/wallet_swap_icon.svg';

  String get walletDeposit => 'assets/svg/wallet_deposit.svg';

  String get walletTransfer => 'assets/svg/wallet_transfer.svg';

  String get walletQrCode => 'assets/svg/wallet_qr_code.svg';

  String get notificationSettings => 'assets/svg/notification_setting.svg';

  String get chatSetting => 'assets/svg/chat_settings.svg';

  String get privacySettings => 'assets/svg/privacy_icon.svg';

  String get cameraIcon => 'assets/svg/camera_icon.svg';

  String get reloadIcon => 'assets/svg/reload_icon.svg';

  String get uniceText => 'assets/svg/unice_text.svg';

  String get googleLogo => 'assets/svg/google_icon.svg';

  String get appleLogo => 'assets/svg/apple_icon.svg';

  String get translationIcon => 'assets/svg/translation_icon.svg';

  String get swapIcon => 'assets/svg/swap_icon.svg';

  String get blueSwitch => 'assets/svg/blue_switch.svg';

  String get optionsIcon => 'assets/svg/opts_icons.svg';

  String get dropDownButton => 'assets/svg/drop_down_button.svg';

  String get chatBubbleTail => 'assets/svg/chat_bubble_tail.svg';

  String get bluBlur => 'assets/svg/blue_blur.svg';

  String get backArrow => 'assets/svg/back_arrow.svg';

  String get closeIcon => 'assets/svg/close_icon.svg';

  String get expandUp => 'assets/svg/expand_up.svg';

  String get expandDown => 'assets/svg/expand_down.svg';

  String get chats => 'assets/svg/chat.svg';

  String get home => 'assets/svg/home.svg';

  String get nfts => 'assets/svg/nfts.svg';

  String get wallet => 'assets/svg/wallet.svg';

  String get calls => 'assets/svg/calls.svg';

  String get searchIcon => 'assets/svg/search.svg';

  String get searchIcon2 => 'assets/svg/search_2.svg';

  String get addChatIcon => 'assets/svg/add_chat.svg';

  String get phoneIcon => 'assets/svg/phone.svg';

  String get walletScan => 'assets/svg/wallet_scan.svg';

  String get rightArrow => 'assets/svg/right_arrow.svg';

  String get incomingIcon => 'assets/svg/incoming_icon.svg';

  String get missedCallIcon => 'assets/svg/missedcall_icon.svg';

  String get outgoingIcon => 'assets/svg/outgoing_icon.svg';

  String get audioWaveIcon => 'assets/svg/audio_wave_icon.svg';

  String get micIcon => 'assets/svg/mic_icon.svg';

  String get speakerIcon => 'assets/svg/speaker_icon.svg';

  String get videoIcon => 'assets/svg/video_icon.svg';

  String get endCallBtn => 'assets/svg/end_call_btn.svg';

  String get fabBtn => 'assets/svg/fab_btn.svg';

  String get excitedIcon => 'assets/svg/chat_translate_emo_excited.svg';

  String get greenIcon => 'assets/svg/chat_translate_emo_green.svg';
   
  String get stressIcon => 'assets/svg/chat_translate_emo_stress.svg';

  String get micTurnOff => 'assets/svg/mic_turn_off.svg';
  String get micOn => 'assets/svg/mic_on.svg';

  String get videoTurnoff => 'assets/svg/video_turn_off.svg';

  String get bottomLinerGradient => 'assets/svg/bottom_liner_gradient.svg';

  String get videoCallWav => 'assets/svg/video_call_wav.svg';

  String get mixLogo => 'assets/svg/mix_logo.svg';

  String get notifications => 'assets/svg/notifications.svg';

  String get settings => 'assets/svg/settings.svg';

  String get addFriend => 'assets/svg/add_friend.svg';

  String get addToFriendShare => 'assets/svg/add_to_friend_share.svg';

  String get walletHistory => 'assets/svg/history_wallet.svg';

  String get muteNotifications => 'assets/svg/mute_notifications.svg';


  String get walletCardReward => 'assets/svg/wallet_card_reward.svg';

  String get walletRewardCallTime => 'assets/svg/wallet_reward_call_time.svg';

  String get walletRewardTotalWords => 'assets/svg/wallet_reward_total_words.svg';

  String get walletRewardTotalRewards => 'assets/svg/wallet_reward_total_rewards.svg';

  String get walletRewardDataNft => 'assets/svg/wallet_reward_data_nft.svg';

  String get walletRewardAreumNft=> 'assets/svg/wallet_reward_areum_nft.svg';

  String get walletRewardMyReferral => 'assets/svg/wallet_reward_my_referral.svg';

  String get dragIcon => 'assets/svg/drag_icon.svg';

}

class PngAssets {
  const PngAssets._();

  String get areumAvatar => 'assets/png/image_avatar.png';

  String get areumNft => 'assets/png/areum_nft.png';

  String get uniceLogo => 'assets/png/unice_logo.png';

  String get nftImg => 'assets/png/nft_img.png';

  String get img => 'assets/png/image.png';

  String get placeholder => 'assets/png/placeholder.png';

  String get loginBg => 'assets/png/login_bg.png';

  String get on1 => 'assets/png/on1.png';

  String get on2 => 'assets/png/on2.png';

  String get on3 => 'assets/png/on3.png';
}

class LottieAssets {
  const LottieAssets._();

  String get theme => 'assets/lottie/theme.json';

  String get noInternet => 'assets/lottie/no_net.json';

  String get warning => 'assets/lottie/warning.json';
}
