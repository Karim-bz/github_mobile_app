import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_mobile_app/pages/repositories/repositories.page.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String query = '';
  bool notVisible = false;
  TextEditingController queryTextEditingController = TextEditingController();
  dynamic data;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 20;
  ScrollController scrollController = ScrollController();
  List<dynamic> items = [];

  _searchUser(String query) {
    String url =
        'https://api.github.com/search/users?q=$query&per_page=$pageSize&page=$currentPage';
    http.get(Uri.parse(url)).then((response) {
      setState(() {
        setState(() {
          data = json.decode(response.body);
          items.addAll(data['items']);
          if (data['total_count'] % pageSize == 0) {
            totalPages = data['total_count'] ~/ pageSize;
          } else {
            totalPages = (data['total_count'] / pageSize).floor() + 1;
          }
        });
      });
    }).catchError((err) {
      debugPrint(err);
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          if (currentPage < totalPages - 1) {
            ++currentPage;
            _searchUser(query);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => $query => $currentPage / $totalPages'),
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
                      items = [];
                      currentPage = 0;
                      query = queryTextEditingController.text;
                      _searchUser(query);
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 2,
                        color: Colors.deepOrange,
                      ),
                  controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RepositoriesPage(
                              login: items[index]['login'],
                              avatarUrl: items[index]['avatar_url'],
                            ),
                          ),
                        );
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${items[index]['avatar_url']}"),
                                radius: 25,
                              ),
                              const SizedBox(width: 10),
                              Text("${items[index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${items[index]['score']}"),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
