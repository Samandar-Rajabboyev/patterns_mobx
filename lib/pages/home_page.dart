// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:patterns_mobx/stores/home_store.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = HomeStore();

  @override
  void initState() {
    super.initState();
    store.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MobX"),
        ),
        body: Observer(
          builder: (_) => Stack(
            children: [
              ListView.builder(
                itemCount: store.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(store, store.items[index]);
                },
              ),
              store.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => store.onCreatePost(context),
          child: const Icon(Icons.add),
        ));
  }
}
