import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(),
        home: const HomeScreen(),
      ),
    );
  }
}
