// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Navigation shortcuts to move the selected menu items up or down.
Map<ShortcutActivator, Intent> _kMenuTraversalShortcuts = <ShortcutActivator, Intent>{
  LogicalKeySet(LogicalKeyboardKey.arrowUp): const _ArrowUpIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowDown): const _ArrowDownIntent(),
};

const double _kMinimumWidth = 112.0;

const double _kDefaultHorizontalPadding = 12.0;

/// Defines a [MyDropdownMenu] menu button that represents one item view in the menu.
///
/// See also:
///
/// * [MyDropdownMenu]
class MyDropdownMenuEntry<T> {
  /// Creates an entry that is used with [MyDropdownMenu.dropdownMenuEntries].
  ///
  /// [label] must be non-null.
  const MyDropdownMenuEntry({
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.style,
  });

  /// the value used to identify the entry.
  ///
  /// This value must be unique across all entries in a [MyDropdownMenu].
  final T value;

  /// The label displayed in the center of the menu item.
  final String label;

  /// An optional icon to display before the label.
  final Widget? leadingIcon;

  /// An optional icon to display after the label.
  final Widget? trailingIcon;

  /// Whether the menu item is enabled or disabled.
  ///
  /// The default value is true. If true, the [MyDropdownMenuEntry.label] will be filled
  /// out in the text field of the [MyDropdownMenu] when this entry is clicked; otherwise,
  /// this entry is disabled.
  final bool enabled;

  /// Customizes this menu item's appearance.
  ///
  /// Null by default.
  final ButtonStyle? style;
}

/// A dropdown menu that can be opened from a [TextField]. The selected
/// menu item is displayed in that field.
///
/// This widget is used to help people make a choice from a menu and put the
/// selected item into the text input field. People can also filter the list based
/// on the text input or search one item in the menu list.
///
/// The menu is composed of a list of [MyDropdownMenuEntry]s. People can provide information,
/// such as: label, leading icon or trailing icon for each entry. The [TextField]
/// will be updated based on the selection from the menu entries. The text field
/// will stay empty if the selected entry is disabled.
///
/// The dropdown menu can be traversed by pressing the up or down key. During the
/// process, the corresponding item will be highlighted and the text field will be updated.
/// Disabled items will be skipped during traversal.
///
/// The menu can be scrollable if not all items in the list are displayed at once.
///
/// {@tool dartpad}
/// This sample shows how to display outlined [MyDropdownMenu] and filled [MyDropdownMenu].
///
/// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [MenuAnchor], which is a widget used to mark the "anchor" for a set of submenus.
///   The [MyDropdownMenu] uses a [TextField] as the "anchor".
/// * [TextField], which is a text input widget that uses an [InputDecoration].
/// * [MyDropdownMenuEntry], which is used to build the [MenuItemButton] in the [MyDropdownMenu] list.
class MyDropdownMenu<T> extends StatefulWidget {
  /// Creates a const [MyDropdownMenu].
  ///
  /// The leading and trailing icons in the text field can be customized by using
  /// [leadingIcon], [trailingIcon] and [selectedTrailingIcon] properties. They are
  /// passed down to the [InputDecoration] properties, and will override values
  /// in the [InputDecoration.prefixIcon] and [InputDecoration.suffixIcon].
  ///
  /// Except leading and trailing icons, the text field can be configured by the
  /// [InputDecorationTheme] property. The menu can be configured by the [menuStyle].
  const MyDropdownMenu({
    super.key,
    this.enabled = true,
    this.width,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.textStyle,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.requestFocusOnTap,
    required this.dropdownMenuEntries,
  });

  /// Determine if the [MyDropdownMenu] is enabled.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Determine the width of the [MyDropdownMenu].
  ///
  /// If this is null, the width of the [MyDropdownMenu] will be the same as the width of the widest
  /// menu item plus the width of the leading/trailing icon.
  final double? width;

  /// Determine the height of the menu.
  ///
  /// If this is null, the menu will display as many items as possible on the screen.
  final double? menuHeight;

  /// An optional Icon at the front of the text input field.
  ///
  /// Defaults to null. If this is not null, the menu items will have extra paddings to be aligned
  /// with the text in the text field.
  final Widget? leadingIcon;

  /// An optional icon at the end of the text field.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_down].
  final Widget? trailingIcon;

  /// Optional widget that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above, either
  /// vertically adjacent to, or to the center of the input field.
  ///
  /// Defaults to null.
  final Widget? label;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Defaults to null;
  final String? hintText;

