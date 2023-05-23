import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:colours/colours.dart';
import 'package:google_fonts/google_fonts.dart';

//Screens
import '../screens/start_screen.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/loading.dart';

class TryReconnect extends StatefulWidget {
  @override
  State<TryReconnect> createState() => _TryReconnectState();
}

class _TryReconnectState extends State<TryReconnect> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      //Load all data from firebase
      Provider.of<VideosProvider>(context, listen: false).loadVideos().then(
            (_) => {
              setState(() {
                _isLoading = false;
              })
            },
          );
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;
    //Take locale of Tablet and Smartphone

    return Center(
      child: (video.isEmpty && !_isLoading)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/nointernet.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'No Internet Connection',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 300,
                  child: Text(
                    'Check your internet connection and try again.',
                    style: GoogleFonts.openSans(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colours.aquamarine,
                          Colours.aqua,
                        ],
                      ),
                    ),
                    child: OutlinedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        // try load the DATA
                        await Provider.of<VideosProvider>(context,
                                listen: false)
                            .loadVideos();

                        //Await 5 seconds before try to load the page again
                        Future.delayed(const Duration(seconds: 5)).then((_) {
                          setState(() {
                            _isLoading = false;
                          });

                          Navigator.of(context)
                              .popAndPushNamed(StartScreen.routeName);
                        });
                      },
                      child: Text(
                        'TRY AGAIN',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Loading(),
    );
  }
}
