import 'package:flutter/material.dart';

import '../../config/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 90.0, left: 20.0),
              child: Text(
                'THE NEWS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