  /// Text that provides context about the [MyDropdownMenu]'s value, such
  /// as how the value will be used.
  ///
  /// If non-null, the text is displayed below the input field, in
  /// the same location as [errorText]. If a non-null [errorText] value is
  /// specified then the helper text is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.helperText], which is the text that provides context about the [InputDecorator.child]'s value.
  final String? helperText;

  /// Text that appears below the input field and the border to show the error message.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.errorText], which is the text that appears below the [InputDecorator.child] and the border.
  final String? errorText;

  /// An optional icon at the end of the text field to indicate that the text
  /// field is pressed.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_up].
  final Widget? selectedTrailingIcon;

  /// Determine if the menu list can be filtered by the text input.
  ///
  /// Defaults to false.
  final bool enableFilter;

  /// Determine if the first item that matches the text input can be highlighted.
  ///
  /// Defaults to true as the search function could be commonly used.
  final bool enableSearch;

  /// The text style for the [TextField] of the [MyDropdownMenu];
  ///
  /// Defaults to the overall theme's [TextTheme.labelLarge]
  /// if the dropdown menu theme's value is null.
  final TextStyle? textStyle;

  /// Defines the default appearance of [InputDecoration] to show around the text field.
  ///
  /// By default, shows a outlined text field.
  final InputDecorationTheme? inputDecorationTheme;

  /// The [MenuStyle] that defines the visual attributes of the menu.
  ///
  /// The default width of the menu is set to the width of the text field.
  final MenuStyle? menuStyle;

  /// Controls the text being edited or selected in the menu.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The value used to for an initial selection.
  ///
  /// Defaults to null.
  final T? initialSelection;

  /// The callback is called when a selection is made.
  ///
  /// Defaults to null. If null, only the text field is updated.
  final ValueChanged<T?>? onSelected;

  /// Determine if the dropdown button requests focus and the on-screen virtual
  /// keyboard is shown in response to a touch event.
  ///
  /// By default, on mobile platforms, tapping on the text field and opening
  /// the menu will not cause a focus request and the virtual keyboard will not
  /// appear. The default behavior for desktop platforms is for the dropdown to
  /// take the focus.
  ///
  /// Defaults to null. Setting this field to true or false, rather than allowing
  /// the implementation to choose based on the platform, can be useful for
  /// applications that want to override the default behavior.
  final bool? requestFocusOnTap;

  /// Descriptions of the menu items in the [MyDropdownMenu].
  ///
  /// This is a required parameter. It is recommended that at least one [MyDropdownMenuEntry]
  /// is provided. If this is an empty list, the menu will be empty and only
  /// contain space for padding.
  final List<MyDropdownMenuEntry<T>> dropdownMenuEntries;

  @override
  State<MyDropdownMenu<T>> createState() => _MyDropdownMenuState<T>();
}

class _MyDropdownMenuState<T> extends State<MyDropdownMenu<T>> {
  final GlobalKey _anchorKey = GlobalKey();
  final GlobalKey _leadingKey = GlobalKey();
  late List<GlobalKey> buttonItemKeys;
  final MenuController _controller = MenuController();
  late final TextEditingController _textEditingController;
  late bool _enableFilter;
  late List<MyDropdownMenuEntry<T>> filteredEntries;
  List<Widget>? _initialMenu;
  int? currentHighlight;
  double? leadingPadding;
  bool _menuHasEnabledItem = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _enableFilter = widget.enableFilter;
    filteredEntries = widget.dropdownMenuEntries;
    buttonItemKeys = List<GlobalKey>.generate(filteredEntries.length, (int index) => GlobalKey());
    _menuHasEnabledItem = filteredEntries.any((MyDropdownMenuEntry<T> entry) => entry.enabled);

