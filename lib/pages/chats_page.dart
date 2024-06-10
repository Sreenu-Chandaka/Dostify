//Packages
import "package:dostify/providers/authentication_provider.dart";
import "package:dostify/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:get_it/get_it.dart";

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

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child:  Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar("Chats",primaryAction: IconButton(icon: Icon(Icons.logout,color: Color.fromRGBO(0,82,218,1.0),),onPressed: (){

            },),)
          ],
        ),);
  }
}
