import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.validator,
    required this.labelName,
    required this.textDirection,
    this.onChanged,
    required this.inputAction,
    this.initialValue,
    this.keyboardType,
    this.obscureText,
    required this.controller,
    required this.theme,
  });

  final String? initialValue;
  final String? Function(String?)? validator;
  final String labelName;
  final TextDirection textDirection;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final bool? obscureText;
  final TextEditingController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: TextFormField(
          maxLines: 4,
          minLines: 1,
          maxLength: null,
          controller: controller,
          textDirection: textDirection,
          initialValue: initialValue,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textInputAction: inputAction,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          validator: validator,
          decoration: InputDecoration(
            errorStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
              fontSize: 12,
            ),
            label: Text(
              labelName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            contentPadding: const EdgeInsets.all(20.0),
            hintStyle: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
