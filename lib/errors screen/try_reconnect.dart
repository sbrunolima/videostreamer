import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Screens
import '../screens/start_screen.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';
import '../providers/carousel_provider.dart';
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/post_likes_provider.dart';
import '../providers/reply_provider.dart';
import '../providers/comment_like_provider.dart';
import '../providers/reply_like_provider.dart';

//Widgets
import '../widgets/loading.dart';

class TryReconnect extends StatefulWidget {
  final String pageID;

  TryReconnect({required this.pageID});

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

  //Responsible for refreshing the UI
  Future<void> _refreshVideos(BuildContext context) async {
    await Provider.of<VideosProvider>(context, listen: false).loadVideos();
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
                    Text('TEST'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'No Internet Connection',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 300,
                  child: Text(
                    'Check your internet connection and try again.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      //Call _refreshSongs to try load the DATA
                      _refreshVideos(context);

                      //Await 5 seconds before try to load the page again
                      Future.delayed(const Duration(seconds: 5)).then((_) {
                        setState(() {
                          _isLoading = false;
                        });

                        Navigator.of(context).popAndPushNamed(
                          StartScreen.routeName,
                          arguments: widget.pageID,
                        );
                      });
                    },
                    child: Text(
                      'TRY AGAIN',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      side: const BorderSide(
                        color: Colors.transparent,
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
