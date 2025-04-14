import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/lottie_asset.dart';

class NoInternetAppWidget extends StatefulWidget {
  const NoInternetAppWidget({super.key, required this.child});

  final Widget child;

  @override
  State<NoInternetAppWidget> createState() => _NoInternetAppWidgetState();
}

class _NoInternetAppWidgetState extends State<NoInternetAppWidget> {
  int _connectionType = 1;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;
  late final Widget _child = widget.child;

  @override
  void initState() {
    _getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    super.initState();
  }

  Future<void> _getConnectionType() async {
    try {
      final connectivityResult = await (_connectivity.checkConnectivity());
      return _updateState(connectivityResult);
    } on PlatformException catch (_) {}
    return _updateState(ConnectivityResult.none);
  }

  void _updateState(result) {
    if (result[0] == ConnectivityResult.wifi || result[0] == ConnectivityResult.mobile) {
      _connectionType = 1;
      setState(() {});
      return;
    }

    _connectionType = 0;
    setState(() {});
  }

  Widget _noInternetView(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                SizedBox(height: 141.h),
                Text(
                  'No Internet Connection',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Make sure wifi or cellular data is turned on.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red.withValues(alpha: .5),
                      ),
                ),
              ],
            ),
            Expanded(
              child: MyLottieAnim(
                path: R.assets.graphics.lottieAssets.noInternet,
                width: ScreenUtil().screenWidth,
                height: R.device.isMobile ?  600.h : 600.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _child,
        Visibility(
          visible: _connectionType != 1,
          child: _noInternetView(context),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
