import 'package:flutter/material.dart';
import 'package:himochat/widgets/constant.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    this.onTap,
    this.buttonText,
  });
  final VoidCallback? onTap;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
