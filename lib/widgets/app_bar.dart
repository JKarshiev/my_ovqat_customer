import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/assistantMethods/cart_item_counter.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatefulWidget with PreferredSizeWidget {

  final PreferredSizeWidget? bottom;

  MyAppBar({this.bottom});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height)
      :Size(56, 80 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              // this put two colors of appbar together
              colors: [
                Colors.grey,
                Colors.blue,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: Text(
        "My Ovqat",
        style: TextStyle(
          fontSize: 30,
          fontFamily: "Lobster",
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: (){
                // user will be sent to the cart screen
              },
            ),
            Positioned(
              child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                     child: Consumer<CartItemCounter>(
                       builder: (context, counter, c){
                         return Text(
                           counter.count.toString(),
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 12,
                           ),
                         );
                       }
                     ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
