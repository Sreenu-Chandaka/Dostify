// ignore_for_file: no_leading_underscores_for_local_identifiers
//Packages
import 'package:flutter/material.dart';

//Pages
import '../pages/chats_page.dart';
import '../pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [const ChatsPage(), const UsersPage()];

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (_index) {
          setState(() {
            _currentPage = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_sharp), label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp), label: "Users")
        ],
      ),
    );
  }
}
