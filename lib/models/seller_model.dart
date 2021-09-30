import 'package:vendo/enumerations/farmer_type.dart';
import 'package:vendo/enumerations/service_type.dart';

class SellerUniversal {
  String? uid;
  String? work;
  service_type? serviceType = service_type.Street_Vendor;
  String? fullName;
  String? phoneNo;
  String? date;
  int? gender = 0;
  bool? isSpeciallyAbled = false;
  String? aadharNumber;
  String? localName;
  String? address;
  String? timing;
  farmer_type? farmerType = farmer_type.DAIRY;
  String? servicesProvided;
  String? charges;
  String? description;
  String? shopName;
  List<String>? shopPhotos;
  List<String>? productListPhotos;
  List<String>? productPhotos;
  String? packagingInfo;
  bool? isHomeDeliveryAvaliable = true;
  bool? enableLiveLocation = true;

  SellerUniversal.fromDefault() {
    this.serviceType = service_type.Street_Vendor;
    this.gender = 0;
    this.isSpeciallyAbled = false;
    this.farmerType = farmer_type.DAIRY;
    this.isHomeDeliveryAvaliable = true;
    this.enableLiveLocation = true;
  }

  SellerUniversal({
    this.uid,
    this.work,
    this.serviceType,
    this.fullName,
    this.phoneNo,
    this.date,
    this.gender,
    this.isSpeciallyAbled,
    this.aadharNumber,
    this.localName,
    this.address,
    this.timing,
    this.farmerType,
    this.servicesProvided,
    this.charges,
    this.description,
    this.shopName,
    this.shopPhotos,
    this.productListPhotos,
    this.productPhotos,
    this.packagingInfo,
    this.isHomeDeliveryAvaliable,
    this.enableLiveLocation,
  });

  factory SellerUniversal.fromMap(Map<String, dynamic> parsedJson) {
    return SellerUniversal(
      uid: parsedJson['uid'],
      work: parsedJson['work'],
      serviceType: service_type.values.elementAt(parsedJson['serviceType']),
      fullName: parsedJson['fullName'],
      phoneNo: parsedJson['phoneNo'],
      date: parsedJson['date'] == null ? null : parsedJson['date'],
      gender: parsedJson['gender'],
      isSpeciallyAbled: parsedJson['isSpeciallyAbled'] == null
          ? false
          : parsedJson['isSpeciallyAbled'],
      aadharNumber: parsedJson['aadharNumber'],
      localName: parsedJson['localName'],
      address: parsedJson['address'],
      timing: parsedJson['timing'],
      farmerType: parsedJson['farmerType'] == null
          ? null
          : farmer_type.values.elementAt(parsedJson['farmerType']),
      servicesProvided: parsedJson['servicesProvided'],
      charges: parsedJson['charges'],
      description: parsedJson['description'],
      shopName: parsedJson['shopName'],
      shopPhotos:
          parsedJson['shopPhotos'] == null ? [] : parsedJson['shopPhotos'],
      productListPhotos: parsedJson['productListPhotos'] == null
          ? []
          : parsedJson['productListPhotos'],
      productPhotos: parsedJson['productPhotos'] == null
          ? []
          : parsedJson['productPhotos'],
      packagingInfo: parsedJson['packagingInfo'],
      isHomeDeliveryAvaliable: parsedJson['isHomeDeliveryAvaliable'] == null
          ? false
          : parsedJson['isHomeDeliveryAvaliable'],
      enableLiveLocation: parsedJson['enableLiveLocation'] == null
          ? false
          : parsedJson['enableLiveLocation'],
    );
  }

//  static List<SellerUniversal> listFromJson(List<dynamic> list) {
//   List<SellerUniversal> rows = list.map((i) => SellerUniversal.fromJson(i)).toList();
//   return rows;
//  }

//  static List<SellerUniversal> listFromString(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<SellerUniversal>((json) => SellerUniversal.fromJson(json)).toList();
//  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'work': work,
        'serviceType': serviceType?.index,
        'fullName': fullName,
        'phoneNo': phoneNo,
        'date': date,
        'gender': gender,
        'isSpeciallyAbled': isSpeciallyAbled,
        'aadharNumber': aadharNumber,
        'localName': localName,
        'address': address,
        'timing': timing,
        'farmerType': farmerType?.index,
        'servicesProvided': servicesProvided,
        'charges': charges,
        'description': description,
        'shopName': shopName,
        'shopPhotos': shopPhotos,
        'productListPhotos': productListPhotos,
        'productPhotos': productPhotos,
        'packagingInfo': packagingInfo,
        'isHomeDeliveryAvaliable': isHomeDeliveryAvaliable,
        'enableLiveLocation': enableLiveLocation,
      };
}
