import 'package:flutter/material.dart';
import 'package:the_quran/features/auth/view/components/indicator_wirdget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPage(
                title: 'Welcome to MyApp',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'assets/images/1.png',
              ),
              _buildPage(
                title: 'Explore Features',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'assets/images/2.png',
              ),
              _buildPage(
                title: 'Get Started',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                image: 'assets/images/3.png',
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title,
      required String description,
      required String image}) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.asset(
            image,
            height: 200,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(
        i == _currentPage ? indicator(true) : indicator(false),
      );
    }
    return indicators;
  }
}
