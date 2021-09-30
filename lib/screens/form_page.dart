import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendo/commonComponents/snackme.dart';
import 'package:vendo/enumerations/farmer_type.dart';
import 'package:vendo/enumerations/service_type.dart';
import 'package:vendo/firebase/bucket.dart';
import 'package:vendo/firebase/cloudstore.dart';
import 'package:provider/provider.dart';
import 'package:vendo/providers/mainProvider.dart';
import 'package:vendo/models/seller_model.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SellerProvider>(context, listen: false).sellerUniversal =
        SellerUniversal.fromDefault();
    final appTitle = 'Form';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              appTitle,
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  TextEditingController dateCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<bool> isSelected = [true, false, false, false, false];
  List<bool> isGenderSelected = [true, false, false];
  List<bool> isSpecialSelected = [false, true];
  List<bool> isHomeDeliverySelected = [true, false];
  List<bool> isLiveSelected = [true, false];
  List<bool> isFarmSelected = [true, false, false];

  service_type serviceType = service_type.Street_Vendor;

  List<String> imageUpload01 = [];
  List<String> imageUpload02 = [];
  List<String> imageUpload03 = [];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return SafeArea(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    ToggleButtons(
                        fillColor: Colors.redAccent.shade100,
                        selectedColor: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Street Vendor'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Household Worker'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Small Shopkeeper'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Farmer'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Technician'),
                          )
                        ],
                        onPressed: (int index) {
                          setState(() {
                            isSelected = [false, false, false, false, false];
                            serviceType = service_type.values.elementAt(index);
                            isSelected[serviceType.index] = true;
                          });
                          Provider.of<SellerProvider>(context, listen: false)
                              .sellerUniversal!
                              .serviceType = serviceType;
                        },
                        isSelected: isSelected),
                  ]),
                ),
                //       profile pic
                //       fullname
                //       date of birth
                //       phonenumber
                //       adharcard
                //       tags
                //       local name(if any)
                // timing
                // description optional
                // special disablity
                // gender
                // location
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .fullName = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Full name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .phoneNo = value;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      prefixText: '+91',
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.lightGreen)),
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .date = dateCtl.text;
                    },
                    controller: dateCtl,
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)))!;
                      dateCtl.text = DateFormat('dd-MM-yyyy').format(date);
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(fontSize: 22, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ToggleButtons(
                          fillColor: Colors.redAccent.shade100,
                          selectedColor: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Male'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Female'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Other'),
                            ),
                          ],
                          onPressed: (int index) {
                            Provider.of<SellerProvider>(context, listen: false)
                                .sellerUniversal!
                                .gender = index;
                            setState(() {
                              isGenderSelected = [false, false, false];
                              isGenderSelected[index] = true;
                            });
                          },
                          isSelected: isGenderSelected),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Specially abled',
                        style: TextStyle(fontSize: 22, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ToggleButtons(
                          fillColor: Colors.redAccent.shade100,
                          selectedColor: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('YES'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('NO'),
                            ),
                          ],
                          onPressed: (int index) {
                            Provider.of<SellerProvider>(context, listen: false)
                                .sellerUniversal!
                                .isSpeciallyAbled = index == 0 ? true : false;
                            setState(() {
                              isSpecialSelected = [false, false];
                              isSpecialSelected[index] = true;
                            });
                          },
                          isSelected: isSpecialSelected),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .aadharNumber = value;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.lightGreen)),
                      icon: const Icon(Icons.perm_identity),
                      hintText: 'Enter Aadhaar Card no.',
                      labelText: 'Aadhaar Card',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .localName = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.home_work),
                      hintText: 'Enter the local name of your shop/work',
                      labelText: 'Local Name (if any)',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .address = value;
                    },
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.location_on),
                      hintText: 'Enter location/address of your shop/work',
                      labelText: 'Location/Address',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .timing = value;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.access_time_rounded),
                      hintText: 'What are your timings?',
                      labelText: 'Timings',
                    ),
                  ),
                ),
                if (serviceType == service_type.Farmer)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ToggleButtons(
                            fillColor: Colors.redAccent.shade100,
                            selectedColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Dairy'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Farm Fresh Produce'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Honey'),
                              ),
                            ],
                            onPressed: (int index) {
                              Provider.of<SellerProvider>(context,
                                          listen: false)
                                      .sellerUniversal!
                                      .farmerType =
                                  farmer_type.values.elementAt(index);
                              setState(() {
                                isFarmSelected = [false, false, false];
                                isFarmSelected[index] = true;
                              });
                            },
                            isSelected: isFarmSelected),
                      ],
                    ),
                  ),
                if (isSelected[1] || isSelected[4])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .sellerUniversal!
                            .servicesProvided = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFFF3F5F5),
                        filled: true,
                        icon: const Icon(Icons.cleaning_services),
                        hintText: 'Enter the services provided by you',
                        labelText: 'Services/Type',
                      ),
                    ),
                  ),
                if (isSelected[1] || isSelected[4])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .sellerUniversal!
                            .charges = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFFF3F5F5),
                        filled: true,
                        icon: const Icon(Icons.attach_money_rounded),
                        hintText: 'What are your charges per day',
                        labelText: 'Charges',
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      Provider.of<SellerProvider>(context, listen: false)
                          .sellerUniversal!
                          .description = value;
                    },
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFFF3F5F5),
                      filled: true,
                      icon: const Icon(Icons.description),
                      hintText: 'Enter a brief description',
                      labelText: 'Description (optional)',
                    ),
                  ),
                ),
                if (isSelected[0] || isSelected[2])
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .sellerUniversal!
                            .shopName = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFFF3F5F5),
                        filled: true,
                        icon: Icon(Icons.shop_rounded),
                        hintText: (isSelected[0])
                            ? 'Enter street shop name'
                            : 'Enter shop name',
                        labelText:
                            (isSelected[0]) ? 'Street shop name' : 'Shop name',
                      ),
                    ),
                  ),
                if (isSelected[0] || isSelected[2])
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent.shade100)),
                            onPressed: () => buttonUpload(0),
                            child: Text(
                              (isSelected[0])
                                  ? "Upload Street shop photos (${imageUpload01.length})"
                                  : "Upload Shop photos (${imageUpload01.length})",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                if (isSelected[0] || isSelected[2] || isSelected[3])
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent.shade100)),
                            onPressed: () => buttonUpload(1),
                            child: Text(
                              "Upload Products List (${imageUpload02.length})",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                if (isSelected[0] || isSelected[3])
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent.shade100)),
                            onPressed: () => buttonUpload(2),
                            child: Text(
                              "Upload Product Photos (${imageUpload03.length})",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                if (isSelected[0])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<SellerProvider>(context, listen: false)
                            .sellerUniversal!
                            .packagingInfo = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFFF3F5F5),
                        filled: true,
                        icon: const Icon(Icons.shopping_basket_rounded),
                        hintText: 'How is your packaging done',
                        labelText: 'Packaging',
                      ),
                    ),
                  ),
                if (isSelected[0] || isSelected[2] || isSelected[3])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Home delivery available',
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ToggleButtons(
                            fillColor: Colors.redAccent.shade100,
                            selectedColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('YES'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('NO'),
                              ),
                            ],
                            onPressed: (int index) {
                              Provider.of<SellerProvider>(context,
                                          listen: false)
                                      .sellerUniversal!
                                      .isHomeDeliveryAvaliable =
                                  index == 0 ? true : false;
                              setState(() {
                                isHomeDeliverySelected = [false, false];
                                isHomeDeliverySelected[index] = true;
                              });
                            },
                            isSelected: isHomeDeliverySelected),
                      ],
                    ),
                  ),
                if (isSelected[0])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Enable Live Location',
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ToggleButtons(
                            fillColor: Colors.redAccent.shade100,
                            selectedColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('YES'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('NO'),
                              ),
                            ],
                            onPressed: (int index) {
                              Provider.of<SellerProvider>(context,
                                          listen: false)
                                      .sellerUniversal!
                                      .isHomeDeliveryAvaliable =
                                  index == 0 ? true : false;
                              setState(() {
                                isLiveSelected = [false, false];
                                isLiveSelected[index] = true;
                              });
                            },
                            isSelected: isLiveSelected),
                      ],
                    ),
                  ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: new TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen)),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      onPressed: buttonSubmit,
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void buttonUpload(int index) {
    showSnack(context, "Starting upload, this might take a while...");

    var f = uploadToBucket();
    f
        .then((value) => onSuccessUpload(index, value))
        .catchError((error) => showSnack(context, "An error occured: $error"));
  }

  void onSuccessUpload(int index, String? value) {
    if (value == null) return;
    setState(() {
      if (index == 0)
        imageUpload01.add(value);
      else if (index == 1)
        imageUpload02.add(value);
      else if (index == 2) imageUpload03.add(value);
    });
    showSnack(context, "Successfully Uploaded!");
  }

  void buttonSubmit() {
    // Seller seller = new Seller("sellerName", "email", "name", "phoneNumber", "profilePictureUrl", Timestamp.fromDate(DateTime.now()));
    showSnack(context, "Submitting form, Wait for results!");
    Provider.of<SellerProvider>(context, listen: false)
        .sellerUniversal!
        .shopPhotos = imageUpload01;
    Provider.of<SellerProvider>(context, listen: false)
        .sellerUniversal!
        .productListPhotos = imageUpload02;
    Provider.of<SellerProvider>(context, listen: false)
        .sellerUniversal!
        .productPhotos = imageUpload03;

    print(Provider.of<SellerProvider>(context, listen: false)
        .sellerUniversal!
        .toMap()
        .toString());
    var f = addSellerRecord(
        Provider.of<SellerProvider>(context, listen: false).sellerUniversal!);
    f
        .then((value) => showSnack(context, "Success!"))
        .catchError((error) => showSnack(context, "An error occured: $error"));
  }
}
