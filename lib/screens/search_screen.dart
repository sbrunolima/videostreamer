import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/my_app_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Future<void> _searchForm(String query) async {
    await Provider.of<VideosProvider>(context, listen: false).findVideo(query);
  }

  @override
  Widget build(BuildContext context) {
    const mySizedBox = SizedBox(height: 20);
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.findedVideo;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                mySizedBox,
                MyAppBar(),
                mySizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'What trailer you looking for?',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    // onSubmitted: (value) {
                    //   setState(() {
                    //     videoData.findVideo(value.toString());
                    //   });
                    // },
                    onChanged: (value) {
                      setState(() {
                        _searchForm(value.toString());
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: video.length,
                    itemBuilder: (context, index) {
                      return MovieCard(video: video[index]);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 140,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 160,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