    final index = filteredEntries.indexWhere((MyDropdownMenuEntry<T> entry) => entry.value == widget.initialSelection);
    if (index != -1) {
      _textEditingController.text = filteredEntries[index].label;
      _textEditingController.selection = TextSelection.collapsed(offset: _textEditingController.text.length);
    }
    refreshLeadingPadding();
  }

  @override
  void didUpdateWidget(MyDropdownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enableSearch != widget.enableSearch) {
      if (!widget.enableSearch) {
        currentHighlight = null;
      }
    }
    if (oldWidget.dropdownMenuEntries != widget.dropdownMenuEntries) {
      currentHighlight = null;
      filteredEntries = widget.dropdownMenuEntries;
      buttonItemKeys = List<GlobalKey>.generate(filteredEntries.length, (int index) => GlobalKey());
      _menuHasEnabledItem = filteredEntries.any((MyDropdownMenuEntry<T> entry) => entry.enabled);
    }
    if (oldWidget.leadingIcon != widget.leadingIcon) {
      refreshLeadingPadding();
    }
    if (oldWidget.initialSelection != widget.initialSelection) {
      final index = filteredEntries.indexWhere((MyDropdownMenuEntry<T> entry) => entry.value == widget.initialSelection);
      if (index != -1) {
        _textEditingController.text = filteredEntries[index].label;
        _textEditingController.selection = TextSelection.collapsed(offset: _textEditingController.text.length);
      }
    }
  }

  bool canRequestFocus() {
    if (widget.requestFocusOnTap != null) {
      return widget.requestFocusOnTap!;
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
    }
  }

  void refreshLeadingPadding() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        leadingPadding = getWidth(_leadingKey);
      });
    });
  }

  void scrollToHighlight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final highlightContext = buttonItemKeys[currentHighlight!].currentContext;
      if (highlightContext != null) {
        Scrollable.ensureVisible(highlightContext);
      }
    });
  }

  double? getWidth(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.width : null;
    }
    return null;
  }

  List<MyDropdownMenuEntry<T>> filter(List<MyDropdownMenuEntry<T>> entries, TextEditingController textEditingController) {
    final filterText = textEditingController.text.toLowerCase();
    return entries.where((MyDropdownMenuEntry<T> entry) => entry.label.toLowerCase().contains(filterText)).toList();
  }

  int? search(List<MyDropdownMenuEntry<T>> entries, TextEditingController textEditingController) {
    final searchText = textEditingController.value.text.toLowerCase();
    if (searchText.isEmpty) {
      return null;
    }
    final index = entries.indexWhere((MyDropdownMenuEntry<T> entry) => entry.label.toLowerCase().contains(searchText));

    return index != -1 ? index : null;
  }

  List<Widget> _buildButtons(List<MyDropdownMenuEntry<T>> filteredEntries, TextEditingController textEditingController, TextDirection textDirection,
      {int? focusedIndex, bool enableScrollToHighlight = true}) {
    final result = <Widget>[];
    final padding = leadingPadding ?? _kDefaultHorizontalPadding;
    final ButtonStyle defaultStyle;
    switch (textDirection) {
      case TextDirection.rtl:
        defaultStyle = MenuItemButton.styleFrom(
          padding: EdgeInsets.only(left: _kDefaultHorizontalPadding, right: padding),
        );
      case TextDirection.ltr:
        defaultStyle = MenuItemButton.styleFrom(
          padding: EdgeInsets.only(left: padding, right: _kDefaultHorizontalPadding),
        );
    }

    for (var i = 0; i < filteredEntries.length; i++) {
      final entry = filteredEntries[i];
      var effectiveStyle = entry.style ?? defaultStyle;
      final focusedBackgroundColor = effectiveStyle.foregroundColor?.resolve(<WidgetState>{WidgetState.focused}) ?? Theme.of(context).colorScheme.onSurface;

      // Simulate the focused state because the text field should always be focused
      // during traversal. If the menu item has a custom foreground color, the "focused"
      // color will also change to foregroundColor.withOpacity(0.12).
      effectiveStyle = entry.enabled && i == focusedIndex ? effectiveStyle.copyWith(backgroundColor: WidgetStatePropertyAll<Color>(focusedBackgroundColor.withValues(alpha: .12))) : effectiveStyle;

      final menuItemButton = MenuItemButton(
        key: enableScrollToHighlight ? buttonItemKeys[i] : null,
        style: effectiveStyle,
        leadingIcon: entry.leadingIcon,
        trailingIcon: entry.trailingIcon,
        onPressed: entry.enabled
            ? () {
                textEditingController.text = entry.label;
                textEditingController.selection = TextSelection.collapsed(offset: textEditingController.text.length);
                currentHighlight = widget.enableSearch ? i : null;
                widget.onSelected?.call(entry.value);
              }
            : null,
        requestFocusOnHover: false,
        child: Text(entry.label),
      );
      result.add(menuItemButton);
    }

    return result;
  }

  void handleUpKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        _enableFilter = false;
        currentHighlight ??= 0;
        currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        }
        final currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection = TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void handleDownKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        _enableFilter = false;
        currentHighlight ??= -1;
        currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        }
        final currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection = TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void handlePressed(MenuController controller) {
    if (controller.isOpen) {
      currentHighlight = null;
      controller.close();
    } else {
      // close to open
      if (_textEditingController.text.isNotEmpty) {
        _enableFilter = false;
      }
      controller.open();
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    _initialMenu ??= _buildButtons(widget.dropdownMenuEntries, _textEditingController, textDirection, enableScrollToHighlight: false);
    final theme = DropdownMenuTheme.of(context);
    final DropdownMenuThemeData defaults = _DropdownMenuDefaultsM3(context);

    if (_enableFilter) {
      filteredEntries = filter(widget.dropdownMenuEntries, _textEditingController);
    }

    if (widget.enableSearch) {
      currentHighlight = search(filteredEntries, _textEditingController);
      if (currentHighlight != null) {
        scrollToHighlight();
      }
    }

    final menu = _buildButtons(filteredEntries, _textEditingController, textDirection, focusedIndex: currentHighlight);

    final effectiveTextStyle = widget.textStyle ?? theme.textStyle ?? defaults.textStyle;

    MenuStyle? effectiveMenuStyle = widget.menuStyle ?? theme.menuStyle ?? defaults.menuStyle!;

    final anchorWidth = getWidth(_anchorKey);
    if (widget.width != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(minimumSize: WidgetStatePropertyAll<Size?>(Size(widget.width!, 0.0)));
    } else if (anchorWidth != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(minimumSize: WidgetStatePropertyAll<Size?>(Size(anchorWidth, 0.0)));
    }

    if (widget.menuHeight != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(maximumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, widget.menuHeight!)));
    }
    final effectiveInputDecorationTheme = widget.inputDecorationTheme ?? theme.inputDecorationTheme ?? defaults.inputDecorationTheme!;

    final MouseCursor effectiveMouseCursor = canRequestFocus() ? SystemMouseCursors.text : SystemMouseCursors.click;

    return Shortcuts(
      shortcuts: _kMenuTraversalShortcuts,
      child: Actions(
        actions: <Type, Action<Intent>>{
          _ArrowUpIntent: CallbackAction<_ArrowUpIntent>(
            onInvoke: handleUpKeyInvoke,
          ),
          _ArrowDownIntent: CallbackAction<_ArrowDownIntent>(
            onInvoke: handleDownKeyInvoke,
          ),
        },
        child: MenuAnchor(
          style: effectiveMenuStyle,
          controller: _controller,
          menuChildren: menu,
          crossAxisUnconstrained: false,
          builder: (BuildContext context, MenuController controller, Widget? child) {
            assert(_initialMenu != null);
            final Widget trailingButton = Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                isSelected: controller.isOpen,
                icon: widget.trailingIcon ?? const Icon(Icons.arrow_drop_down),
                selectedIcon: widget.selectedTrailingIcon ?? const Icon(Icons.arrow_drop_up),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  handlePressed(controller);
                },
              ),
            );

            final Widget leadingButton = Padding(padding: const EdgeInsets.all(8.0), child: widget.leadingIcon ?? const SizedBox());

            return _DropdownMenuBody(
              width: widget.width,
              children: <Widget>[
                TextField(
                    key: _anchorKey,
                    mouseCursor: effectiveMouseCursor,
                    canRequestFocus: canRequestFocus(),
                    enableInteractiveSelection: canRequestFocus(),
                    textAlignVertical: TextAlignVertical.center,
                    style: effectiveTextStyle,
                    controller: _textEditingController,
                    onEditingComplete: () {
                      if (currentHighlight != null) {
                        final entry = filteredEntries[currentHighlight!];
                        if (entry.enabled) {
                          _textEditingController.text = entry.label;
                          _textEditingController.selection = TextSelection.collapsed(offset: _textEditingController.text.length);
                          widget.onSelected?.call(entry.value);
                        }
                      } else {
                        widget.onSelected?.call(null);
                      }
                      if (!widget.enableSearch) {
                        currentHighlight = null;
                      }
                      if (_textEditingController.text.isNotEmpty) {
                        controller.close();
                      }
                    },
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      handlePressed(controller);
                    },
                    onChanged: (String text) {
                      controller.open();
                      setState(() {
                        filteredEntries = widget.dropdownMenuEntries;
                        _enableFilter = widget.enableFilter;
                      });
                    },
                    decoration: InputDecoration(
                      enabled: widget.enabled,
                      label: widget.label,
                      hintText: widget.hintText,
                      helperText: widget.helperText,
                      errorText: widget.errorText,
                      prefixIcon: widget.leadingIcon != null ? Container(key: _leadingKey, child: widget.leadingIcon) : null,
                      suffixIcon: trailingButton,
                    ).applyDefaults(effectiveInputDecorationTheme)),
                for (final Widget c in _initialMenu!) c,
                trailingButton,
                leadingButton,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ArrowUpIntent extends Intent {
  const _ArrowUpIntent();
}

class _ArrowDownIntent extends Intent {
  const _ArrowDownIntent();
}

class _DropdownMenuBody extends MultiChildRenderObjectWidget {
  const _DropdownMenuBody({
    super.children,
    this.width,
  });

  final double? width;

  @override
  _RenderDropdownMenuBody createRenderObject(BuildContext context) {
    return _RenderDropdownMenuBody(
      width: width,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderDropdownMenuBody renderObject) {
    renderObject.width = width;
  }
}

class _DropdownMenuBodyParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderDropdownMenuBody extends RenderBox with ContainerRenderObjectMixin<RenderBox, _DropdownMenuBodyParentData>, RenderBoxContainerDefaultsMixin<RenderBox, _DropdownMenuBodyParentData> {
  _RenderDropdownMenuBody({
    double? width,
  }) : _width = width;

  double? get width => _width;
  double? _width;

  set width(double? value) {
    if (_width == value) {
      return;
    }
    _width = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DropdownMenuBodyParentData) {
      child.parentData = _DropdownMenuBodyParentData();
    }
  }

  @override
  void performLayout() {
    final constraints = this.constraints;
    var maxWidth = 0.0;
    double? maxHeight;
    var child = firstChild;

    final innerConstraints = BoxConstraints(
      maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );
    while (child != null) {
      if (child == firstChild) {
        child.layout(innerConstraints, parentUsesSize: true);
        maxHeight ??= child.size.height;
        final childParentData = child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      child.layout(innerConstraints, parentUsesSize: true);
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, child.size.width);
      maxHeight ??= child.size.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    size = constraints.constrain(Size(width ?? maxWidth, maxHeight!));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = firstChild;
    if (child != null) {
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      context.paintChild(child, offset + childParentData.offset);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final constraints = this.constraints;
    var maxWidth = 0.0;
    double? maxHeight;
    var child = firstChild;
    final innerConstraints = BoxConstraints(
      maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );

    while (child != null) {
      if (child == firstChild) {
        final childSize = child.getDryLayout(innerConstraints);
        maxHeight ??= childSize.height;
        final childParentData = child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      final childSize = child.getDryLayout(innerConstraints);
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, childSize.width);
      maxHeight ??= childSize.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    return constraints.constrain(Size(width ?? maxWidth, maxHeight!));
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    var child = firstChild;
    var width = 0.0;
    while (child != null) {
      if (child == firstChild) {
        final childParentData = child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final maxIntrinsicWidth = child.getMinIntrinsicWidth(height);
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    var child = firstChild;
    var width = 0.0;
    while (child != null) {
      if (child == firstChild) {
        final childParentData = child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final maxIntrinsicWidth = child.getMaxIntrinsicWidth(height);
      // Add the width of leading Icon.
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      // Add the width of trailing Icon.
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMinIntrinsicHeight(double height) {
    final child = firstChild;
    var width = 0.0;
    if (child != null) {
      width = math.max(width, child.getMinIntrinsicHeight(height));
    }
    return width;
  }

  @override
  double computeMaxIntrinsicHeight(double height) {
    final child = firstChild;
    var width = 0.0;
    if (child != null) {
      width = math.max(width, child.getMaxIntrinsicHeight(height));
    }
    return width;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = firstChild;
    if (child != null) {
      final childParentData = child.parentData! as _DropdownMenuBodyParentData;
      final isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}

// Hand coded defaults. These will be updated once we have tokens/spec.
class _DropdownMenuDefaultsM3 extends DropdownMenuThemeData {
  _DropdownMenuDefaultsM3(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);

  @override
  TextStyle? get textStyle => _theme.textTheme.labelLarge;

  @override
  MenuStyle get menuStyle {
    return const MenuStyle(
      minimumSize: WidgetStatePropertyAll<Size>(Size(_kMinimumWidth, 0.0)),
      maximumSize: WidgetStatePropertyAll<Size>(Size.infinite),
      visualDensity: VisualDensity.standard,
    );
  }

  @override
  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(border: OutlineInputBorder());
  }
}


