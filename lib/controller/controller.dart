import 'package:get/get.dart';

import '../model/model.dart';
import '../service/service.dart';


class ShoppingController extends GetxController {
  var projectList = <Shopping>[].obs;
  var favoriteList = <Shopping>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProjects();
    super.onInit();
  }

  void fetchProjects() async {
    try {
      isLoading(true);
      var projects = await ShoppingService.fetchProjects();
      if (projects != null) {
        projectList.assignAll(projects);
      }
    } finally {
      isLoading(false);
    }
  }

  void toggleFavorite(Shopping project) {
    if (favoriteList.contains(project)) {
      favoriteList.remove(project);
    } else {
      favoriteList.add(project);
    }
  }

  void removeFavorite(Shopping project) {
    favoriteList.remove(project);
  }

}
