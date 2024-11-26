// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sample_news_app/controller/home_screen_controller.dart';
// import 'package:sample_news_app/view/splash_screen/splash_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => HomeScreenController(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SplashScreen(),
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_news/controller/home_screen_controller.dart';

import 'package:sample_news/view/home_screen/home_screen.dart';
import 'package:sample_news/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //   textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
