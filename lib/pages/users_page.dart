import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:get_it/get_it.dart";

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
