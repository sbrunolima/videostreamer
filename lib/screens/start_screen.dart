import 'package:enefty_icons/enefty_icons.dart';
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

  final _screens = [
    HomeScreen(),
    SearchScreen(),
    CommunutyScreen(),
    ProfileScreen(),
  ];

  //Responsible for refreshing the UI
  Future<void> _refreshSongs(BuildContext context) async {
    Provider.of<VideosProvider>(context, listen: false).loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _pageIndex = 0;
        });

        return false;
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => _refreshSongs(context),
          child: _screens[_pageIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavigationBarTheme(
                data: NavigationBarThemeData(
                  elevation: 0,
                  indicatorColor: Colors.transparent,
                  labelTextStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                  ),
                ),
                child: NavigationBar(
                  elevation: 0,
                  height: 60,
                  backgroundColor: Colors.black,
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
                      label: 'Home',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 32,
                      ),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(
                        EneftyIcons.device_message_bold,
                        color: Colors.white,
                        size: 28,
                      ),
                      icon: Icon(
                        EneftyIcons.device_message_outline,
                        color: Colors.grey,
                        size: 28,
                      ),
                      label: 'Comunity',
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
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
