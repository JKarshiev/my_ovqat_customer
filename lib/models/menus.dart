
import 'package:cloud_firestore/cloud_firestore.dart';


// In this class all required data called from firestore as a json format
class Menus{
  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Menus({
   this.menuID,
    this.sellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
});

  Menus.fromJson(Map<String, dynamic> json){
    menuID = json["menuID"];
    sellerUID = json["sellerUID"];
    menuTitle = json["menuTitle"];
    menuInfo = json["menuInfo"];
    publishedDate = json["publishedDate"];
    thumbnailUrl = json["thumbnailUrl"];
    status = json["status"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"] = this.menuID;
    data["sellerUID"] = this.sellerUID;
    data["menuTitle"] = this.menuTitle;
    data["menuInfo"] = this.menuInfo;
    data["publishedDate"] = this.publishedDate;
    data["thumbnailUrl"] = this.thumbnailUrl;
    data["status"] = this.status;

    return data;
  }
}