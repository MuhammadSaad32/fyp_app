import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/chat/chat_home.dart';
import '../../utils/colors_utils.dart';
import '../../utils/size_config.dart';
import '../favourites/favourites_screen.dart';
import '../home/home_screen.dart';
import '../post/post_screen.dart';
import '../profile/profile_screen.dart';
class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List navBarScreens = [
    const HomeScreen(),
    const ChatHomeScreen(),
    const PostScreen(),
    const FavouritesScreen(),
    const ProfileScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: CurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30,color: whiteColor,),
          Icon(Icons.chat, size: 30,color: whiteColor,),
          Icon(Icons.add, size: 30,color: whiteColor,),
          Icon(Icons.favorite, size: 30,color: whiteColor,),
          Icon(Icons.person, size: 30,color: whiteColor,),
        ],
        color: primaryColor,
        buttonBackgroundColor: primaryColor,
        backgroundColor: whiteColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (tappedIndex) {
          setState(() {
            index = tappedIndex; // Update the index when a tab is tapped.
          });
        },
        letIndexChange: (index) => true,
      ),
      body: navBarScreens[index],
    );
  }
}
