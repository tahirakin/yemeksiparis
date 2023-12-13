import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemUiOverlayStyle
import 'package:yemeksiparis/animation/FadeAnimation.dart';
import 'package:yemeksiparis/models/ApiError.dart';
import 'package:yemeksiparis/models/ApiRespose.dart';
import 'package:yemeksiparis/services/UserServices.dart';
import 'package:yemeksiparis/views/Restaurant/AdminDashboard.dart';
import 'package:yemeksiparis/widgets/msgToast.dart';

class SignupPage extends StatelessWidget {
  TextEditingController cusername = TextEditingController();
  TextEditingController cname = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1.2,
                    makeInput(
                      label: "Username",
                      controller_val: cusername,
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    makeInput(
                      label: "Name",
                      controller_val: cname,
                    ),
                  ),
                  FadeAnimation(
                      1.3,
                      makeInput(
                          label: "Password",
                          controller_val: cpassword,
                          obscureText: true)),
                  FadeAnimation(
                    1.4,
                    makeInput(
                      label: "Confirm Password",
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              FadeAnimation(
                  1.5,
                  Container(
                    padding: EdgeInsets.only(top: 1, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black), // Change here
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        handleSignup(context);
                      },
                      color: Colors.greenAccent ?? Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )),
              FadeAnimation(
                  1.6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, controller_val, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller_val,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey), // Change here
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey), // Change here
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void handleSignup(BuildContext context) async {
    UserServices userServices = UserServices();
    ApiResponse _apiResponse = await userServices.signup(
      cusername.text,
      cname.text,
      cpassword.text,
    );

    print(_apiResponse.apiError);
    if (_apiResponse.apiError == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        ModalRoute.withName('/login'),
      );
    } else {
      msgToast("Signup Failed!");
    }
  }
}
