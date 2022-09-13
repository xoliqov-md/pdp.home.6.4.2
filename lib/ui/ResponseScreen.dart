import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {

  String user = '';

  @override
  void initState() {
    var box = Hive.box('user');
    user = box.get('user').toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user),
      ),
    );
  }
}
