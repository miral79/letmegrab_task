// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:letmegrab_task/presentation/screens/todo/todo_list_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  double _currentPage = 0.0;
  Timer? _scrollTimer;

  final Duration _scrollDuration = const Duration(seconds: 5);

  int _contentShownIndex = -1;
  bool _showSkip = false;

  final List<Map<String, dynamic>> _pageData = [
    {'color': const Color(0xFF38B042), 'question': '', 'detail': ''},
    {
      'color': const Color(0xFF38B042),
      'question': 'What is your name?',
      'detail': 'Miral\nButani',
    },
    {
      'color': const Color(0xFF007ACC),
      'question': 'What kind of developer are you?',
      'detail': 'I am a Flutter developer.',
    },
    {
      'color': const Color(0xFF93278F),
      'question': 'How many years of experience do you have?',
      'detail': 'I have two years of experience.',
    },
    {
      'color': const Color(0xFFF7931E),
      'question': 'Which state management do you currently use?',
      'detail': 'Currently, I use BLoC state management.',
    },
    {
      'color': const Color(0xFFED1C24),
      'question': 'What do you think about this animation?',
      'detail': 'I am trying to set the animation as per the Figma you shared.',
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_pageListener);
    _startAutoScroll();

    // Show skip button after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _showSkip = true);
      }
    });
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page ?? 0.0;
    });

    int settledIndex = (_currentPage).round();

    if (_currentPage == settledIndex.toDouble() &&
        _contentShownIndex != settledIndex) {
      Timer(const Duration(seconds: 1), () {
        if (mounted && settledIndex == (_pageController.page ?? 0).round()) {
          setState(() {
            _contentShownIndex = settledIndex;
          });
        }
      });
    }
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(_scrollDuration, (timer) {
      if (!_pageController.hasClients) return;

      int currentIndex = _pageController.page!.round();
      int nextPage = currentIndex + 1;

      _contentShownIndex = -1;

      // Navigate when reaching the last page
      int lastIndex = _pageData.length - 1;
      if (currentIndex == lastIndex) {
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TodoListPage()),
            );
          }
        });
        timer.cancel();
        return;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    int index = _currentPage.floor();
    double fraction = _currentPage - index;

    if (index < 0 || index >= _pageData.length - 1) {
      return _pageData[index.clamp(0, _pageData.length - 1)]['color'];
    }

    final Color start = _pageData[index]['color'];
    final Color end = _pageData[index + 1]['color'];

    return Color.lerp(start, end, fraction) ?? start;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: _getBackgroundColor(),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _pageData.length,
              itemBuilder: (context, index) {
                if (index == 0) return _buildFirstPageLayoutLight();
                return _buildPageContent(index);
              },
            ),

            // Show SKIP button if index >= 2
            if (_showSkip && (_currentPage.round() >= 2))
              Positioned(
                top: 40,
                right: 20,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TodoListPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstPageLayoutLight() {
    final double opacity = 1 - math.min(1.0, (_currentPage - 0).abs());
    final bool show = _contentShownIndex == 0;
    final double slideOffset = show ? 0 : 150;

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.3,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: show ? 1 : 0,
                child: Transform.translate(
                  offset: Offset(slideOffset, 0),
                  child: Text(
                    _pageData[0]['detail'],
                    style: const TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: show ? Colors.black : Colors.white70,
                  fontSize: show ? 25 : 50,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  _pageData[0]['question'],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    final double diff = (_currentPage - index).abs();
    final double opacity = 1 - math.min(1.0, diff);

    final bool show = _contentShownIndex == index;
    final double pageSlideUp = diff * 50.0;
    const Duration slideDuration = Duration(milliseconds: 600);
    final double secondaryOffset = show ? 0 : 300.0;
    final Color questionColor = show ? Colors.black : Colors.white70;
    final double questionFontSize = show ? 30.0 : 40.0;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Opacity(
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, pageSlideUp),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: TextStyle(
                    color: questionColor,
                    fontSize: questionFontSize,
                    fontWeight: show ? FontWeight.normal : FontWeight.bold,
                  ),
                  child: Text(_pageData[index]['question']),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedOpacity(
                duration: slideDuration,
                opacity: show ? 1 : 0,
                child: AnimatedContainer(
                  duration: slideDuration,
                  transform: Matrix4.translationValues(secondaryOffset, 0, 0),
                  child: Text(
                    _pageData[index]['detail'],
                    style: const TextStyle(color: Colors.white, fontSize: 45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
