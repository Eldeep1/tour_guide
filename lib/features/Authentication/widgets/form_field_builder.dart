import 'package:flutter/material.dart';


// Form field builder (example implementation)
Widget formFieldBuilder({
  required String label,
  double? width,
  TextEditingController? textEditingController,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixIconClick,
  Function(String)? onFieldSubmitted,
  TextInputType? keyBoardType,
  bool enabled = true,
  bool obscureText = false,
  FormFieldValidator<String>? validator,
  FocusNode? focusNode,
}) {
  return SizedBox(
    width: width,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        focusNode: focusNode,
        validator: validator,
        obscureText: obscureText,
        controller: textEditingController,
        enabled: enabled,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
            onPressed: suffixIconClick,
            icon: Icon(suffixIcon),
          )
              : null,
        ),

        onFieldSubmitted: onFieldSubmitted,
      ),
    ),
  );
}
