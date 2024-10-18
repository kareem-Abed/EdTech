import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shimmer/shimmer.dart';
import 'package:edtech/common/widgets/appbar/primary_header_appbar.dart';

class ImageSelectionScreen extends StatelessWidget {
  final String ref;
  final TextEditingController textController;

  const ImageSelectionScreen({
    super.key,
    required this.ref,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageSelectionController());
    controller.getImages(ref);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const KPrimaryHeaderAppBar(
              title: 'الصور',
            ),
            Column(
              children: [
                const Text(' اختر صوره من قاعدة البيانات او قم ب اضافه لها '),
                const Text(' للحزف اضغط ب شكل مستمر علي الصوره '),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        File imageFile = await controller.getImageFile();
                        await controller.uploadImage(ref, imageFile);
                      },
                      child: const Text('اضافه صوره جديده'),
                    ),
                  ),
                ),
                Obx(
                  () {
                    if (controller.isloding.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.list.isEmpty) {
                      return const Column(
                        children: [
                          Text('لا يوجد صور في قاعدة البيانات حالياً'),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          GridView.builder(
                            itemCount: controller.list.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onLongPress: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('حذف الصورة'),
                                      content: const Text(
                                          'هل أنت متأكد أنك تريد حذف هذه الصورة؟'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('لا'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('نعم'),
                                          onPressed: () async {
                                            controller
                                                .deletImage(
                                                    ref, controller.list[index])
                                                .then((value) => Get.back());
                                            //   Get.back();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                onTap: () {
                                  textController.text = controller.list[index];
                                  Get.back();
                                },
                                child: CachedNetworkImage(
                                  imageUrl: controller.list[index],
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: SizedBox(
                                      height: 12,
                                      width: 100,
                                      child: Container(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 100,
                                    color: Colors.red,
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image(
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageSelectionController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  var uploadProgress = 0.0.obs;

  final RxList list = [].obs;
  RxBool isloding = false.obs;

  Future<void> getImages(String ref) async {
    isloding.value = true;
    ListResult result = await FirebaseStorage.instance.ref(ref).listAll();
    List<String> urls = [];
    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      urls.add(url);
    }
    list.value = urls;
    isloding.value = false;
  }

  Future<void> uploadImage(String path, File imageFile) async {
    try {
      showProgressDialog(Get.context!);
      String imageName = basename(imageFile.path);

      Task task = storage.ref('$path/$imageName').putFile(imageFile);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
      });

      await task.whenComplete(() {
        getImages(path);

        Get.back();
      });
    } catch (e) {
      // Handle any errors.
    }
  }

  Future<File> getImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw 'No image selected.';
    }
  }

  showProgressDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: uploadProgress.value),
                  const SizedBox(width: 30),
                  Text('${(uploadProgress.value * 100).toStringAsFixed(2)}%'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteImageAndShowDialog(
      context, String path, String imageUrl) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: deletImage(path, imageUrl),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 30),
                    Text('Please wait...'),
                  ],
                ),
              );
            } else {
              Get.back();
              if (snapshot.error != null) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('Image deleted successfully');
              }
            }
          },
        );
      },
    );
  }

  Future<void> deletImage(String path, String imageUrl) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(imageUrl)
          .delete()
          .then((value) {
        getImages(path);
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}
