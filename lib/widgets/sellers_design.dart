import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/mainScreen/menus_screen.dart';
import 'package:my_ovqat_customer/models/sellers.dart';

// This widget receives Sellers model and builder context as a parameter and make it fit for user interface

class SellersDesignWidget extends StatefulWidget {

  Sellers? model;
  BuildContext? context;

  SellersDesignWidget({this.model, this.context});

  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MenusScreen(model: widget.model)));
      },
      splashColor: Colors.lightBlue,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.black26,
              ),
              Image.network(
                widget.model!.sellerAvatarUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2.0,),
              Text(
                widget.model!.sellerName!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Acme",
                ),
              ),
              Text(
                widget.model!.sellerEmail!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
