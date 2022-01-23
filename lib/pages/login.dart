import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_est/pages/user_main.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  }



  class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  var email = " ";
  var password = " ";



  final emailController = TextEditingController();
  final passwordController= TextEditingController();

  userLogin() async{
    try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain()));
    }on FirebaseAuthException catch(error){
      if (error.code == 'user-not-found'){
        print('no User was found for that email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey ,
          content: Text('no User was found for that email',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),
          ),
        ),);
      }
      else if (error.code == 'wrong-password'){
        print ('wrong password provided by the user');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey ,
          content: Text('wrong password provided by the user',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),
          ),
        ),);
      }
      
    }

  }

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: ListView(
              children: [
                Padding(padding: const EdgeInsets.all(8.0),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: "Email",
                          labelStyle : TextStyle(fontSize: 20.0),
                        border : OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26,
                      fontSize: 15,),
                    ),
                    controller: emailController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'please enter email';
                      }
                      else if (!value.contains('@')){
                        return "please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle : TextStyle(fontSize: 20.0),
                      border : OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26,
                        fontSize: 15,),
                    ),
                    controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'please enter Password';
                      }

                      return null;
                    },

                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){},
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 10.0),
                          ),
                      ),
                      
                      TextButton(onPressed: (){},

                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(fontSize: 12.0),
                          ),

                      ),
                    ],
                  )
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have an account'),
                      TextButton(onPressed: (){},
                          child: Text(
                            'Signup'
                          ))
                    ],
                  ),


                ),
              ],
            ) ,

          ),
      ),

    );
  }
}
