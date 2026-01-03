import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final bool isPhone;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.isPhone = false,
    this.controller,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,

          keyboardType:
              widget.isPhone ? TextInputType.phone : TextInputType.text,

          obscureText:
              widget.isPassword ? !showPassword : false,

          inputFormatters: widget.isPhone
              ? [
                  FilteringTextInputFormatter.digitsOnly, // أرقام فقط
                  LengthLimitingTextInputFormatter(10),    // 10 أرقام
                ]
              : null,

          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(
  color: Colors.grey,
),
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: Colors.blue)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.lightBlue, width: 2),
            ),
          ),
        ),

        // ✅ Checkbox فقط للباسورد
        if (widget.isPassword)
          Row(
            children: [
              Checkbox(
                value: showPassword,
                onChanged: (value) {
                  setState(() {
                    showPassword = value!;
                  });
                },
              ),
               Text('Show password'.tr),
            ],
          ),
      ],
    );
  }
}
