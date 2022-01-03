import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/assistantMethods/cart_item_counter.dart';
import 'package:my_ovqat_customer/splashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'global/global.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
      ],
      child: MaterialApp(
        title: 'Customer Side',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(

        ),
      ),
    );
  }
}


