import 'package:flutter/material.dart';

class TextWidgetHeader extends SliverPersistentHeaderDelegate {

  String? title;

  TextWidgetHeader({this.title});


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return InkWell(
      child: Container(
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
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: InkWell(
          child: Text(
            title!,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Signatra",
              fontSize: 30,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
