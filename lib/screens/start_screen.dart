import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

//Screens
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/community_screen.dart';

//Providers
import '../providers/video_provider.dart';
import '../screens/search_screen.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/start-screen';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _pageIndex = 0;

  //All the screens on the bottm navbar
  final _screens = [
    HomeScreen(),
    SearchScreen(),
    CommunutyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex == 0) {
          //If the indexs is zero and the user press the andoid back button,
          //the app closes
          SystemNavigator.pop();
        } else {
          //If the page index is not zero and the user press the andoid back button,
          ////it will return to page index zero
          setState(() {
            _pageIndex = 0;
          });
        }

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: _screens
              .asMap()
              .map((i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: _pageIndex != i,
                      child: screen,
                    ),
                  ))
              .values
              .toList(),
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
                          fontSize: 10,
                        ),
                  ),
                ),
                child: NavigationBar(
                  elevation: 0,
                  height: 50,
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
                        size: 26,
                      ),
                      icon: Icon(
                        Icons.home_filled,
                        color: Colors.grey,
                        size: 26,
                      ),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 26,
                      ),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(
                        EneftyIcons.device_message_bold,
                        color: Colors.white,
                        size: 24,
                      ),
                      icon: Icon(
                        EneftyIcons.device_message_outline,
                        color: Colors.grey,
                        size: 24,
                      ),
                      label: 'Comunity',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 26,
                      ),
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 26,
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
