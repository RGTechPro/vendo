import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendo/commonComponents/snackme.dart';
import 'package:vendo/firebase/cloudstore.dart';
import 'package:vendo/models/model_user.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
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
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isGenderSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isGenderSelected[buttonIndex] = true;
                                } else {
                                  isGenderSelected[buttonIndex] = false;
                                }
                              }
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
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSpecialSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSpecialSelected[buttonIndex] = true;
                                } else {
                                  isSpecialSelected[buttonIndex] = false;
                                }
                              }
                            });
                          },
                          isSelected: isSpecialSelected),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                if (isSelected[3])
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
                              setState(() {
                                for (int buttonIndex = 0;
                                    buttonIndex < isFarmSelected.length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isFarmSelected[buttonIndex] = true;
                                  } else {
                                    isFarmSelected[buttonIndex] = false;
                                  }
                                }
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
                            onPressed: () {},
                            child: Text(
                              (isSelected[0])
                                  ? 'Upload Street shop photos'
                                  : 'Upload Shop photos',
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
                            onPressed: () {},
                            child: Text(
                              'Upload Products List',
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
                            onPressed: () {},
                            child: Text(
                              'Upload Product Photos',
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
                              setState(() {
                                for (int buttonIndex = 0;
                                    buttonIndex < isHomeDeliverySelected.length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isHomeDeliverySelected[buttonIndex] = true;
                                  } else {
                                    isHomeDeliverySelected[buttonIndex] = false;
                                  }
                                }
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
                              setState(() {
                                for (int buttonIndex = 0;
                                    buttonIndex < isLiveSelected.length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isLiveSelected[buttonIndex] = true;
                                  } else {
                                    isLiveSelected[buttonIndex] = false;
                                  }
                                }
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

  void buttonSubmit() {
    print("Submitting a form!");

    Seller seller = new Seller("sellerName", "email", "name", "phoneNumber", "profilePictureUrl", Timestamp.fromDate(DateTime.now()));

    showSnack(context, "Submitting form, Wait for results!");
    var f = addSellerRecord(seller);
    f.then((value) => showSnack(context, "Success!"))
    .catchError((error) => showSnack(context, "An error occured: $error"));
  }
}
