import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//Screens
import './screens/home_screen.dart';
import './screens/start_screen.dart';
import './screens/movie_description_screen.dart';
import 'screens/login_screen.dart';

//Providers
import './providers/video_provider.dart';
import './providers/images_provider.dart';

void main() => runApp(VideoStreamer());

class VideoStreamer extends StatefulWidget {
  @override
  State<VideoStreamer> createState() => _VideoStreamerState();
}

class _VideoStreamerState extends State<VideoStreamer> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => VideosProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ImagesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video streamer',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return StartScreen();
            }
            return LoginScreen();
          }),
        ),
      ),
    );
  }
}
