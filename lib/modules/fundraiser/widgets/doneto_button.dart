import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonetoButton extends StatefulWidget {
  final String title;
  final bool loading;
  final GestureTapCallback? onTap;

  const DonetoButton({
    super.key,
    required this.title,
    this.onTap,
    this.loading = false,
    //
  });

  @override
  State<DonetoButton> createState() => _DonetoButtonState();
}

class _DonetoButtonState extends State<DonetoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.loading ? null : widget.onTap,
      child: Container(
        height: 48.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: R.palette.primary),
        child:
            widget.loading
                ? Center(
                  child: SizedBox(key: const Key('circularIndicator'), child: CircularProgressIndicator(color: R.palette.white, strokeWidth: 2.w)),
                )
                : Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(color: R.palette.white, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                  ),
                ),
      ),
    );
  }
}
