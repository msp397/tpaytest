import 'dart:async';

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

  List<String> hintList = [
    'Pay anyone on UPI...',
    'Enter the amount',
    'UPI ID or Phone Number',
  ];

  int currentHintIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 2000), // Animation duration per hint
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _timer = Timer(Duration(seconds: 2), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          currentHintIndex = (currentHintIndex + 1) % hintList.length;
        });
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
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
          hintText: hintList[currentHintIndex],
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
      ),
    );
  }
}
