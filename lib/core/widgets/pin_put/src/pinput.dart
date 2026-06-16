import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
part 'pinput_state.dart';
part 'utils/enums.dart';
part 'utils/pinput_constants.dart';
part 'widgets/widgets.dart';
part 'models/pin_theme.dart';
part 'models/models.dart';
part 'models/sms_retriever.dart';
part 'utils/extensions.dart';
part 'widgets/_pin_item.dart';
part 'utils/pinput_utils_mixin.dart';
part 'widgets/_pinput_selection_gesture_detector_builder.dart';

class Pinput extends StatefulWidget {
  const Pinput({
    this.length = PinputConstants._defaultLength,
    this.smsRetriever,
    this.defaultPinTheme,
    this.focusedPinTheme,
    this.submittedPinTheme,
    this.followingPinTheme,
    this.disabledPinTheme,
    this.errorPinTheme,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onTap,
    this.onLongPress,
    this.onTapOutside,
    this.controller,
    this.focusNode,
    this.preFilledWidget,
    this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.pinContentAlignment = Alignment.center,
    this.animationCurve = Curves.easeIn,
    this.animationDuration = PinputConstants._animationDuration,
    this.pinAnimationType = PinAnimationType.scale,
    this.enabled = true,
    this.readOnly = false,
    this.useNativeKeyboard = true,
    this.toolbarEnabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.showCursor = true,
    this.isCursorAnimationEnabled = true,
    this.enableIMEPersonalizedLearning = false,
    this.enableSuggestions = true,
    this.hapticFeedbackType = HapticFeedbackType.disabled,
    this.closeKeyboardWhenCompleted = true,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.slideTransitionBeginOffset,
    this.cursor,
    this.keyboardAppearance,
    this.inputFormatters = const [],
    this.textInputAction,
    this.autofillHints = const [
      AutofillHints.oneTimeCode,
    ],
    this.obscuringCharacter = '•',
    this.obscuringWidget,
    this.selectionControls,
    this.restorationId,
    this.onClipboardFound,
    this.onAppPrivateCommand,
    this.mouseCursor,
    this.forceErrorState = false,
    this.errorText,
    this.validator,
    this.errorBuilder,
    this.errorTextStyle,
    this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
    this.scrollPadding = const EdgeInsets.all(20),
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    super.key,
  })  : assert(obscuringCharacter.length == 1),
        assert(length > 0),
        assert(
          textInputAction != TextInputAction.newline,
          'Pinput is not multiline',
        ),
        _builder = null;
  Pinput.builder({
    required PinItemWidgetBuilder builder,
    this.smsRetriever,
    this.length = PinputConstants._defaultLength,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onTap,
    this.onLongPress,
    this.onTapOutside,
    this.controller,
    this.focusNode,
    this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.enabled = true,
    this.readOnly = false,
    this.useNativeKeyboard = true,
    this.toolbarEnabled = true,
    this.autofocus = false,
    this.enableIMEPersonalizedLearning = false,
    this.enableSuggestions = true,
    this.hapticFeedbackType = HapticFeedbackType.disabled,
    this.closeKeyboardWhenCompleted = true,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardAppearance,
    this.inputFormatters = const [],
    this.textInputAction,
    this.autofillHints,
    this.selectionControls,
    this.restorationId,
    this.onClipboardFound,
    this.onAppPrivateCommand,
    this.mouseCursor,
    this.forceErrorState = false,
    this.validator,
    this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
    this.scrollPadding = const EdgeInsets.all(20),
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    super.key,
  })  : assert(length > 0),
        assert(
          textInputAction != TextInputAction.newline,
          'Pinput is not multiline',
        ),
        _builder = _PinItemBuilder(
          itemBuilder: builder,
        ),
        defaultPinTheme = null,
        focusedPinTheme = null,
        submittedPinTheme = null,
        followingPinTheme = null,
        disabledPinTheme = null,
        errorPinTheme = null,
        preFilledWidget = null,
        pinContentAlignment = Alignment.center,
        animationCurve = Curves.easeIn,
        animationDuration = PinputConstants._animationDuration,
        pinAnimationType = PinAnimationType.scale,
        obscureText = false,
        showCursor = false,
        isCursorAnimationEnabled = false,
        slideTransitionBeginOffset = null,
        cursor = null,
        obscuringCharacter = '•',
        obscuringWidget = null,
        errorText = null,
        errorBuilder = null,
        errorTextStyle = null;
  final PinTheme? defaultPinTheme;
  final PinTheme? focusedPinTheme;
  final PinTheme? submittedPinTheme;
  final PinTheme? followingPinTheme;
  final PinTheme? disabledPinTheme;
  final PinTheme? errorPinTheme;
  final bool closeKeyboardWhenCompleted;
  final int length;
  final SmsRetriever? smsRetriever;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? preFilledWidget;
  final JustIndexedWidgetBuilder? separatorBuilder;
  final _PinItemBuilder? _builder;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry pinContentAlignment;
  final Curve animationCurve;
  final Duration animationDuration;
  final PinAnimationType pinAnimationType;
  final Offset? slideTransitionBeginOffset;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool useNativeKeyboard;
  final bool toolbarEnabled;
  final bool showCursor;
  final bool isCursorAnimationEnabled;
  final bool enableIMEPersonalizedLearning;
  final Widget? cursor;
  final Brightness? keyboardAppearance;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final String obscuringCharacter;
  final Widget? obscuringWidget;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool enableSuggestions;
  final TextSelectionControls? selectionControls;
  final String? restorationId;
  final ValueChanged<String>? onClipboardFound;
  final HapticFeedbackType hapticFeedbackType;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final MouseCursor? mouseCursor;
  final bool forceErrorState;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final PinputErrorBuilder? errorBuilder;
  final FormFieldValidator<String>? validator;
  final PinputAutovalidateMode pinputAutovalidateMode;
  final EdgeInsets scrollPadding;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TapRegionCallback? onTapOutside;
  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  State<Pinput> createState() => _PinputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'defaultPinTheme',
        defaultPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'focusedPinTheme',
        focusedPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'submittedPinTheme',
        submittedPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'followingPinTheme',
        followingPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'disabledPinTheme',
        disabledPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinTheme>(
        'errorPinTheme',
        errorPinTheme,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextEditingController>(
        'controller',
        controller,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<FocusNode>(
        'focusNode',
        focusNode,
        defaultValue: null,
      ),
    );
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: true));
    properties.add(
      DiagnosticsProperty<bool>(
        'closeKeyboardWhenCompleted',
        closeKeyboardWhenCompleted,
        defaultValue: true,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextInputType>(
        'keyboardType',
        keyboardType,
        defaultValue: TextInputType.number,
      ),
    );
    properties.add(
      DiagnosticsProperty<int>(
        'length',
        length,
        defaultValue: PinputConstants._defaultLength,
      ),
    );
    properties.add(
      DiagnosticsProperty<ValueChanged<String>?>(
        'onCompleted',
        onCompleted,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<ValueChanged<String>?>(
        'onChanged',
        onChanged,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<ValueChanged<String>?>(
        'onClipboardFound',
        onClipboardFound,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<VoidCallback?>('onTap', onTap, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<VoidCallback?>(
        'onLongPress',
        onLongPress,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Widget?>(
        'preFilledWidget',
        preFilledWidget,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Widget?>('cursor', cursor, defaultValue: null),
    );
    properties.add(
      DiagnosticsProperty<JustIndexedWidgetBuilder?>(
        'separatorBuilder',
        separatorBuilder,
        defaultValue: PinputConstants._defaultSeparator,
      ),
    );
    properties.add(
      DiagnosticsProperty<_PinItemBuilder>(
        '_builder',
        _builder,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<Widget?>(
        'obscuringWidget',
        obscuringWidget,
        defaultValue: null,
      ),
    );

    properties.add(
      DiagnosticsProperty<MainAxisAlignment>(
        'mainAxisAlignment',
        mainAxisAlignment,
        defaultValue: MainAxisAlignment.center,
      ),
    );
    properties.add(
      DiagnosticsProperty<AlignmentGeometry>(
        'pinContentAlignment',
        pinContentAlignment,
        defaultValue: Alignment.center,
      ),
    );
    properties.add(
      DiagnosticsProperty<Curve>(
        'animationCurve',
        animationCurve,
        defaultValue: Curves.easeIn,
      ),
    );
    properties.add(
      DiagnosticsProperty<Duration>(
        'animationDuration',
        animationDuration,
        defaultValue: PinputConstants._animationDuration,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinAnimationType>(
        'pinAnimationType',
        pinAnimationType,
        defaultValue: PinAnimationType.scale,
      ),
    );
    properties.add(
      DiagnosticsProperty<Offset?>(
        'slideTransitionBeginOffset',
        slideTransitionBeginOffset,
        defaultValue: null,
      ),
    );
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: true));
    properties.add(
      DiagnosticsProperty<bool>('readOnly', readOnly, defaultValue: false),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'obscureText',
        obscureText,
        defaultValue: false,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'useNativeKeyboard',
        useNativeKeyboard,
        defaultValue: false,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'toolbarEnabled',
        toolbarEnabled,
        defaultValue: true,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'showCursor',
        showCursor,
        defaultValue: true,
      ),
    );
    properties.add(
      DiagnosticsProperty<String>(
        'obscuringCharacter',
        obscuringCharacter,
        defaultValue: '•',
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'obscureText',
        obscureText,
        defaultValue: false,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'enableSuggestions',
        enableSuggestions,
        defaultValue: true,
      ),
    );
    properties.add(
      DiagnosticsProperty<List<TextInputFormatter>>(
        'inputFormatters',
        inputFormatters,
        defaultValue: const <TextInputFormatter>[],
      ),
    );
    properties.add(
      EnumProperty<TextInputAction>(
        'textInputAction',
        textInputAction,
        defaultValue: TextInputAction.done,
      ),
    );
    properties.add(
      EnumProperty<TextCapitalization>(
        'textCapitalization',
        textCapitalization,
        defaultValue: TextCapitalization.none,
      ),
    );
    properties.add(
      DiagnosticsProperty<Brightness>(
        'keyboardAppearance',
        keyboardAppearance,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextInputType>(
        'keyboardType',
        keyboardType,
        defaultValue: TextInputType.number,
      ),
    );
    properties.add(
      DiagnosticsProperty<Iterable<String>?>(
        'autofillHints',
        autofillHints,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextSelectionControls?>(
        'selectionControls',
        selectionControls,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<String?>(
        'restorationId',
        restorationId,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<AppPrivateCommandCallback?>(
        'onAppPrivateCommand',
        onAppPrivateCommand,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<MouseCursor?>(
        'mouseCursor',
        mouseCursor,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle?>(
        'errorTextStyle',
        errorTextStyle,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinputErrorBuilder?>(
        'errorBuilder',
        errorBuilder,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<FormFieldValidator<String>?>(
        'validator',
        validator,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<PinputAutovalidateMode>(
        'pinputAutovalidateMode',
        pinputAutovalidateMode,
        defaultValue: PinputAutovalidateMode.onSubmit,
      ),
    );
    properties.add(
      DiagnosticsProperty<HapticFeedbackType>(
        'hapticFeedbackType',
        hapticFeedbackType,
        defaultValue: HapticFeedbackType.disabled,
      ),
    );
    properties.add(
      DiagnosticsProperty<EditableTextContextMenuBuilder?>(
        'contextMenuBuilder',
        contextMenuBuilder,
        defaultValue: _defaultContextMenuBuilder,
      ),
    );
  }
}
