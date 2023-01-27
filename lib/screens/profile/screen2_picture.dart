import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums/view_state.dart';
import '../../scoped_models/models.dart';
import '../../widgets/widgets.dart';
import '../base_screen.dart';

class ProfilePic extends StatelessWidget {
  static const String routeName = '/profile-picture';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfilePic(),
    );
  }

  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<ProfileModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) {
          switch (model.state) {
            case ViewState.busy:
              return const Scaffold(
                appBar: CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ViewState.retrieved:
              return Scaffold(
                appBar: const CustomAppBar(
                  title: 'Futebol',
                  hasActions: false,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Team pics
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextHeader(text: "Add Pictures"),
                            const SizedBox(
                              height: 20,
                            ),

                            // Minimum 2 pics, Maximum 6 pics
                            // 3 pics each row
                            // First row of pics
                            SizedBox(
                              height: 300,
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: [
                                  for (var item in model.imgUrls)
                                    CustomImageContainer()
                                ],
                              ),
                            ),
                          ],
                        ),

                        // To next onboarding screen
                        Column(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              title: 'UPDATE',
                              // TODO: Update pics
                              // onPressed: () => model.,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case ViewState.error:

            default:
              return const Scaffold();
          }
        });
  }
}

class CustomImageContainer extends StatefulWidget {
  const CustomImageContainer({Key? key}) : super(key: key);

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  bool imageLoaded = false;
  bool imageLoading = false;

  ImageProvider image = const NetworkImage(
      'https://vn112.com/wp-content/uploads/2018/01/pxsolidwhiteborderedsvg-15161310048lcp4.png');

  Future<void> uploadImage(XFile image) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? 'anonymous';

      await storage.ref('$email/${image.name}').putFile(File(image.path));
    } catch (_) {
      debugPrint(_.toString());
    }
  }

  Future<String> getDownloadURL(String imgName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('email') ?? 'anonymous';

    String downloadURL = await storage.ref('$email/$imgName').getDownloadURL();

    return downloadURL;
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
      debugPrint('Uploading ...');

      setState(() {
        imageLoading = true;
      });

      await uploadImage(image);

      setState(() {
        imageLoading = false;
      });

      setState(() {
        imageLoaded = true;
        this.image = FileImage(
          File(image.path),
        );
      });

      final prefs = await SharedPreferences.getInstance();
      List<String> imageUrls = prefs.getStringList('imageUrls') ?? [];

      imageUrls.add(
        await getDownloadURL(image.name),
      );

      prefs.setStringList('imageUrls', imageUrls);

      debugPrint('ImageUrls: $imageUrls');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    if (!imageLoaded && !imageLoading) {
      child = Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          onPressed: () => getImage(context),
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    } else if (!imageLoaded && imageLoading) {
      child = const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFE84545),
        ),
      );
    } else {
      child = Container();
    }

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
        child: child,
      ),
    );
  }
}
