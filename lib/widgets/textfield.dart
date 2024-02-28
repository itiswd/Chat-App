import 'package:flutter/material.dart';
import 'package:himochat/widgets/constant.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    this.hintText,
    this.onChanged,
    required this.obscure,
  });
  final String? hintText;
  final bool? obscure;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required!';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor!,
            width: 1.5,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
