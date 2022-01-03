import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/global/global.dart';
import 'package:my_ovqat_customer/mainScreen/home_screen.dart';
import 'package:my_ovqat_customer/widgets/custom_text_field.dart';
import 'package:my_ovqat_customer/widgets/error_dialog.dart';
import 'package:my_ovqat_customer/widgets/loading_dialog.dart';

import 'auth_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      // user will sign in
      loginNow();
    }
    else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(message:
            "Please, fill the email or password",
            );
          }
      );
    }
  }
  loginNow() async{
    showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(message:
          "Checking",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(message:
            error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null){


      // if the user is exist then it will set the data from fireBase to sharedPreferences
      // and takes the page to the home Screen
      readAndSetDataLocally(currentUser!);
    }
  }
  Future readAndSetDataLocally(User currentUser) async{
  // it will read the data from fireBase and set it to the sharedPreferences in order to access locally
  await FirebaseFirestore.instance.collection("customers")
      .doc(currentUser.uid)
      .get().then((snapshot) async{
        if(snapshot.exists){
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["name"]);
          await sharedPreferences!.setString("photoURL", snapshot.data()!["photoUrl"]);

          List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
          await sharedPreferences!.setStringList("userCart", userCartList);

          // progress bar will disappear
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
        }
        else{
          firebaseAuth.signOut();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));

          showDialog(
              context: context,
              builder: (c){
                return ErrorDialog(message:
                "User record is not found",
                );
              }
          );
        }

        });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                  "images/login.png",
                  height: 270,),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "e-mail",
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "password",
                  isObscure: true,
                ),
                ElevatedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  ),
                  onPressed: (){
                    formValidation();
                  },
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
