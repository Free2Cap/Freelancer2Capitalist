import 'package:flutter/material.dart';

enum UserTypeEnum { Freelancer, Investor }

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    UserTypeEnum? _UserTypeEnum;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
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
                          const Text("Registration"),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your Name",
                              labelText: "Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your Surname",
                              labelText: "Surname",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Enter your Email",
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Select a Password",
                              labelText: "Password",
                              prefixIcon: Icon(Icons.password),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Re-Type your Password",
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.password),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text("Type:"),
                              Expanded(
                                child: RadioListTile<UserTypeEnum>(
                                    value: UserTypeEnum.Freelancer,
                                    groupValue: _UserTypeEnum,
                                    title: Text(UserTypeEnum.Freelancer.name),
                                    onChanged: (val) {
                                      setState(() {
                                        _UserTypeEnum = val;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile<UserTypeEnum>(
                                    value: UserTypeEnum.Investor,
                                    groupValue: _UserTypeEnum,
                                    title: Text(UserTypeEnum.Investor.name),
                                    onChanged: (val) {
                                      setState(() {
                                        _UserTypeEnum = val;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Register'),
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  const Text("Already Have an Account?"),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Login'),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
