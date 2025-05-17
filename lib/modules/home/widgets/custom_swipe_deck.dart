import 'dart:math';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwipeDeck extends StatefulWidget {
  final List<Fundraiser> items;

  const CustomSwipeDeck({super.key, required this.items});

  @override
  State<CustomSwipeDeck> createState() => _CustomSwipeDeckState();
}

class _CustomSwipeDeckState extends State<CustomSwipeDeck> {
  int currentIndex = 0;
  double _dragStartX = 0;
  double _dragX = 0;
  bool _isDragging = false;

  static const int maxVisible = 3;
  static final double tiltAngle = 6 * pi / 180; // 5°
  static final double scaleGap = 0.05; // 5% smaller per layer
  static final double offsetGap = 16.0; // px shift per layer
  static final double dragThreshold = 60.0; // px to swipe

  void _onDragEnd() {
    if (_dragX.abs() > dragThreshold) {
      if (_dragX > 0) {
        // swipe right → previous
        currentIndex = (currentIndex - 1) % widget.items.length;
        if (currentIndex < 0) currentIndex += widget.items.length;
      } else {
        // swipe left → next
        currentIndex = (currentIndex + 1) % widget.items.length;
      }
    }
    setState(() {
      _dragX = 0;
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length;
    return GestureDetector(
      onHorizontalDragStart: (d) {
        _dragStartX = d.globalPosition.dx;
        _isDragging = true;
      },
      onHorizontalDragUpdate: (d) {
        setState(() {
          _dragX = d.globalPosition.dx - _dragStartX;
        });
      },
      onHorizontalDragEnd: (_) => _onDragEnd(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children:
                List.generate(min(itemCount, maxVisible), (layer) {
                  // layer = 0 is top, 1 is behind, 2 is furthest behind
                  final depth = layer;
                  final index = (currentIndex + depth) % itemCount;
                  final data = widget.items[index];

                  // base card
                  Widget card = _FundraiserCard(data: data);

                  // scale down for deeper layers
                  card = Transform.scale(scale: 1 - depth * scaleGap, child: card);

                  // rotate for deeper layers
                  card = Transform.rotate(angle: depth * tiltAngle, child: card);

                  // shift deeper layers slightly
                  final dx = depth * offsetGap;
                  card = Transform.translate(offset: Offset(dx, 0), child: card);

                  // if this is the top card and user is dragging, translate with drag
                  if (layer == 0 && _isDragging) {
                    card = Transform.translate(offset: Offset(_dragX, 0), child: card);
                  }

                  // draw furthest layer first
                  return card;
                }).reversed.toList(), // reverse so furthest is painted first
          );
        },
      ),
    );
  }
}

class FundraiserData {
  final String imageUrl, title, subtitle, lastDonation;
  final int raised, goal;

  FundraiserData({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.raised,
    required this.goal,
    required this.lastDonation,
  });
}

class _FundraiserCard extends StatelessWidget {
  final Fundraiser data;

  const _FundraiserCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final progress = (data.receivedAmount / data.targetAmount).clamp(0.0, 1.0);
    double deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: deviceWidth * 0.8,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.45, width: constraints.maxWidth, child: Image.network(data.photoUrl!, fit: BoxFit.cover)),
                Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 14.h, bottom: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title, style: textTheme.titleMedium!.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w800, color: colors.onSurface)),
                      SizedBox(height: 10.h),
                      Text(
                        data.description,
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 10.sp,
                          color: colors.onSurfaceVariant,
                          height: 1.8.h,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${data.receivedAmount} raised of ${data.targetAmount}',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.3.h,
                              color: R.palette.blackColor,
                              //
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'PKR',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.3.h,
                              color: R.palette.primary,
                              //
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 3.5.h,
                            backgroundColor: R.palette.gray,
                            valueColor: AlwaysStoppedAnimation(R.palette.primaryLight),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Visibility(
                        visible: false,
                        child: Center(
                          child: Text(
                            '22 mins',
                            style: textTheme.bodySmall!.copyWith(fontSize: 8.sp, color: colors.onSurfaceVariant, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
