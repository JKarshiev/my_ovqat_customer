import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_ovqat_customer/global/global.dart';
import 'package:my_ovqat_customer/models/menus.dart';
import 'package:my_ovqat_customer/models/sellers.dart';
import 'package:my_ovqat_customer/widgets/customer_drawer.dart';
import 'package:my_ovqat_customer/widgets/menus_design.dart';
import 'package:my_ovqat_customer/widgets/sellers_design.dart';
import 'package:my_ovqat_customer/widgets/progress_bar.dart';
import 'package:my_ovqat_customer/widgets/text_widget_header.dart';



class MenusScreen extends StatefulWidget {

  final Sellers? model;

  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerDrawer(),
      appBar: AppBar(
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
        title: Text(
          "My Ovqat",
          style: TextStyle(
            fontSize: 45,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
              title: widget.model!.sellerName! + " Menus",
            ),),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot){
              return !snapshot.hasData
                  ?SliverToBoxAdapter(
                child: Center(
                  child: circularProgress(),
                ),
              ) :SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index){
                  Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>
                  );
                  return MenusDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}