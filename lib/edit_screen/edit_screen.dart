import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../home_screen/home_page/home_page.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  var imagePicker = ImagePicker();
  List<File>? selectedImages = [];

  Future<void> imageSelector() async {
    List<XFile>? images = await imagePicker.pickMultiImage();

    if (mounted) {
      setState(() {
        selectedImages!.addAll(
          images.map((image) => File(image.path)).toList(),
        );
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 16),

            selectedImages!.isEmpty
                ? Container(
                  color: Colors.white30,
                  height: 150,
                  width: MediaQuery.sizeOf(context).width - 20,
                  child: IconButton(
                    onPressed: () {
                      imageSelector();
                    },
                    icon: Icon(Icons.image),
                  ),
                )
                : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white30,
                        height: 100,
                        width: 100,
                        child: IconButton(
                          onPressed: () {
                            imageSelector();
                          },
                          icon: Icon(Icons.image),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width - 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            selectedImages!
                                .map(
                                  (image) => Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Image.file(
                                          image,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedImages!.removeAt(
                                              selectedImages!.indexOf(image),
                                            );
                                          });
                                        },
                                        icon: Icon(Icons.cancel),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: bodyController,
                minLines: 6,
                maxLines: 12,
                decoration: InputDecoration(
                  hintText: 'Body',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
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
            MaterialPageRoute(
              builder:
                  (context) => MyHomePage(
                    title: titleController.text,
                    body: bodyController.text,
                    images: selectedImages,
                  ),
            ),
          );
        },
        child: Icon(Icons.save, color: Colors.green),
      ),
    );
  }
}
