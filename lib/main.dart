import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_training05/community_screen/add_comment.dart';

//Screens
import './screens/home_screen.dart';
import './screens/start_screen.dart';
import 'description_screen/movie_description.dart';
import 'screens/login_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

//Providers
import './providers/video_provider.dart';
import './providers/images_provider.dart';
import './providers/user_provider.dart';
import './providers/carousel_provider.dart';
import './providers/post_provider.dart';
import './providers/comments_provider.dart';
import './providers/post_likes_provider.dart';
import './providers/comment_like_provider.dart';
import './providers/reply_provider.dart';

Future main() async {
  runApp(VideoStreamer());

  //Keep splash screen until the initialization is complete
  FlutterNativeSplash.removeAfter(initialization);
}

Future initialization(BuildContext? context) async {
  //Load all resources before remove splash screen
  await Future.delayed(const Duration(seconds: 3));
}

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
        ChangeNotifierProvider(
          create: (ctx) => UserPovider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CarouselProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ReplyProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostLikeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CommentLikeProvider(),
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
            return AuthScreen();
          }),
        ),
        routes: {
          StartScreen.routeName: (ctx) => StartScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
