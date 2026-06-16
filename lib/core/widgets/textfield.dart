import 'package:flutter/services.dart';
import 'package:food_app_task/core/theme/src/input_decoration_theme.dart';
import 'package:food_app_task/imports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onSuffixIconTap;
  final EdgeInsetsGeometry? padding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final int? maxlength;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool hideFocusBorder;

  const CustomTextField({
    this.controller,
    this.hintText,
    this.suffixWidget,
    this.prefixWidget,
    this.labelText,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.padding,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
    this.onSuffixIconTap,
    this.maxlength,
    this.inputFormatters,
    this.readOnly = false,
    this.hideFocusBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsetsDirectional.only(top: labelText != null ? spacingDefault : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            // title
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(labelText ?? '', style: bodyMedium(context).copyWith(fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: spacingSmall),
          ],
          TextFormField(
            readOnly: readOnly,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLines,
            minLines: minLines,
            onFieldSubmitted: onSubmitted,
            onSaved: onSaved,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onTap: onTap,
            //maxLength: maxlength,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              prefixIcon:
                  prefixWidget ??
                  (prefixIcon != null ? Icon(prefixIcon, size: 20.sp, color: Theme.of(context).hintColor) : null),
              focusedBorder: border(hideFocusBorder: hideFocusBorder || readOnly),
              enabledBorder: hideFocusBorder ? InputBorder.none : null,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(suffixIcon, size: 20.sp, color: Theme.of(context).hintColor),
                    )
                  : suffixWidget,
              hintText: hintText,
              hintStyle: bodyMedium(context).copyWith(color: Theme.of(context).hintColor),
            ),
            style: bodyMedium(context).copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? labelText;
  final IconData? prefixIcon;
  final String? hintText;
  final dynamic value;
  const CustomDropDown({
    required this.items,
    this.labelText,
    required this.onChanged,
    this.hintText,
    super.key,
    this.prefixIcon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(labelText ?? '', style: bodyMedium(context).copyWith(fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: spacingSmall),
        ],
        DropdownButtonFormField(
          value: value,
          icon: Icon(Iconsax.arrow_down_1, size: 20.sp, color: Theme.of(context).hintColor),
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon!, size: 20.sp) : null,
            hintStyle: bodyMedium(context).copyWith(color: Theme.of(context).hintColor),
            labelStyle: bodyMedium(context).copyWith(color: Theme.of(context).hintColor),
          ),
          dropdownColor: Theme.of(context).cardColor,
          style: bodyMedium(context),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
