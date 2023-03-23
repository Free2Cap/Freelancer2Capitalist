import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/onboarding/page/onboarding_page.dart';

class OnBoarding extends StatelessWidget {
  static final String title = 'Onboarding Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: OnBoardingPage(),
      );
}
