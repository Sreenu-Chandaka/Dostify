//Packages

// ignore_for_file: unused_field

import "package:flutter/material.dart";
import "package:provider/provider.dart";

//Providers
import "package:dostify/providers/authentication_provider.dart";
import "../providers/chats_page_provider.dart";

//Widgets

import '../widgets/custom_listview_tiles.dart';
import "package:dostify/widgets/top_bar.dart";

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ChatsPageProvider(_auth)),
    ], child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider=_context.watch<ChatsPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                "Chats",
                primaryAction: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  onPressed: () {
                    _auth.logOut();
                  },
                ),
              ),
              _chatList()
            ],
          ),
        );
      }
    );
  }

  Widget _chatList() {
    return _chatTile();
  }

  Widget _chatTile() {
    return CustomListViewTilesWithActivity(
        height: _deviceHeight * 0.1,
        title: "Sreenu Chandaka",
        subtitle: "hello",
        imagePath: 'https://i.pravatar.cc/300',
        isActive: false,
        isActivity: false,
        onTap: () {});
  }
}
