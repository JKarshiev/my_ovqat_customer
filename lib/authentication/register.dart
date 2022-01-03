import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:my_ovqat_customer/global/global.dart';
import 'package:my_ovqat_customer/mainScreen/home_screen.dart';
import 'package:my_ovqat_customer/widgets/custom_text_field.dart';
import 'package:my_ovqat_customer/widgets/error_dialog.dart';
import 'package:my_ovqat_customer/widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();


  String sellerImageUrl = "";


  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }



  Future<void> formValidation() async {
    if(imageXFile == null){
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog(
            message: "Please select a photo",
          );
        }
      );
    }
    else{
      if(passwordController.text == confirmPasswordController.text){

        if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty
            && nameController.text.isNotEmpty){
          // start uploading image to the firestore database
          showDialog(
            context: context,
            builder: (c){
              return LoadingDialog(
                message: "Signing Up",
              );
            }
          );
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("customers").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;

            //save info to the fireStore database
            authenticateAndSignUpSeller();
          });
        }
        else{
          showDialog(
              context: context,
              builder: (c){
                return ErrorDialog(
                  message: "PLease fill all the required blanks",
                );
              }
          );
        }
      }
      else{
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Password does not match",
              );
            }
        );
      }
    }
  }

  void authenticateAndSignUpSeller() async{
    User? currentUser;


    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });

    if(currentUser != null){
      saveDataToFirestore(currentUser!).then((value){
        Navigator.pop(context);
        // send the user to the homePage
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
   FirebaseFirestore.instance.collection("customers").doc(currentUser.uid).set({
     "uid": currentUser.uid,
     "email": currentUser.email,
     "name": nameController.text.trim(),
     "photoUrl": sellerImageUrl,
     "status": "approved",
     "userCart": ['garbage data'],

   });

   // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoURL", sellerImageUrl);
    await sharedPreferences!.setStringList("userCart", ['garbage data']);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
              child: imageXFile == null
                  ?
              Icon(
                Icons.add_photo_alternate,
                size: MediaQuery.of(context).size.width * 0.20,
                color: Colors.grey,
              ) : null
            ),
          ),
          SizedBox(height: 10,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  isObscure: false,
                ),
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
                CustomTextField(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "confirm password",
                  isObscure: true,
                ),

              ],
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            child: Text(
              'Sign Up',
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
    );
  }
}
