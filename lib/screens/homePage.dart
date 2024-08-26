import 'package:api_exam/screens/favoritePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ProjectListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProjectListScreen extends StatelessWidget {
  final ShoppingController projectController = Get.put(ShoppingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.back, color: Colors.white,)),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
              }, icon: Icon(CupertinoIcons.cart_fill, color: Colors.white,)),
            ],
          ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Learn with pradeep', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
              Icon(CupertinoIcons.list_bullet, size: 35,),
              Icon(Icons.grid_view, size: 35,)
            ],
          ),
          Expanded(
            child: Obx(() {
              if (projectController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.6, // Adjust the aspect ratio as needed
                    ),
                    itemCount: projectController.projectList.length,
                    itemBuilder: (context, index) {
                      final project = projectController.projectList[index];
                      return Card(
                        child: Stack(
                          children : [ Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                child: Expanded(
                                  child: Image.network(
                                    project.imageLink,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  project.name,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 70,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Center(child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(project.rating.toString(), style: TextStyle(color: Colors.white),),
                                      Icon(Icons.star, color: Colors.white,)
                                    ],
                                  ),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('\$${project.price}', style: TextStyle(fontSize: 30),),
                              ),
                            ],
                          ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(60)
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      projectController.favoriteList.contains(project)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: projectController.favoriteList.contains(project)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      projectController.toggleFavorite(project);
                                    },
                                  ),
                                );
                              }
                              ),
                            ),
                        ]
                        ),
                      );
                    });
              }
            }
                ),
          ),
        ],
      ),
    );
  }

}
