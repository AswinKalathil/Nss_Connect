import 'package:flutter/material.dart';
import 'package:nss_connect/Secretary.dart';
import 'package:nss_connect/pageTrasitions.dart';
import 'package:nss_connect/poDashboard.dart';
import 'package:nss_connect/volunteer_dashboard.dart';
import 'package:nss_connect/widgetStyles.dart';
import 'models/dataModels.dart';
import 'register.dart';
import 'otpDialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nss_connect/widgetStyles.dart';

class credCard extends StatefulWidget {
  const credCard({super.key});

  @override
  State<credCard> createState() => _credCardState();
}

class _credCardState extends State<credCard> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedOption = 'volunteerDashboard';
  String? poString = 'poDashboard';
  String? volString = 'volunteerDashboard';
  String? secString = 'secretaryDashboard';
  Widget? nextRoute;
  void _submitData() {
    final enteredUsername = _userNameController.text;
    final enteredPassword = _passwordController.text;
    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      return;
    }
    print("Username: $enteredUsername\nPassword: $enteredPassword");

    bool isCredentialsValid = false;
    for (User user in UserData) {
      print("Database------\n");
      print(user.userName + " " + user.password);
      if (user.userName == enteredUsername &&
          user.password == enteredPassword) {
        isCredentialsValid = true;
        break;
      }
    }
    print(isCredentialsValid);
    if (isCredentialsValid) {
      // Credentials are valid, navigate to the appropriate dashboard
      if (_selectedOption == poString) {
        nextRoute = PoDashboardPage();
      } else if (_selectedOption == secString) {
        nextRoute = SecretaryDashboard();
      } else if (_selectedOption == volString) {
        nextRoute = VolunteerDashboardPage();
      }

      print("Username: $enteredUsername\nPassword: $enteredPassword");
      FocusScope.of(context).requestFocus(FocusNode());
      nextPageReplace(context, nextRoute as Widget);
    } else {
      // Credentials are invalid, display an error message or perform some action
      // e.g., show a snackbar or dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter valid username and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // height: MediaQuery.of(context).size.height *
      //     (_selectedOption == poString ? 0.72 : .65),
      width: MediaQuery.of(context).size.width * 8,
      child: Card(
        shape: CardShape(padding: 50),
        color: Colors.white,
        elevation: 10,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              'Login as',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nexa',
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
                buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                )),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    // color: Colors.black,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  elevation: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                alignment: AlignmentDirectional.centerStart,
                isExpanded: false,
                value: _selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'volunteerDashboard',
                    child: Text(
                      'Volunteer',
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'poDashboard',
                    child: Text('Program Officer'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'secretaryDashboard',
                    child: Text('Secretary'),
                  ),
                ]),
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.only(bottom: 10, left: 30),
            child: Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.grey
                    .withOpacity(0.3), // Change the border color here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _userNameController,
              onSubmitted: (_) {
                _submitData();
              },
              textInputAction: TextInputAction.next,
              style: TextStyle(),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Enter your username',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          PassInputBox(
            title: "Password",
              placeholder: "Enter new Password",
              textEditingController: _passwordController,
              submitFunction: () {
                _submitData();
              }
          ),
          SizedBox(
            height: 15,
          ),

          //forgot password container
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    otpPhone(context, 'ss');
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          //Register button
          LongButton(
              buttonText: 'Login',
              buttonAction: () {
                print('Pressed login');

                _submitData();
              }),
          if (_selectedOption == poString)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'or',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          if (_selectedOption == poString)
            LongButton(
                buttonText: 'Register Unit',
                buttonAction: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  nextPagePush(context, Register());

                  // Navigator.pushNamed(context, Register.id);
                })
        ]),
      ),
    );
  }
}
