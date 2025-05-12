import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import '../utils/text_styling.dart';

class CustomBottomSheetField<T> extends StatefulWidget {
  final String textLabel;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final double? formWidth;
  final double? formHeight;
  final bool isEnabled;
  final String? validatorText;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final IconData? prefixIcon;
  final String Function(T)? itemToString;

  const CustomBottomSheetField({
    super.key,
    required this.textLabel,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.formWidth,
    this.formHeight,
    required this.isEnabled,
    this.validatorText,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.prefixIcon,
    this.itemToString,
  });

  @override
  _CustomBottomSheetFieldState<T> createState() => _CustomBottomSheetFieldState<T>();
}

class _CustomBottomSheetFieldState<T> extends State<CustomBottomSheetField<T>> {
  late FormFieldState<T> _formFieldState;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select ${widget.textLabel}',
                  style: kTitleStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return ListTile(
                      title: Text(
                        widget.itemToString != null
                            ? widget.itemToString!(item)
                            : item.toString(),
                        style: kTitleStyle.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: widget.selectedItem == item
                          ? Icon(Icons.check, color: kPrimaryColor)
                          : null,
                      onTap: () {
                        _formFieldState.didChange(item);
                        if (widget.onChanged != null) {
                          widget.onChanged!(item);
                        }
                        Navigator.pop(context);
                      },
                    );

                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.fillColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        width: widget.formWidth,
        height: widget.formHeight != null
            ? widget.formHeight! + 20.0 // Space for error text
            : null,
        child: FormField<T>(
          initialValue: widget.selectedItem,
          validator: (value) {
            if (value == null && widget.validatorText != null) {
              return widget.validatorText ??
                  "${widget.textLabel} cannot be empty *";
            }
            return null;
          },
          enabled: widget.isEnabled,
          builder: (FormFieldState<T> state) {
            _formFieldState = state;
            return GestureDetector(
              onTap: widget.isEnabled ? () => _showBottomSheet(context) : null,
              child: InputDecorator(
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
                      width: 1,
                      color: widget.borderColor ?? kBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.borderColor ?? kBackgroundColor,
                    ),
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
                      ? Icon(widget.prefixIcon, color: kPrimaryColor)
                      : null,
                  suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                ),
                child: Text(
                  state.value != null
                      ? (widget.itemToString != null
                      ? widget.itemToString!(state.value!)
                      : state.value.toString())
                      : 'Select ${widget.textLabel}',
                  style: kTitleStyle.copyWith(
                    color: state.value != null ? Colors.black : Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}