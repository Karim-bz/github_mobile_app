import 'package:flutter/material.dart';
import 'package:github_mobile_app/pages/home/home.page.dart';
import 'package:github_mobile_app/pages/users/users.page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/github.png"),
                radius: 40,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Home Page',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.home),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Search By User',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.search),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
