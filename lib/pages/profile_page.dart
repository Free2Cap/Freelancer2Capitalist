import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/chat_pages/chat_user_card.dart';
import 'package:freelancer2capitalist/pages/complete_profile.dart';
import 'package:freelancer2capitalist/pages/login_page.dart';
import 'package:freelancer2capitalist/pages/project/firm_inforamtion.dart';
import 'package:freelancer2capitalist/pages/project/project_list.dart';
import 'package:freelancer2capitalist/pages/widgets/header_widget.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  final UserModel usermodel;
  final User firebaseUser;
  const ProfilePage(
      {super.key, required this.usermodel, required this.firebaseUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _profilePicController = TextEditingController();
  final _userTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values of the controllers
    _nameController.text = widget.usermodel.fullname!;
    _emailController.text = widget.usermodel.email!;
    _bioController.text = widget.usermodel.bio!;
    _profilePicController.text = widget.usermodel.profilepic!;
    _userTypeController.text = widget.usermodel.userType!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Free2Cap",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.screen_lock_landscape_rounded,
              //     size: _drawerIconSize,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Splash Screen',
              //     style: TextStyle(
              //         fontSize: 17,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 SplashScreen(title: "Splash Screen")));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.login_rounded,
              //       size: _drawerIconSize,
              //       color: Theme.of(context).colorScheme.secondary),
              //   title: Text(
              //     'Login Page',
              //     style: TextStyle(
              //         fontSize: _drawerFontSize,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()),
              //     );
              //   },
              // ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              // ListTile(
              //   leading: Icon(Icons.person_add_alt_1,
              //       size: _drawerIconSize,
              //       color: Theme.of(context).colorScheme.secondary),
              //   title: Text(
              //     'Registration Page',
              //     style: TextStyle(
              //         fontSize: _drawerFontSize,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const RegistrationPage()),
              //     );
              //   },
              // ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.password_rounded,
              //     size: _drawerIconSize,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Forgot Password Page',
              //     style: TextStyle(
              //         fontSize: _drawerFontSize,
              //         color: Theme.of(context).colorScheme.secondary),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const ForgotPasswordPage()),
              //     );
              //   },
              // ),
              // Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              ListTile(
                leading: Icon(
                  Icons.chat,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Chat Panel',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatUserCard(
                              userModel: widget.usermodel,
                              firebaseUser: widget.firebaseUser,
                            )),
                    //const ForgotPasswordVerificationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () async {
                  // await GoogleSignIn().disconnect();
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 40,
                        child: _profilePicController.text != ''
                            ? FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: _profilePicController.text.toString(),
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey.shade300,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _nameController.text.toString(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _userTypeController.text.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        // const ListTile(
                                        //   contentPadding:
                                        //       EdgeInsets.symmetric(
                                        //           horizontal: 12, vertical: 4),
                                        //   leading:
                                        //       Icon(Icons.my_location),
                                        //   title: Text("Location"),
                                        //   subtitle: Text(''),
                                        // ),
                                        ListTile(
                                          leading: const Icon(Icons.email),
                                          title: const Text("Email"),
                                          subtitle: Text(
                                              _emailController.text.toString()),
                                        ),
                                        // const ListTile(
                                        //   leading: Icon(Icons.phone),
                                        //   title: Text("Phone"),
                                        //   subtitle: Text("9104601838"),
                                        // ),
                                        ListTile(
                                          leading: const Icon(Icons.person),
                                          title: const Text("About Me"),
                                          subtitle: Text(
                                              _bioController.text.toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                child: Text(
                                    widget.usermodel.userType.toString() ==
                                            "Freelancer"
                                        ? "Project List"
                                        : "Firm Information"),
                                onPressed: () {
                                  widget.usermodel.userType.toString() ==
                                          "Freelancer"
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProjectList()))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FirmInformation()));
                                }),
                            ElevatedButton(
                                child: const Text("Edit Profile"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompleteProfile(
                                                firebaseUser:
                                                    widget.firebaseUser,
                                                userModel: widget.usermodel,
                                              )));
                                })
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
