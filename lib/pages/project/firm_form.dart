import 'dart:io';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:freelancer2capitalist/models/firm_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../../models/UIHelper.dart';

class FirmForm extends StatefulWidget {
  const FirmForm({super.key});

  @override
  State<FirmForm> createState() => _FirmFormState();
}

class _FirmFormState extends State<FirmForm> {
  final TextEditingController company_name = TextEditingController();
  final TextEditingController company_background = TextEditingController();
  final TextEditingController company_age = TextEditingController();
  final TextEditingController company_mission = TextEditingController();
  RangeValues _budgetRangeValues = const RangeValues(0, 10000);
  String dropdownValue = 'Select a field';
  XFile? _selectedImage;
  static FirmModel? firm = FirmModel();

  Future<String> _getDataUrl(XFile image) async {
    final bytes = await image.readAsBytes();
    return Uri.dataFromBytes(bytes, mimeType: 'image/jpeg').toString();
  }

  void checkValues() async {
    String name = company_name.text.trim();
    String background = company_background.text.trim();
    String age = company_age.text.trim();
    String field = dropdownValue.trim();
    String mission = company_mission.text.trim();

    if (name.isEmpty ||
        background.isEmpty ||
        age.isEmpty ||
        field.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields and select images'),
          backgroundColor: Colors.pinkAccent,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
      return;
    }

    uploadData(name, background, age, field, mission);
  }

  void uploadData(
    String name,
    String background,
    String age,
    String field,
    String mission,
  ) async {
    UIHelper.showLoadingDialog(context, "Updating Firm Information...");

    double budgetStart = _budgetRangeValues.start.roundToDouble();
    double budgetEnd = _budgetRangeValues.end.roundToDouble();
    String imageUrl = '';
    File selectedImage = File(_selectedImage!.path);
    String uid = uuid.v1();

    // Upload the images to Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid; // log(userId);
    Reference ref = storage.ref().child("firm_images/$uid.jpg");
    try {
      UploadTask uploadTask = ref.putFile(selectedImage);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      log(e.toString());
    }

    FirmModel firmModel = FirmModel(
      uid: userId,
      mission: mission,
      background: background,
      age: age,
      name: name,
      field: field,
      budgetStart: budgetStart,
      budgetEnd: budgetEnd,
      firmImage: imageUrl,
    );
    try {
      await FirebaseFirestore.instance
          .collection("firm")
          .doc(userId)
          .set(firmModel.toMap());
    } on FirebaseException catch (ex) {
      log(ex.toString());
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<FirmModel?> getFirm(String uid) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('firm').doc(uid).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return FirmModel.fromMap(data)..uid = uid;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getFirm(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        firm = value;
        if (firm != null) {
          company_name.text = firm!.name.toString();
          company_age.text = firm!.age.toString();
          company_background.text = firm!.background.toString();
          company_mission.text = firm!.mission.toString();
          _budgetRangeValues =
              RangeValues(firm!.budgetStart!, firm!.budgetEnd!);
          dropdownValue = firm!.field.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Firm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: null,
                controller: company_name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: null,
                controller: company_background,
                decoration: const InputDecoration(
                  labelText: 'Background',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: null,
                controller: company_mission,
                decoration: const InputDecoration(
                  labelText: 'Mission',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: null,
                controller: company_age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'How many years old is your Firm',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Select a field',
                  'Science',
                  'Technology',
                  'Engineering',
                  'Mathematics'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Your Budget'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u{20B9}${_budgetRangeValues.start.round()}',
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                  ),
                  Expanded(
                    child: RangeSlider(
                      values: _budgetRangeValues,
                      min: 0,
                      max: 10000,
                      divisions: 100,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Colors.black.withOpacity(0.5),
                      labels: RangeLabels(
                        '\u{20B9}${_budgetRangeValues.start.round().toString()}',
                        '\u{20B9}${_budgetRangeValues.end.round().toString()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _budgetRangeValues = values;
                        });
                      },
                    ),
                  ),
                  Text(
                    '\u{20B9}${_budgetRangeValues.end.round()}',
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  XFile? result = await ImagePicker().pickImage(
                    imageQuality: 30,
                    source: ImageSource.gallery,
                  );
                  if (result != null) {
                    setState(() {
                      _selectedImage = result;
                    });
                  } else {
                    const snackdemo = SnackBar(
                      content: Text('Please select an image'),
                      backgroundColor: Colors.pinkAccent,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                  }
                },
                child: const Text('Select Image'),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_selectedImage != null)
                kIsWeb
                    ? FutureBuilder<String>(
                        future: _getDataUrl(_selectedImage!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data!,
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // set width to screen width
                              height: MediaQuery.of(context).size.height /
                                  2, // set height to half of screen height
                              fit: BoxFit
                                  .contain, // set fit to contain, which will resize the image to fit within the frame
                            );
                          } else {
                            return const Placeholder();
                          }
                        },
                      )
                    : Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  checkValues();
                  // UIHelper.showAlertDialog(context,
                  //     'Submitting Firm Information', "Work in progress");
                }, //checkValues(),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
