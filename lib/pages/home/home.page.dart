import 'package:flutter/material.dart';
import 'package:github_mobile_app/pages/users/users.page.dart';
import 'package:github_mobile_app/widgets/drawer.widget.dart';

class HomePage extends StatelessWidget {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("images/github.png"),
              radius: 40,
            ),
            OutlinedButton(
              child: const Text(
                "Search By User",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
