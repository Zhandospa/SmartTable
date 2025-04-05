import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onay/Features/home/presentation/widgets/opacity_banner.dart';

class InactivityWrapper extends StatefulWidget {
  final Widget child;
  final Duration timeout;

  const InactivityWrapper({
    super.key,
    required this.child,
    this.timeout = const Duration(seconds: 30),
  });

  @override
  State<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends State<InactivityWrapper>
    with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  Timer? _bannerTimer;
  bool _showBanner = false;
  bool _isAppVisible = true;
  bool _shouldIgnore = false;

  String first = 'images/banner.png';
  String second = 'images/banner1.jpg';
  bool isFirst = true;

  int _firstBannerShown = 0;
  int _secondBannerShown = 0;

  double _firstBannerAccumulated = 0.0;
  double _secondBannerAccumulated = 0.0;

  final int _bannerFullDuration = 60;

  static const ignoredRoutes = [
    'LoginRoute', // Имя маршрута, сгенерированное AutoRoute
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startInactivityTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelAllTimers();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startInactivityTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppVisible = state == AppLifecycleState.resumed;

    if (!_isAppVisible) {
      _cancelAllTimers();
    } else {
      if (_showBanner) {
        setState(() => _showBanner = false);
      }
      _startInactivityTimer();
    }
  }

  void _cancelAllTimers() {
    _inactivityTimer?.cancel();
    _bannerTimer?.cancel();
  }

  void _startInactivityTimer() {
    if (!_isAppVisible || _shouldIgnore) return;

    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(widget.timeout, () {
      if (!_isAppVisible || _shouldIgnore) return;
      setState(() => _showBanner = true);
      _startBannerTracking();
    });
  }

  void _startBannerTracking() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_showBanner) return;

      if (isFirst) {
        _firstBannerAccumulated += 1;
        if (_firstBannerAccumulated >= _bannerFullDuration) {
          _firstBannerShown++;
          debugPrint('📢 Баннер 1 показан $_firstBannerShown раз(а)');
          _firstBannerAccumulated -= _bannerFullDuration;
          setState(() => isFirst = false);
        }
      } else {
        _secondBannerAccumulated += 1;
        if (_secondBannerAccumulated >= _bannerFullDuration) {
          _secondBannerShown++;
          debugPrint('📢 Баннер 2 показан $_secondBannerShown раз(а)');
          _secondBannerAccumulated -= _bannerFullDuration;
          setState(() => isFirst = true);
        }
      }
    });
  }

  void _onInteraction() {
    if (_showBanner) {
      _bannerTimer?.cancel();
      setState(() => _showBanner = false);
    }
    _startInactivityTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final routeName = ModalRoute.of(context)?.settings.name ?? '';
      final newShouldIgnore = ignoredRoutes.contains(routeName);

      if (_shouldIgnore != newShouldIgnore) {
        _shouldIgnore = newShouldIgnore;
        if (_shouldIgnore) {
          _cancelAllTimers();
          if (_showBanner) {
            setState(() => _showBanner = false);
          }
        } else {
          _startInactivityTimer();
        }
      }

      return Listener(
        onPointerDown: (_) => _onInteraction(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.child,
            if (_showBanner && !_shouldIgnore)
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  child: OpacityBanner(
                    key: ValueKey(isFirst),
                    image: isFirst ? first : second,
                  ),
                ),
              ),
              if(_showBanner&& !_shouldIgnore)
                Container(color: const Color.fromRGBO(0, 0, 0, 0.4),)
          ],
        ),
      );
    });
  }
}