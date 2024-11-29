import 'package:flutter/material.dart';
import 'package:sample_news/utils/color_constants.dart';
import 'package:sample_news/utils/image_constants.dart';
import 'package:sample_news/view/bottom_main_screen/bottom_main_screen.dart';
import 'package:sample_news/view/home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstants.splashImage))),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.PrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
