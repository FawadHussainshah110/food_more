// ignore_for_file: deprecated_member_use

import 'package:food_app_task/core/widgets/pin_put/src/pinput.dart';
import 'package:food_app_task/imports.dart';

class PrimaryPinInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final double? fieldSpacing;
  final Duration animationDuration;
  final TextStyle? textStyle;
  final bool obscureText;
  final String obscuringCharacter;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final double? width;
  final double? height;
  final bool autoFocus;
  final bool enabled;

  const PrimaryPinInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.controller,
    this.width,
    this.height,
    this.fieldSpacing,
    this.animationDuration = const Duration(milliseconds: 200),
    this.textStyle,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.borderRadius,
    this.borderWidth,
    this.autoFocus = true,
    this.enabled = true,
  });

  @override
  State<PrimaryPinInput> createState() => _PrimaryPinInputState();
}

class _PrimaryPinInputState extends State<PrimaryPinInput> {
  late TextEditingController _pinController;
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Use external controller if provided, otherwise create internal one
    _pinController = widget.controller ?? TextEditingController();

    if (widget.autoFocus && widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pinFocusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    // Only dispose internal controller
    if (widget.controller == null) {
      _pinController.dispose();
    }
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPinTheme = PinTheme(
      height: widget.height ?? 65.sp,
      width: widget.width ?? 65.sp,
      textStyle: bodyLarge(context).copyWith(fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: widget.enabled ? (widget.fillColor ?? theme.cardColor) : theme.disabledColor.withOpacity(0.1),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(spacingMedium),
        border: Border.all(color: widget.inactiveBorderColor ?? Colors.transparent, width: widget.borderWidth ?? 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: bodyLarge(context).copyWith(fontWeight: FontWeight.w600, color: Colors.white),
      decoration: defaultPinTheme.decoration?.copyWith(
        color: primaryColor.withValues(alpha: 0.6),
        border: Border.all(color: Colors.transparent, width: widget.borderWidth ?? 2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(
          color: widget.focusedBorderColor ?? widget.activeBorderColor ?? theme.primaryColor,
          width: widget.borderWidth ?? 2,
        ),
      ),
    );

    final disabledPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: theme.disabledColor.withOpacity(0.3), width: 2),
      ),
    );

    return Pinput(
      length: widget.length,
      controller: _pinController,

      focusNode: _pinFocusNode,
      defaultPinTheme: defaultPinTheme,
      submittedPinTheme: submittedPinTheme,
      focusedPinTheme: focusedPinTheme,
      disabledPinTheme: disabledPinTheme,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      pinAnimationType: PinAnimationType.fade,
      animationDuration: widget.animationDuration,
      keyboardType: TextInputType.number,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      enabled: widget.enabled,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      hapticFeedbackType: HapticFeedbackType.heavyImpact,
      showCursor: false,
      separatorBuilder: (index) => SizedBox(width: spacingMedium),
    );
  }
}
