import 'package:flutter/material.dart';

class AnimatedHintTextField extends StatefulWidget {
  final TextEditingController controller;

  const AnimatedHintTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  _AnimatedHintTextFieldState createState() => _AnimatedHintTextFieldState();
}

class _AnimatedHintTextFieldState extends State<AnimatedHintTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Pay anyone on UPI...',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
      ),
    );
  }
}
