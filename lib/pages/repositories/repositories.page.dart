// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepositoriesPage extends StatefulWidget {
  String login = '';
  String avatarUrl = '';

  RepositoriesPage({super.key, required this.login, required this.avatarUrl});

  @override
  State<RepositoriesPage> createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  dynamic dataRepositories;

  loadRepositories() async {
    String url = 'https://api.github.com/users/${widget.login}/repos';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        dataRepositories = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.login} Repositories'),
        actions: [
          CircleAvatar(backgroundImage: NetworkImage(widget.avatarUrl)),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${dataRepositories[index]['name']}'),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: Colors.deepOrange,
              ),
          itemCount: dataRepositories == null ? 0 : dataRepositories.length),
    );
  }
}
