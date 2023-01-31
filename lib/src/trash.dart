// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Complete_Profile extends StatefulWidget {
//   @override
//   _Complete_ProfileState createState() => _Complete_ProfileState();
// }

// class _Complete_ProfileState extends State<Complete_Profile> {
//   File? pickedFile;
//   ImagePicker imagePicker = ImagePicker();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? _name;
//   String? _surname;
//   int? _age;
//   String? _gender;
//   String? _choice;
//   String? _phoneNumber;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[50],
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Card(
//               margin: const EdgeInsets.all(24),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 80,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             child: InkWell(
//                               child: Icon(Icons.camera),
//                               onTap: () {
//                                 showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) => bottomSheet(context));
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Name',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _name = value!,
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Surname',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your surname';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _surname = value!,
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Age',
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your age';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _age = int.parse(value!),
//                       ),
//                       RadioListTile<String>(
//                         title: const Text('Male'),
//                         value: 'Male',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                       RadioListTile<String>(
//                         title: const Text('Female'),
//                         value: 'Female',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                       RadioListTile<String>(
//                         title: const Text('Other'),
//                         value: 'Other',
//                         groupValue: _gender,
//                         onChanged: (value) => setState(() => _gender = value!),
//                       ),
//                       RadioListTile<String>(
//                         title: const Text('Investor'),
//                         value: 'Investor',
//                         groupValue: _choice,
//                         onChanged: (value) => setState(() => _choice = value!),
//                       ),
//                       RadioListTile<String>(
//                         title: const Text('Freelancer'),
//                         value: 'Freelancer',
//                         groupValue: _choice,
//                         onChanged: (value) => setState(
//                           () => _choice = value!,
//                         ),
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _phoneNumber = value!,
//                       ),
//                       ElevatedButton(
//                         child: const Text('Submit'),
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _formKey.currentState!.save();
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget bottomSheet(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       width: double.infinity,
//       height: size.height * 0.3,
//       child: Column(
//         children: [
//           Text("Choose Profile Photo"),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.image),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("Gallery"),
//                   ],
//                 ),
//                 onTap: () {
//                   takePhoto(ImageSource.gallery);
//                 },
//               ),
//               SizedBox(
//                 width: 80,
//               ),
//               InkWell(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.camera),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("Camera"),
//                   ],
//                 ),
//                 onTap: () {
//                   takePhoto(ImageSource.camera);
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   void takePhoto(ImageSource source) async {
//     final pickedImage =
//         await imagePicker.pickImage(source: source, imageQuality: 100);

//     pickedFile = File(pickedImage!.path);
//     print(pickedFile);
//   }
// }
