import 'package:flutter/material.dart';
import 'package:store/k.dart';
import 'package:store/routes.dart';
import 'package:store/screens/welcome/welcome_content.dart';
import 'package:store/components/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> welcomeData = [
    {
      "text": "Welcome to your Store, Let’s shop!",
      "image": "assets/welcome_1.svg"
    },
    {
      "text": "We help people connect with stores \naround the world.",
      "image": "assets/welcome_2.svg"
    },
    {
      "text": "Experience the easiest way to shop. \nJust stay at home with us.",
      "image": "assets/welcome_3.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Space from the top
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: welcomeData.length,
                  itemBuilder: (context, index) => WelcomeContent(
                    image: welcomeData[index]["image"]!,
                    text: welcomeData[index]['text']!,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  welcomeData.length,
                      (index) => buildDot(index),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Store', style: headingStyle),
              const SizedBox(height: 10),
              const Text(
                'Discover amazing products and enjoy seamless shopping.',
                style: kSubtitleTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context , AppRoutes.login);
                },
                text: "Let's Go   →",
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
