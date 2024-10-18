import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech/data/repositories/user/user_repositoris.dart';
import 'package:edtech/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../utils/validators/validation.dart';


class UserController extends GetxController {
  static UserController get instance => Get.find();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final addressController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final storeNameController = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetailes();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // final nameParts =
        //     UserModel.nameParts(userCredential.user!.displayName ?? '');
       
        final userName =
            UserModel.generateUserName(userCredential.user!.displayName ?? '');
        final user = UserModel(
          id: userCredential.user!.uid,
          address: '',
          status: 'waiting',
          storeName: '',
          // firstName: nameParts[0],
          // lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          userName: userName,
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
        );
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      KLoaders.warningSnackBar(
          title: "لم يتم حفظ البيانات",
          message:
              "حدث خطأ ما أثناء حفظ معلوماتك. يمكنك إعادة حفظ بياناتك في ملفك الشخصي.");
    }
  }

  updateAddressDialoge(context, String address) async {
    Future<List<String>> fetchGovernorates() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Constantes')
          .doc('Location')
          .collection('Location')
          .get();
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    }

    Future<List<String>> fetchSublocations(String governorate) async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Constantes')
          .doc('Location')
          .collection('Location')
          .where('name', isEqualTo: governorate)
          .get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      final doc = snapshot.docs.first;
      List<dynamic> sublocations = doc['list'];
      return sublocations.map((sublocation) => sublocation as String).toList();
    }

    String? selectedGovernorate;
    String? selectedSublocation;

    if (address.isNotEmpty) {
      List<String> parts = address.split('/');
      if (parts.length >= 3) {
        addressController.value.text = parts.skip(2).join('/');
      }
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('تغيير العنوان'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List<String>>(
                    future: fetchGovernorates(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return DropdownButtonFormField<String>(
                          value: selectedGovernorate,
                          items: snapshot.data!.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGovernorate = newValue;
                              selectedSublocation = null;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'اختر المحافظة',
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  (selectedGovernorate != null)
                      ? FutureBuilder<List<String>>(
                          future: fetchSublocations(selectedGovernorate!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return DropdownButtonFormField<String>(
                                value: selectedSublocation,
                                items: snapshot.data!.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedSublocation = newValue;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'اختر المنطقة',
                                ),
                              );
                            }
                          },
                        )
                      : const Text('اختر الحافظة للتمكن من اختيار المنطقة'),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: addressController.value,
                    validator: (value) =>
                        KValidator.validateEmptyText('العنوان', value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'أدخل عنوانا مفصلا',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('الغاء'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: const Text('حفظ'),
                  onPressed: () async {
                    // Save the text
                    final text =
                        "$selectedGovernorate/$selectedSublocation/${addressController.value.text}";

                    if (text.isNotEmpty &&
                        selectedGovernorate != null &&
                        selectedSublocation != null) {
                      user.update((val) {
                        val!.address = text;
                      });
                      await userRepository.updateSingleField({'Address': text});
                      Get.back();
                    } else {
                      KLoaders.warningSnackBar(
                          title: "لم يتم حفظ البيانات",
                          message:
                              " الرجاء اختيار المحافظة و المنطقة و ادخال العنوان بشكل صحيح");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  updateUserNameDialoge(context, String userName) {
    storeNameController.value.text = userName;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تغيير اسم المستخدم ',
          ),
          content: TextFormField(
            controller: storeNameController.value,
            validator: (value) =>
                KValidator.validateEmptyText('اسم المستخدم', value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'أدخل اسم المستخدم الجديد',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () async {
                // Save the text
                final text = storeNameController.value.text;

                if (text.isNotEmpty) {
                  user.update((val) {
                    val!.userName = text;
                  });
                  await userRepository.updateSingleField({'UserName': text});
                }
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  updateStoreNameDialoge(context, String storeName) {
    storeNameController.value.text = storeName;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تغيير اسم الماركت ',
          ),
          content: TextFormField(
            controller: storeNameController.value,
            validator: (value) =>
                KValidator.validateEmptyText('اسم الماركت', value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'أدخل اسم الماركت الجديد',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () async {
                // Save the text
                final text = storeNameController.value.text;

                if (text.isNotEmpty) {
                  user.update((val) {
                    val!.storeName = text;
                  });
                  await userRepository.updateSingleField({'StoreName': text});
                }
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  updatePhoneNumberDialoge(context, String phoneNumber) {
    phoneNumberController.value.text = phoneNumber;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تغيير رقم الهاتف',
          ),
          content: TextFormField(
            controller: phoneNumberController.value,
            keyboardType: TextInputType.number,
            validator: (value) => KValidator.validatePhoneNumber(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'أدخل رقم الهاتف ',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () async {
                final text = phoneNumberController.value.text;
                if (text.isNotEmpty &&
                    text.length == 11 &&
                    text.startsWith('01') &&
                    int.tryParse(text) != null) {
                  user.update((val) {
                    val!.phoneNumber = text;
                  });
                  await userRepository.updateSingleField({'PhoneNumber': text});
                  Get.back();
                } else {
                  KLoaders.warningSnackBar(
                      title: "لم يتم حفظ البيانات",
                      message: " الرجاء ادخال رقم هاتف صحيح");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
