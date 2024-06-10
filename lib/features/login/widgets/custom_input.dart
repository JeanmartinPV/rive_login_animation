import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.controller,
    required this.labelText,
    required this.hintText,
    required this.onTap,
    this.onChanged,
    this.obscureText = false,
  });
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final VoidCallback onTap;
  final bool obscureText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
              )
            ],
          ),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            onChanged: onChanged,
            onTap: onTap,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 18,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintText,
              focusColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
