import 'dart:async';
import 'package:flutter/material.dart';

class InactivityWrapper extends StatefulWidget {
  final Widget child;
  final Duration timeout;

  const InactivityWrapper({
    super.key,
    required this.child,
    this.timeout = const Duration(seconds: 10),
  });

  @override
  State<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends State<InactivityWrapper> {
  Timer? _timer;
  Timer? _timerForBanner;
  bool _showBanner = false;

  String first = 'images/banner.png';
  String two = 'images/banner1.jpg';

  bool isFirst = true;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.timeout, () {
      setState(() {
        _showBanner = true;
      });
      _startBanner();
    });
  }

  void _startBanner() {
  if (!_showBanner) return;
  
  _timerForBanner?.cancel();
  _timerForBanner = Timer(const Duration(seconds: 10), () {
    setState(() {
      isFirst = !isFirst;
    });
    _startBanner();
  });
}


  void _onInteraction() {
    if (_showBanner) {
      setState(() => _showBanner = false);
    }
    _startTimer();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timerForBanner?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _onInteraction(),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          widget.child,
          if (_showBanner)
            Positioned.fill(
              child: Image.asset(
                isFirst ? first : two,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
