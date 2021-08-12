import 'package:flutter/material.dart';
import './screens/after_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  var invaliduser=false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.black),),
                    SizedBox(height: 20,),
                    Text("Login to your account",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      inputFile(label: "Username",controller:myControllerEmail),
                      inputFile(label: "Password", obscureText: true,controller:myControllerPassword),
                      Visibility(
                        visible:invaliduser,
                        child: Text(
                          "Invalid Username or Password", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.red,
                        ),

                        ),)
                    ],
                  ),
                ),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
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
                    child:MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: getLoginData,
                          // onPressed: ()
                          // {
                          //   print(myControllerPassword.text);
                          //   print(myControllerEmail.text);
                          //   Navigator.push(
                          //     context,
                          //
                          //     MaterialPageRoute(builder: (context) => AfterLogin()),
                          //   );
                          // },
                          color: Color(0xFF5E544B),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: Text(
                            "Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,

                          ),
                          ),

                        ),



                    ),


                  ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    Text(" Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),)
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.png"),
                        fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }

  getLoginData()async{
   final String apiURL="https://ayushparihar1703.pythonanywhere.com/api/login/?format=json";
   print(myControllerEmail.text.split("@")[0]);

   try {
     dynamic data={
       "username":myControllerEmail.text.split("@")[0],
       "email":myControllerEmail.text,
       "password":myControllerPassword.text
     };
     var dio = Dio();
     var response = await dio.post(apiURL, data: data, options: Options(
         headers: {
           'Content-type': 'application/json;charset=UTF-8',
         }
     ));
       var res=response.data;
       SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setString('token', res['token']);
     await prefs.setString('username',myControllerEmail.text.split("@")[0] );
     setState(() {
       invaliduser=false;
     });
     print('valid user');
     myControllerEmail.clear();
     myControllerPassword.clear();
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) =>AfterLogin()),
     );

   }
   catch(e,stack){
     print(e);
     print('invalid user');
     setState(() {
       invaliduser=true;
     });
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
        controller: controller,
      ),
      SizedBox(height: 10,)
    ],
  );
}
