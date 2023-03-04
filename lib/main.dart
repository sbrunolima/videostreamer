import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//Screens
import './screens/home_screen.dart';
import './screens/movie_description_screen.dart';

//Providers
import './providers/video_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => VideosProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video streamer',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
