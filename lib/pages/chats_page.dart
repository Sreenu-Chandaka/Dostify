//Packages

import "package:flutter/material.dart";
import "package:provider/provider.dart";

//Providers
import "package:dostify/providers/authentication_provider.dart";
import "../models/chat.dart";
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
      ChangeNotifierProvider(create: (_) => ChatsPageProvider()),
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
    List<Chat>? chats=_pageProvider.chats;
    print(chats);
    print("chats in chatspage..........///////////////////////////////");
    return Expanded(child: ((){
      if(chats!=null){
       if(chats.length!=0){
        return ListView.builder(itemCount: chats.length,itemBuilder: (BuildContext context, index){

          return _chatTile();
        });
      }
      else{
        return const Center(child: CircularProgressIndicator(color: Colors.amber,),);
      }
      }else{
        return Container(
          child: const CircularProgressIndicator(color: Colors.red,),
        );
      }
      
    })());
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
