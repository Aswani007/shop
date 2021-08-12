import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './screens/after_login.dart';
import './login.dart';
class SignupPage extends StatefulWidget {



  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerCPassword = TextEditingController();
  final myControllerUserName = TextEditingController();
  var passwordNotMatch=false;
  var invalidfields=false;
  var success=false;

  @override
  void dispose() {
    // TODO: implement dispose
    myControllerPassword.dispose();
    myControllerCPassword.dispose();
    myControllerEmail.dispose();
    myControllerUserName.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFD6D2C4),
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xFFD6D2C4),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
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
                  Text("Sign up",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                    ),),
                  SizedBox(height: 20,),
                  Text("Create an account, It's free ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)


                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Username",controller: myControllerUserName),
                  inputFile(label: "Email",controller: myControllerEmail),
                  inputFile(label: "Password", obscureText: true,controller: myControllerPassword),
                  inputFile(label: "Confirm Password ", obscureText: true,controller: myControllerCPassword),
                  Visibility(
                    visible:passwordNotMatch,
                    child: Text(
                      "Password and Confirm Password are Not Matching", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.red,
                    ),

                    ),),
                  Visibility(
                    visible:invalidfields,
                    child: Text(
                      "Invalid Fields,provide proper fields", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.red,
                    ),

                    ),),
                  Visibility(
                    visible:success,
                    child: Text(
                      "Registered successfully", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.green,
                    ),

                    ),)
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),



                    )

                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: postSignupData,
                  color: Color(0xFF5E544B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,

                  ),
                  ),

                ),



              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?",style: TextStyle(color: Colors.black),),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <InlineSpan>[

                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>LoginPage()));
                          },
                          text: 'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[500],
                              fontSize: 18
                          ) ),
                    ]),
                  ),

                ],
              )



            ],

          ),


        ),

      ),

    );
  }

  postSignupData()async{
    final String apiURL="https://ayushparihar1703.pythonanywhere.com/api/register/?format=json";
    print("password:"+myControllerPassword.text);
    print("conpassword:"+myControllerCPassword.text);
    print("email:"+myControllerEmail.text);
    print("username:"+myControllerUserName.text);

      try {

        if(myControllerPassword.text!=myControllerCPassword.text) {
          setState(() {
            invalidfields=false;
            passwordNotMatch=true;
          });
          print('through pssword');
          throw FormatException('passwords are different');
        }
        dynamic data = {
          "username": myControllerUserName.text,
          "email": myControllerEmail.text,
          "password": myControllerPassword.text,
        };
        var dio = Dio();
        var response = await dio.post(apiURL, data: data, options: Options(
            headers: {
              'Content-type': 'application/json;charset=UTF-8',
            }
        ));
        var res = response.data;
        print(res);
        setState(() {
          passwordNotMatch = false;
          invalidfields=false;
          success=true;
        });
        myControllerUserName.clear();
        myControllerEmail.clear();
        myControllerCPassword.clear();
        myControllerPassword.clear();
        print('valid details');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>AfterLogin()),
        // );

      }on FormatException{
        print("caught pssword exception");
      }
      catch (e) {
        print(e);
        setState(() {
          passwordNotMatch=false;
          invalidfields=true;
        });

        print('invalid details');
      }


  }
}






// we will be creating a widget for text field
Widget inputFile({label, obscureText = false,controller})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0,
                horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (Colors.grey[400])
              ),

            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: (Colors.grey[400]))
            )
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}
