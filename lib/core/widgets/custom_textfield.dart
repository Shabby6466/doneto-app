import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/utils/resource/r.dart';

class MaterialTextFormField extends StatelessWidget {
  const MaterialTextFormField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.onChange,
    this.suffixIcon,
    this.obscureText,
    this.hintText,
    this.maxLength,
    this.keyBoardType,
    this.filled = true,
    this.showPrefixText = false,
    this.controller,
    this.contentPadding,
    this.textInputFormatter,
    this.initialValue,
    this.onSubmitted,
    this.focusNode,
    this.readOnly = false,
    this.enableInteractiveSelection,
    this.radius = 10,
  });

  final String? labelText;
  final String errorText;
  final void Function(String val) onChange;
  final void Function(String val)? onSubmitted;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? hintText;
  final TextInputType? keyBoardType;
  final bool showPrefixText;
  final TextEditingController? controller;
  final bool filled;
  final EdgeInsets? contentPadding;
  final int? maxLength;
  final String? initialValue;
  final double radius;
  final FocusNode? focusNode;
  final bool? enableInteractiveSelection;
  final bool readOnly;

  /// for input format
  final List<TextInputFormatter>? textInputFormatter;

  OutlineInputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius.r),
      ),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      // obscuringCharacter: '•',
      obscuringCharacter: '*',
      initialValue: initialValue,
      onFieldSubmitted: onSubmitted,
      maxLength: maxLength ?? 50,
      scrollPadding: EdgeInsets.zero,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
      onChanged: (e) => onChange(e),
      inputFormatters: textInputFormatter ?? <TextInputFormatter>[],
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        filled: readOnly ? true : filled,
        alignLabelWithHint: true,
        fillColor: readOnly ? Theme.of(context).cardColor.withValues(alpha: .5) : Theme.of(context).cardColor,
        counterText: '',
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
        labelText: labelText,
        // errorText: errorText.isEmpty ? null : errorText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: controller?.text.isEmpty ?? true ? R.palette.lightBorder : R.palette.darkBackground,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: R.palette.darkBackground,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: R.palette.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: R.palette.red, width: 1.5),
        ),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: R.palette.disabledText,
            ),
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16.sp,
              color: R.palette.disabledText,
              fontWeight: FontWeight.w400,
            ),
        suffixIcon: suffixIcon,
        hintText: hintText ?? '',
        isDense: true,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: null,
      ),
      obscureText: obscureText ?? false,
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.onChange,
    this.hintText,
    this.filled = true,
    this.showClear = false,
    required this.controller,
    this.textInputFormatter,
    this.initialValue,
    this.onSubmitted,
    this.onTapClear,
    this.focusNode,
  });

  final String? labelText;
  final String errorText;
  final bool filled, showClear;
  final void Function(String val) onChange;
  final void Function(String val)? onSubmitted;
  final String? hintText;
  final VoidCallback? onTapClear;
  final TextEditingController controller;
  final String? initialValue;
  final FocusNode? focusNode;

  /// for input format
  final List<TextInputFormatter>? textInputFormatter;

  OutlineInputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6.r)),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      onFieldSubmitted: onSubmitted,
      scrollPadding: EdgeInsets.zero,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
      onChanged: (e) => onChange(e),
      inputFormatters: textInputFormatter ?? <TextInputFormatter>[],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        filled: filled,
        alignLabelWithHint: true,
        fillColor: Theme.of(context).cardColor,
        counterText: '',
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: getBorder(errorText.isEmpty ? R.palette.textColor : R.palette.red),
        focusedBorder: getBorder(errorText.isEmpty ? R.palette.textColor : R.palette.red),
        errorBorder: getBorder(R.palette.red),
        focusedErrorBorder: getBorder(R.palette.disabledColor),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
        suffixIcon: !showClear
            ? Icon(
                CupertinoIcons.search,
                color: Theme.of(context).highlightColor,
              )
            : GestureDetector(
                onTap: onTapClear,
                child: Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: R.palette.red.withValues(alpha: .9),
                ),
              ),
        hintText: hintText ?? '',
        isDense: false,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: null,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.focusNode,
    this.enableInteractiveSelection,
    this.controller,
    this.mandatory = false,
    this.readOnly = false,
    this.maxLength,
    this.initialValue,
    required this.onChange,
    this.onSubmitted,
    this.suffixIcon,
    this.obscureText,
    this.clearBtn,
    this.hintText,
    this.validator,
    this.filled = false,
    this.contentPadding,
    this.inputFormatters,
    this.textCapitalization,
    this.keyboardType,
    this.textInputAction,
    this.errorText = '',
    this.showClearIcon = false,
    this.showMaxLength,
  });

  final FocusNode? focusNode;
  final bool showClearIcon;
  final bool? enableInteractiveSelection;
  final bool readOnly;
  final TextEditingController? controller;
  final int? maxLength;
  final String? initialValue;
  final void Function(String val) onChange;
  final void Function(String val)? clearBtn;
  final void Function(String val)? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool mandatory;
  final String? hintText;
  final bool filled;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final String errorText;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool? showMaxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      readOnly: readOnly,
      obscuringCharacter: '*',
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      textInputAction: textInputAction,
      initialValue: initialValue,
      inputFormatters: inputFormatters ?? [],
      validator: validator,
      onFieldSubmitted: onSubmitted,
      maxLength: maxLength ?? 100,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: R.palette.textColor,
            fontSize: 16.sp,
            height: 20.sp / 16.sp,
            fontWeight: FontWeight.w400,
          ),
      onChanged: (e) => onChange(e),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.w),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        counterText: '',
        errorText: validator == null && errorText.isNotEmpty ? errorText : null,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: R.palette.red,
            ),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: R.palette.textColor,
              fontSize: 16.sp,
              height: 20.sp / 16.sp,
              fontWeight: FontWeight.w400,
            ),
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: R.palette.disabledText,
              fontSize: 16.sp,
              height: 20.sp / 16.sp,
              fontWeight: FontWeight.w400,
            ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showClearIcon,
              child: suffixIcon ??
                  GestureDetector(
                    onTap: () {
                      controller?.clear();
                      clearBtn?.call('');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Transform.scale(
                        scale: 1,
                        child: SvgPicture.asset(
                          R.assets.graphics.svgIcons.sendIcon,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
            ),
            if (showMaxLength! && maxLength != null)
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 16.w),
                child: Text(
                  '${controller!.text.length}/$maxLength',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        height: 16.sp / 12.sp,
                        color: R.palette.textColor2,
                      ),
                ),
              ),
          ],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: controller?.text.isEmpty ?? true ? R.palette.lightBorder : R.palette.darkBackground,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: R.palette.darkBackground,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: R.palette.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: R.palette.red, width: 1.5),
        ),
      ),
    );
  }
}
