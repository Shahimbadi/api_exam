import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class FavoritesPage extends StatelessWidget {
  final ShoppingController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Projects')),
      body: Obx(() {
        if (projectController.favoriteList.isEmpty) {
          return Center(child: Text('No favorites added.'));
        } else {
          return ListView.builder(
            itemCount: projectController.favoriteList.length,
            itemBuilder: (context, index) {
              final project = projectController.favoriteList[index];
              return ListTile(
                leading: Image.network(project.imageLink),
                title: Text(project.name),
                subtitle: Text('\$${project.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    projectController.removeFavorite(project);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
