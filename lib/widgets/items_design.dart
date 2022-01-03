import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/mainScreen/item_details_screen.dart';
import 'package:my_ovqat_customer/models/items.dart';


// This widget receives Sellers model and builder context as a parameter and make it fit for user interface

class ItemsDesignWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailScreen(model: widget.model)));
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
                widget.model!.thumbnailUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2.0,),
              Text(
                widget.model!.title!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Acme",
                ),
              ),
              Text(
                widget.model!.shortInfo!,
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