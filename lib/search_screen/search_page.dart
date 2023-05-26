import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:colours/colours.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/my_app_bar.dart';
import '../widgets/my_back_icon.dart';
import '../search_screen/movie_search_list.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //Find the trailer on the server
  Future<void> _searchForm(String query) async {
    await Provider.of<VideosProvider>(context, listen: false).findVideo(query);
  }

  @override
  Widget build(BuildContext context) {
    //Create a const sizedBox to load only one time
    const mySizedBox = SizedBox(height: 17);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
        title: MyAppBar(),
        actions: [
          SizedBox(width: 55),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                mySizedBox,
                TextField(
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
                  onChanged: (value) {
                    //Take the value string and check if the movie exists
                    setState(() {
                      _searchForm(value.toString());
                    });
                  },
                ),
                const SizedBox(height: 20),
                //Load the finded video and show to the user
                MovieSearchList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
