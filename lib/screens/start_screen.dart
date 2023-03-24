import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/all_trailers_screen.dart';
import '../screens/community_screen.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';
import '../screens/search_screen.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/start-screen';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _pageIndex = 0;

  var _isInit = true;

  @override
  void initState() {
    super.initState();
    Provider.of<VideosProvider>(context, listen: false).loadVideos();
    Provider.of<ImagesProvider>(context, listen: false).loadProfileImages();
    Provider.of<UserPovider>(context, listen: false).loadUsers();
  }

  final _screens = [
    HomeScreen(),
    SearchScreen(),
    CommunutyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_pageIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBarTheme(
            data: NavigationBarThemeData(
              elevation: 0,
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 0,
                    ),
              ),
            ),
            child: NavigationBar(
              elevation: 0,
              height: 60,
              backgroundColor: Colors.grey.shade900,
              selectedIndex: _pageIndex,
              onDestinationSelected: (i) => setState(() {
                _pageIndex = i;
              }),
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.home_filled,
                    color: Colors.grey,
                    size: 30,
                  ),
                  label: '',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                  label: '',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.menu_open_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.menu_sharp,
                    color: Colors.grey,
                    size: 30,
                  ),
                  label: '',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
