import 'package:flutter/material.dart';

enum userTypeEnum { Freelancer, Investor }

class Login_card extends StatefulWidget {
  const Login_card({super.key});

  @override
  State<Login_card> createState() => _Login_cardState();
}

class _Login_cardState extends State<Login_card> {
  userTypeEnum? _userTypeEnum;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: <Widget>[
                Form(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text('Login'),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Type:"),
                    Expanded(
                      child: RadioListTile<userTypeEnum>(
                          value: userTypeEnum.Freelancer,
                          groupValue: _userTypeEnum,
                          title: Text(userTypeEnum.Freelancer.name),
                          onChanged: (val) {
                            setState(() {
                              _userTypeEnum = val;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile<userTypeEnum>(
                          value: userTypeEnum.Investor,
                          groupValue: _userTypeEnum,
                          title: Text(userTypeEnum.Investor.name),
                          onChanged: (val) {
                            setState(() {
                              _userTypeEnum = val;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(onPressed: () {}, child: Text("Login")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/registration");
                            },
                            child: Text("Registration")),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Forgot Password'),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
