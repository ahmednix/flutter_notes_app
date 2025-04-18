import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile_widgets/options_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var imagePicker = ImagePicker();
  File? selectedImage;

  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null && mounted) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 100,
                  child:
                      selectedImage != null
                          ? ClipOval(child: Image.file(fit: BoxFit.cover, selectedImage!, width: 200, height: 200) )
                          : Icon(Icons.person, size: 150),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => SizedBox(
                              height: 192,
                              child: Column(
                                children: [
                                  Text(
                                    'Profile',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Options(
                                        onPressed: () {
                                          imageSelector(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        text: "Camera",
                                        icon: Icons.camera_alt,
                                      ),
                                      Options(
                                        onPressed: () {
                                          imageSelector(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        text: "Gallery",
                                        icon: Icons.image,
                                      ),

                                      if (selectedImage != null)
                                        Options(
                                          onPressed: () {
                                            if (mounted) {
                                              setState(() {
                                                selectedImage = null;
                                              });

                                              Navigator.pop(context);
                                            }
                                          },
                                          text: "Delete",
                                          icon: Icons.delete,
                                          color: Colors.red,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.camera_alt, size: 32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
