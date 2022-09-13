import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/post_model.dart';
import '../stores/home_store.dart';

Widget itemOfPost(HomeStore store, Post post) {
  return Slidable(
    enabled: true,
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          label: 'Update',
          backgroundColor: Colors.indigo,
          icon: Icons.edit,
          onPressed: (BuildContext context) {
            store.onUpdatePost(context, post);
          },
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (_) {
            store.apiPostDelete(post).then((value) {
              if (value) store.apiPostList();
            });
          },
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title?.toUpperCase() ?? "",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(post.body ?? ""),
        ],
      ),
    ),
  );
}
