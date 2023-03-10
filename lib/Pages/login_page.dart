import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../widgets/header_widget.dart';
import '../widgets/roundbutton.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  String Message = "";
  bool isLoadding = false;
  final _formKey = GlobalKey<FormState>();
  final _box = GetStorage();

  TextEditingController folioController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  signIn(String folno, String cnic) async {
    setState(() {
      isLoadding = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse('http://194.116.228.5:130/Api/Login/GetById?folno=' +
            folno +
            '&cnic=' +
            cnic));
    request.body = json.encode({"folno": "$folno", "cnic": "$cnic"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await _box.write('cnic', cnic);
      await _box.write('folio', folno);
      await Get.offAllNamed(MyRoutes.homeRout);
      // await Navigator.pushReplacementNamed(context, MyRoutes.homeRout);

      setState(() {
        isLoadding = false;
      });
      // Store the CNIC and Folio number
      // _box.write('cnic', cnic);
      // _box.write('folio', folno);
    } else {
      setState(() {
        isLoadding = false;
        Message = "";
      });
      // Message = "Invalid Credentials";
      Alert(
        style: AlertStyle(),
        context: context, title: "Error", desc: "Invalid Credentials")
          .show();
      print(response.reasonPhrase);
    }
  }

  bool? isObscurText = true;
  @override
  void initState() {
    super.initState();
    final cnic = _box.read('cnic');
    final folio = _box.read('folio');
    if (cnic != null) {
      cnicController.text = cnic;
    }
    if (folio != null) {
      folioController.text = folio;
    }
  }

  @override
  void dispose() {
    folioController.dispose();
    cnicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 38.h,
                child: HeaderWidget(
                  38.h,
                ), //let's create a common header widget
              ),
              SizedBox(height: 20.0),
              // Image.asset("assets/images/login_image.png"),
              // Image.asset("assets/images/logo.png", fit: BoxFit.cover),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(1.h),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Login into your account',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cnicController,
                        decoration: InputDecoration(
                          hintText: "Enter CNIC",
                          labelText: "CNIC",
                          fillColor: Theme.of(context).colorScheme.onPrimary,
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "CNIC connot be empty";
                          }
                          // else if (value.length < 6) {
                          //   return "CNIC length should be at least 6";
                          // }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: folioController,
                        obscureText: isObscurText!,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Theme.of(context).colorScheme.outline,
                            icon: Icon(
                                size: 24,
                                isObscurText!
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isObscurText = !isObscurText!;
                              });
                            },
                          ),
                          hintText: "Enter Folio#",
                          labelText: "Folio#",
                          fillColor: Theme.of(context).colorScheme.onPrimary,
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.outline)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2.0)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Folio# connot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 4.h),
                      RoundButton(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onTap: () {
                          final form = _formKey.currentState;

                          if (form != null && form.validate()) {
                            // isLoadding = true;
                            signIn(
                              folioController.text.toString(),
                              cnicController.text.toString(),
                            );
                          }
                        },
                        title: 'Login',
                        loading: isLoadding,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
