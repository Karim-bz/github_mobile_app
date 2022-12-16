import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  TextEditingController queryTextEditingController = TextEditingController();

  String query = '';
  bool notVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => $query'),
      ),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: notVisible,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      controller: queryTextEditingController,
                      decoration: InputDecoration(
                        // icon: const Icon(Icons.logout),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              notVisible = !notVisible;
                            });
                          },
                          icon: Icon(notVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepOrange,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      query = queryTextEditingController.text;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
