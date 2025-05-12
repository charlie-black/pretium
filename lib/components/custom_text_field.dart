import 'package:flutter/material.dart';
import '../utils/color_constants.dart';
import '../utils/text_styling.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController formController;
  final String textLabel;
  final TextInputType textType;
  final double? formWidth;
  final double? formHeight;
  final bool isEnabled;
  final bool isExpandable;
  final int? maxLines;
  final String? validatorText;
  final bool? isObscured;
  final bool? hasSuffixIcon;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.formController,
    required this.textLabel,
    required this.textType,
    this.formWidth,
    this.formHeight,
    required this.isEnabled,
    required this.isExpandable,
    this.maxLines,
    this.isObscured,
    this.validatorText,
    this.borderRadius,
    this.borderColor,
    this.hasSuffixIcon,
    this.fillColor,
    this.prefixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isTextObscured = true;

  @override
  void initState() {
    super.initState();
    _isTextObscured = widget.isObscured ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.fillColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        width: widget.formWidth,
        height: widget.formHeight != null
            ? widget.formHeight! + 10.0
            : null,
        child: TextFormField(
          keyboardType: widget.textType,
          controller: widget.formController,
          enabled: widget.isEnabled,
          expands: widget.isExpandable,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.isObscured == true ? _isTextObscured : false,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                widget.validatorText != null) {
              return widget.validatorText ??
                  "${widget.textLabel} cannot be empty *";
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            labelText: widget.textLabel,
            labelStyle: kNormalTextStyle.copyWith(
              fontWeight: FontWeight.normal,
              color: kPrimaryColor,
              fontSize: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? kBackgroundColor),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? kBackgroundColor),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.0, color: Colors.red),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.0, color: Colors.red),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            ),
            errorStyle: kNormalTextStyle.copyWith(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            errorMaxLines: 2,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
              widget.prefixIcon,
              color: kPrimaryColor,
            )
                : null,
            suffixIcon: widget.hasSuffixIcon == true && widget.isObscured == false
                ? IconButton(
              icon: Icon(
                Icons.verified_user_outlined,
                color: Colors.black.withOpacity(0.3),
              ),
              onPressed: () {
              },
            )
                : widget.isObscured == true
                ? IconButton(
              icon: Icon(
                _isTextObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isTextObscured = !_isTextObscured;
                });
              },
            )
                : null,
          ),
          style: kTitleStyle.copyWith(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}