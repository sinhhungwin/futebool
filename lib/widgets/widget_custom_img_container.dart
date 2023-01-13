import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomImageContainer extends StatefulWidget {
  final TabController tabController;

  const CustomImageContainer({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  bool imageLoaded = false;
  ImageProvider image = const NetworkImage(
      'https://vn112.com/wp-content/uploads/2018/01/pxsolidwhiteborderedsvg-15161310048lcp4.png');

  Future<void> uploadImage(XFile image) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? 'anonymous';

      await storage.ref('$email/${image.name}').putFile(File(image.path));
    } catch (_) {
      if (kDebugMode) {
        print(_.toString());
      }
    }
  }

  getImage(context) async {
    ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image was selected'),
        ),
      );
    } else {
      if (kDebugMode) {
        print('Uploading ...');
      }
      uploadImage(image);
      setState(() {
        imageLoaded = true;
        this.image = FileImage(
          File(image.path),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            left: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            bottom: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            right: BorderSide(color: Theme.of(context).primaryColor, width: 1),
          ),
        ),
        child: !imageLoaded
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => getImage(context),
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
