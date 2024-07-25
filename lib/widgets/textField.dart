import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.obscureText,
    required this.controller,
    this.label,
    this.hintText,
    required this.borderedInput,
    required this.keyboardType,
    this.onChange,
    this.onSubmitted,
    this.errorText,
    this.prefixIcon,
    this.validator,
    required this.isRoundedCorner,
    this.width = 300,
    this.labelPosition,
  });

  final TextEditingController controller;
  final String? label;
  final bool obscureText;
  final String? hintText;
  final bool borderedInput;
  final TextInputType keyboardType;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final String? errorText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool isRoundedCorner;
  final double width;
  final String? labelPosition;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isCenterLabel = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.labelPosition != null && widget.labelPosition == 'center') {
      setState(() {
        isCenterLabel = !isCenterLabel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
          crossAxisAlignment: isCenterLabel
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            widget.labelPosition != null
                ? Text(widget.label ?? '')
                : Container(),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.labelPosition != null ? null : widget.label,
                border: widget.borderedInput
                    ? widget.isRoundedCorner
                        ? const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)))
                        : const OutlineInputBorder()
                    : null,
                hintText: widget.hintText,
                prefixIcon: widget.borderedInput
                    ? widget.prefixIcon != null
                        ? Icon(widget.prefixIcon)
                        : null
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: widget.prefixIcon != null
                            ? Icon(widget.prefixIcon)
                            : null,
                      ),
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
              ),
              keyboardType: widget.keyboardType,
              obscureText:
                  widget.obscureText ? _obscureText : widget.obscureText,
              onChanged: widget.onChange,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ]),
    );
  }
}
