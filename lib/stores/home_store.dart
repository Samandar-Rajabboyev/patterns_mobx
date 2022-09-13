// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../model/post_model.dart';
import '../pages/create_or_update_post.dart';
import '../services/http_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  bool isLoading = false;

  @observable
  List<Post> items = [];

  Future apiPostList() async {
    isLoading = true;
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    return response != null;
  }

  Future<bool> apiPostCreate(Post post) async {
    isLoading = true;
    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    isLoading = false;
    return response != null;
  }

  Future<bool> apiPostUpdate(Post post) async {
    isLoading = true;
    var response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    isLoading = false;
    return response != null;
  }

  onCreatePost(BuildContext context) async {
    await openDialog(context, type: DialogType.create).then((post) {
      if (post != null) {
        apiPostCreate(post).then((value) {
          if (value) apiPostList();
        });
      }
    });
  }

  onUpdatePost(BuildContext context, Post post) async {
    await openDialog(context, type: DialogType.update, post: post).then((post) {
      if (post != null) {
        apiPostUpdate(post).then((value) {
          if (value) apiPostList();
        });
      }
    });
  }
}
