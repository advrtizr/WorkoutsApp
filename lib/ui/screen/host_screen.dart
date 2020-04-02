import 'package:flutter/material.dart';
import 'package:workout_app/model/navigation_item.dart';
import 'package:workout_app/ui/component/bottom_nav_bar.dart';
import 'package:workout_app/ui/screen/workout_list_screen.dart';
import 'package:workout_app/ui/screen/profile_screen.dart';
import 'package:workout_app/utils/themes.dart';

class HostScreen extends StatefulWidget {
  static String id = 'host_screen';

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  var _initialPage = 0;
  var _currentPage = 0;
  var _fabResizeDuration = Duration(milliseconds: 250);
  var _pageTransitionDuration = Duration(milliseconds: 500);
  var _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _initialPage, keepPage: true);
    super.initState();
  }

  double _defineFabSize() {
    return _currentPage == _initialPage ? 65.0 : 0.0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.cDarkGrey,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            WorkoutListScreen(),
            ProfileScreen(),
          ],
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedContainer(
          duration: _fabResizeDuration,
          curve: Curves.easeInOut,
          width: _defineFabSize(),
          height: _defineFabSize(),
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Themes.cButtonViolet,
              child: Icon(
                Icons.play_arrow,
                color: Themes.cLightGrey,
              ),
              onPressed: () {},
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          navItems: navItems,
          defaultIndex: _initialPage,
          onTap: (currentIndex) {
            setState(() {
              _currentPage = currentIndex;
            });
            _pageController.animateToPage(
              _currentPage,
              curve: Curves.easeInOut,
              duration: _pageTransitionDuration,
            );
          },
        ),
      ),
    );
  }
}
