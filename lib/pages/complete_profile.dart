import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/profile_page.dart';
import 'package:freelancer2capitalist/pages/widgets/genderRadio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/UIHelper.dart';
import '../models/user_model.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? selected_gender;
  String? selected_userType;

  @override
  void initState() {
    super.initState();
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload profile picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo_album),
                title: const Text("Select from gallery"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera),
                title: const Text("Take a photo"),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> fetchImage(String imageUrl) async {
  //   // Get reference to the Firebase storage file
  //   final ref = FirebaseStorage.instance.ref().child(imageUrl);
  //   // Download the image and store it in a temporary file
  //   final bytes = await ref.getData();
  //   final tempFile = File('${(await getTemporaryDirectory()).path}/image.jpg');
  //   await tempFile.writeAsBytes(bytes!);
  //   setState(() {
  //     // Assign the temporary file to the _imageFile variable
  //     imageFile = tempFile;
  //   });
  // }

  void checkValues() async {
    String fullName = fullNameController.text.trim();
    String bio = bioController.text.trim();
    String? gender = selected_gender;
    String? userType = selected_userType;
    // if (widget.userModel.profilepic != '') {
    //   fetchImage(widget.userModel.profilepic.toString());
    // }
    log(imageFile.toString());
    if (fullName.isEmpty ||
        // imageFile == null ||
        gender == null ||
        userType == null) {
      const snackdemo = SnackBar(
        content: Text('Please fill all the fields'),
        backgroundColor: Colors.pinkAccent,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      log("Please fill all the fields");
    } else {
      uploadData(fullName, bio, gender, userType);
    }
  }

  void uploadData(
      String fullName, String bio, String gender, String userType) async {
    UIHelper.showLoadingDialog(context, "Registering...");
    String imageUrl = '';
    if (imageFile != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(widget.userModel.uid.toString())
          .putFile(imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    widget.userModel.fullname = fullName;
    widget.userModel.profilepic =
        (widget.userModel.profilepic != '' && imageFile == null)
            ? widget.userModel.profilepic.toString()
            : imageUrl;
    widget.userModel.gender = gender;
    widget.userModel.userType = userType;
    widget.userModel.bio = bio;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      log("Data uploaded");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProfilePage(
          usermodel: widget.userModel,
          firebaseUser: widget.firebaseUser,
        );
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userModel.fullname != "") {
      fullNameController.text = widget.userModel.fullname.toString();
    }
    if (widget.userModel.bio != "") {
      bioController.text = widget.userModel.bio.toString();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Complete Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: (imageFile != null)
                      ? FileImage(imageFile!)
                      : (widget.userModel.profilepic != "")
                          ? NetworkImage(widget.userModel.profilepic.toString())
                          : null as ImageProvider<Object>?,
                  child:
                      (imageFile == null && widget.userModel.profilepic == "")
                          ? const Icon(
                              Icons.person,
                              size: 60,
                            )
                          : null,
                ),
                onPressed: () {
                  showPhotoOptions();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gender",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenderRadioGroup(
                defaultValue: widget.userModel.gender != ''
                    ? widget.userModel.gender.toString()
                    : null,
                value1: "Male",
                value2: "Female",
                onChanged: (value) {
                  setState(() {
                    selected_gender = value;
                  });
                },
              ),
              // Row(
              //   children: [
              //     Radio(
              //       value: 'male',
              //       groupValue: selected_gender,
              //       onChanged: (value) async {
              //         setState(() {
              //           selected_gender = widget.userModel.gender != ""
              //               ? widget.userModel.gender.toString()
              //               : value;
              //         });
              //       },
              //     ),
              //     const Text("Male"),
              //     Radio(
              //       value: 'female',
              //       groupValue: selected_gender,
              //       onChanged: (value) async {
              //         setState(() {
              //           selected_gender = widget.userModel.gender != ""
              //               ? widget.userModel.gender.toString()
              //               : value;
              //         });
              //       },
              //     ),
              //     const Text("Female"),
              //     // Radio(
              //     //   value: Gender.other,
              //     //   groupValue: gender,
              //     //   onChanged: (Gender? value) async {
              //     //     setState(() {
              //     //       gender = value;
              //     //     });
              //     //   },
              //     // ),
              //     // const Text("Other"),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "User Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenderRadioGroup(
                value1: "Investor",
                value2: "Freelancer",
                defaultValue: widget.userModel.userType != ''
                    ? widget.userModel.userType.toString()
                    : null,
                onChanged: (value) {
                  setState(() {
                    selected_userType = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: "Bio",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: const Text("Submit"),
                onPressed: () {
                  checkValues();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
