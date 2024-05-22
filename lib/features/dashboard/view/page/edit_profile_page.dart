import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_quran/core/utils/consts.dart';
import 'package:the_quran/features/auth/view/components/app_text_form_field.dart';
import 'package:the_quran/features/dashboard/view/components/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(
      text: Consts.auth.currentUser!.displayName.toString());

  File img = File(Consts.auth.currentUser!.photoURL.toString());
  bool network = true;
  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<File> getImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1500,
    );
    if (image != null) {
      network = false;

      return File(image.path);
    }
    network = true;
    return File(Consts.auth.currentUser!.photoURL.toString());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                      network: network,
                      imagePath: network
                          ? Image.network(
                              Consts.auth.currentUser!.photoURL.toString())
                          : Image.file(img),
                      isEdit: true,
                      onClicked: () async {
                        img = await getImage();

                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    AppTextFormField(
                      controller: nameController,
                      labelText: "Name",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            if (Consts.auth.currentUser!.photoURL!.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              if (File(Consts.auth.currentUser!.photoURL
                                      .toString()) !=
                                  img) {
                                Reference ref = FirebaseStorage.instance
                                    .ref()
                                    .child('User_Images')
                                    .child(Consts.auth.currentUser!.uid
                                        .toString());
                                await ref.putFile(img);
                                String imageURL = await ref.getDownloadURL();
                                await Consts.auth.currentUser!
                                    .updatePhotoURL(imageURL);
                              }
                              setState(() {
                                loading = false;
                              });
                            }
                            await Consts.auth.currentUser!
                                .updateDisplayName(nameController.text.trim());
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Success',
                              desc: "Updated successfully",
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } on FirebaseException catch (e) {
                            log(e.message.toString());
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: e.message,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      },
                      child: const Text('Done'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
      );
}
