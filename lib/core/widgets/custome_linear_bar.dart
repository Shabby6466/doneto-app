import 'package:flutter/material.dart';

class CustomLinearProgressBar extends StatefulWidget {
  final double percent;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final LinearGradient? linearGradient;
  final bool animation;
  final int animationDuration;
  final bool animateFromLastPercent;
  final Widget? leading;
  final Widget? trailing;
  final Widget? center;
  final Radius? borderRadius;
  final EdgeInsets padding;
  final MainAxisAlignment alignment;
  final bool isRTL;
  final Curve curve;
  final VoidCallback? onAnimationEnd;
  final Widget? indicator;

  const CustomLinearProgressBar({
    super.key,
    this.percent = 0.0,
    this.width,
    this.height = 5.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.linearGradient,
    this.animation = false,
    this.animationDuration = 500,
    this.animateFromLastPercent = false,
    this.leading,
    this.trailing,
    this.center,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.isRTL = false,
    this.curve = Curves.linear,
    this.onAnimationEnd,
    this.indicator,
  });

  @override
  State createState() => _CustomLinearProgressBarState();
}

class _CustomLinearProgressBarState extends State<CustomLinearProgressBar> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double _currentPercent = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.animation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration),
      );

      _animation = Tween<double>(
        begin: widget.animateFromLastPercent ? _currentPercent : 0.0,
        end: widget.percent,
      ).animate(CurvedAnimation(
        parent: _animationController!,
        curve: widget.curve,
      ));

      _animation!.addListener(() {
        setState(() {
          _currentPercent = _animation!.value;
        });
      });

      _animationController!.addStatusListener((status) {
        if (widget.onAnimationEnd != null && status == AnimationStatus.completed) {
          widget.onAnimationEnd!();
        }
      });

      _animationController!.forward();
    } else {
      _currentPercent = widget.percent;
    }
  }

  @override
  void didUpdateWidget(CustomLinearProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.percent != oldWidget.percent) {
      if (widget.animation) {
        _animationController?.duration = Duration(milliseconds: widget.animationDuration);
        _animation = Tween<double>(
          begin: oldWidget.percent,
          end: widget.percent,
        ).animate(CurvedAnimation(
          parent: _animationController!,
          curve: widget.curve,
        ));
        _animationController?.forward(from: 0.0);
      } else {
        setState(() {
          _currentPercent = widget.percent;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressWidth = (widget.width ?? double.infinity) * _currentPercent;
    final hasWidth = widget.width != null;
    final progressBar = Container(
      width: hasWidth ? widget.width : double.infinity,
      height: widget.height,
      padding: widget.padding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!.x) : null,
            ),
          ),
          Positioned(
            left: widget.isRTL ? null : 0,
            right: widget.isRTL ? 0 : null,
            child: Container(
              width: progressWidth,
              height: widget.height,
              decoration: BoxDecoration(
                gradient: widget.linearGradient,
                color: widget.linearGradient == null ? widget.progressColor : null,
                borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!.x) : null,
              ),
              child: widget.indicator != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: widget.indicator!,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );

    final items = <Widget>[
      if (widget.leading != null) widget.leading!,
      Expanded(child: progressBar),
      if (widget.trailing != null) widget.trailing!,
    ];

    return Row(
      mainAxisAlignment: widget.alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items,
    );
  }
}
