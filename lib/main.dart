import 'package:flutter/material.dart';

import 'ui/home_page.dart';
import 'widget/media_full_image_view.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          '/routeFullImage': (context) => const MediaFullImageView(),
        },
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ]);
  }
}
