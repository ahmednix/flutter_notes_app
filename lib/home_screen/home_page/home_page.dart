import 'dart:io';

import 'package:flutter/material.dart';

import '../../edit_screen/edit_screen.dart';
import '../../profile/profile_screen/profile_screen.dart';
import '../home_widgets/home_widgets.dart';

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  final List<File>? images;

  const MyHomePage({this.title, this.body, this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.account_box),
          ),
        ],
        title: Text(title ?? "Trees"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            images == null || images!.isEmpty ? Image.asset('assets/images/tree.jpg') : Image.file(images![0], fit: BoxFit.cover, width: double.infinity),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                FavoriteWidget(),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                body ??
                    "Trees are vital components of our ecosystem, providing oxygen, improving air quality, conserving water, preserving soil, and supporting wildlife. With their towering trunks and spreading canopies, trees serve as homes to countless species and act as natural air filters by absorbing pollutants. They help regulate the climate by storing carbon dioxide and offering shade that cools urban areas. Beyond their environmental benefits, trees also add beauty to landscapes, offer a sense of tranquility, and hold cultural and historical significance across many societies. Their presence reminds us of nature’s resilience and the importance of preserving green spaces.",
              ),
            ),

            images == null || images!.isEmpty
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SeasonWidget(
                      imagePath: "assets/images/tree_fall.jpg",
                      imageText: "Fall",
                    ),
                    SeasonWidget(
                      imagePath: "assets/images/tree_spring.jpg",
                      imageText: "Spring",
                    ),
                  ],
                )
                : SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: images!.length,
                    itemBuilder: (context, index) => Image.file(images![index], height: 200, width: 200),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
