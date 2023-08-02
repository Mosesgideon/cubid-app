import 'package:flutter/material.dart';
class AccountCheck extends StatefulWidget {
  const AccountCheck({Key? key}) : super(key: key);

  @override
  State<AccountCheck> createState() => _AccountCheckState();
}

class _AccountCheckState extends State<AccountCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:const Text('Account'),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
