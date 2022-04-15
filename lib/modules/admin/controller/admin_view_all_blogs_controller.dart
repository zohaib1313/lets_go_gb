import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';

class AdminViewAllBlogsController extends GetxController {
  var temp = true.obs;

  TextEditingController searchController = TextEditingController();

  RxList<BlogModel> filteredItemList = <BlogModel>[].obs;
  final List<BlogModel> allItemList = [];
}
