import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online/resources/auth_methods.dart';
import 'package:online/screens/history_meeting_screen.dart';
import 'package:online/screens/meeting_screen.dart';
import 'package:online/utils/colors.dart';
import 'package:online/widgets/customButton.dart';
//import 'package:online/widgets/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
     MeetingScreen(),
    const HistoryMeetingScreen(),
    const Text("Contacts"),
    CustomButton(text: "Log Out", onPressed: ()=>AuthMethods().signOut()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text("Meet & chat"),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue, // Adjust as needed
        unselectedItemColor: Colors.grey, // Adjust as needed
        unselectedFontSize: 14,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme:
            const IconThemeData(size: 25), // Adjust icon size of selected item
        unselectedIconTheme: const IconThemeData(size: 20),
        onTap: onPageChanged,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: footerColor,
              icon: Icon(
                Icons.comment_bank,
              ),
              label: "Meet & chat"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.lock_clock,
              ),
              label: "Meetings"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
              ),
              label: "Contacts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_applications_sharp,
              ),
              label: "Settings"),
        ],
      ),
    );
  }
}


