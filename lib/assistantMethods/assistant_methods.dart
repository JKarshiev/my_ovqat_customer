import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_ovqat_customer/assistantMethods/cart_item_counter.dart';
import 'package:my_ovqat_customer/global/global.dart';
import 'package:provider/provider.dart';

separateItemIDs(){
  List<String> separateItemIDList = [], defaultItemList = [];
  int i = 0;
  // it gets cart lost from local database
  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++){
    // 56451245:7 item is in this format
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":"); //56451245:7 it gets position of :
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDList.add(getItemId);
  }

  print("\nThis is itemList now = " );
  print(separateItemIDList);
   return separateItemIDList;
}


addItemToCart(String? foodItemId, BuildContext context, int itemCounter){
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); // this add product to the cart as 56451245:7 format

  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,
  }).then((value) {

    Fluttertoast.showToast(msg: "Product added successfully.");

    sharedPreferences!.setStringList("userCart", tempList);

    // then the badge get updated
    Provider.of<CartItemCounter>(
        context,
        listen: false)
        .displayCartListItemsNumber();
  });
}