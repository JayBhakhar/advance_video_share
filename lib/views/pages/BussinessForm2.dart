import 'dart:convert';
import 'dart:io';
import 'package:advance_video_share/consts/Utility.dart';
import 'package:advance_video_share/models/cardModel.dart';
import 'package:advance_video_share/views/pages/BussinessCardFrame.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class BussinessForm2 extends StatefulWidget {
  cardModel categoryType;

  //
  BussinessForm2({Key key, this.categoryType}) : super(key: key);

  @override
  _BussinessForm2State createState() => _BussinessForm2State();
}

class _BussinessForm2State extends State<BussinessForm2> {
  DateTime selectedDate = DateTime.now();
  TextEditingController festivalName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contactNumber1 = TextEditingController();
  TextEditingController contactNumber2 = TextEditingController();
  File logoFile = null;
  String logopath = "";
  String _localPath = "";
  SharedPreferences prefs;
  Image imageFromPreferences = null;

  _saveDetails() async {
    await prefs.setString('festivalName', festivalName.text);
    await prefs.setString('companyName', companyName.text);
    await prefs.setString('email', email.text);
    await prefs.setString('website', website.text);
    await prefs.setString('address', address.text);
    await prefs.setString('contactNumber1', contactNumber1.text);
    await prefs.setString('contactNumber2', contactNumber2.text);
    if (logoFile != null) {
      // final bytes = await Io.File(logopath).readAsBytes();
      // String base64Encode(List<int> bytes) => base64.encode(bytes);
      final bytes = Io.File(logoFile.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      await prefs.setString('logo', img64);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BussinessCardFrame(
          categoryType: widget.categoryType,
        ),
      ),
    );
  }

  _initDetails() async {
    prefs = await SharedPreferences.getInstance();
    festivalName.text = prefs.getString('festivalName');
    companyName.text = prefs.getString('companyName');
    email.text = prefs.getString('email');
    website.text = prefs.getString('website');
    address.text = prefs.getString('address');
    contactNumber1.text = prefs.getString('contactNumber1');
    contactNumber2.text = prefs.getString('contactNumber2');
    // String baselogo = prefs.getString('logo');
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    //   if (baselogo != null) {
    //     final decodedBytes = base64Decode(baselogo);
    //     setState(() {
    //       logoFile = Io.File(_localPath + Platform.pathSeparator + "profileLogo.png");
    //       logoFile.writeAsBytesSync(decodedBytes);
    //     });
    //   }
    // }
    Utility.getImageFromPreferences().then((img) {
      if (null == img || img.isEmpty) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img, 140);
      });
    });
  }

  final picker = ImagePicker();

  Future _logo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        logopath = pickedFile.path;
        logoFile = File(pickedFile.path);
        final bytes = Io.File(logoFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        prefs.setString('logo', img64);
        imageFromPreferences = null;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initPath();
  }

  void initPath() async {
    _localPath = (await DownloadsPathProvider.downloadsDirectory).path; // temp comment
    print("LOCAL path==" + _localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    _initDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B0000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          'Add card details',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _saveDetails();
        },
        child: Container(
            margin: const EdgeInsets.only(top: 6.0),
            decoration:
                BoxDecoration(color: Color(0xFF8B0000), borderRadius: BorderRadius.only(topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0))),
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
              child: Text(
                'Make a Business Card',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Source Sans Pro"),
              ),
            )),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: (logoFile != null || imageFromPreferences != null)
                      ? Container(
                          height: 150,
                          width: 150,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: imageFromPreferences != null
                                    ? imageFromPreferences
                                    : Image.file(
                                        logoFile,
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: _showChooseDialog,
                                      child: CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.edit, color: Colors.white, size: 25))))
                            ],
                          ),
                        )
                      : InkWell(onTap: _logo, child: Icon(Icons.add_a_photo, color: Colors.green, size: 100)),
                ),
                customTextFormFieldforStr(festivalName, "Festive Name"),
                customTextFormFieldforStr(companyName, "Company Name"),
                customTextFormFieldForEmail(email),
                customTextFormFieldforStr(website, "Website"),
                customTextFormFieldforStr(address, "Address"),
                customTextFormFieldForIntWithlen(contactNumber1, "Contact Number", 10),
                customTextFormFieldForIntWithlen(contactNumber2, "Whatsapp Number", 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextFormFieldforStr(
    final TextEditingController controller,
    final String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget customTextFormFieldForEmail(
    final TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please a Enter Email';
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
            return 'Please a valid Email';
          }
          return null;
        },
      ),
    );
  }

  Widget customTextFormFieldForIntWithlen(
    final TextEditingController controller,
    final String labelText,
    final int length,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Color(0xFF8B0000), width: 1.5),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter $labelText';
          } else if (value.length != length) {
            return 'Please enter $length digits';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _showChooseDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Image', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      _logo();
                    },
                    child: Text(
                      "Select Other Image",
                      style: TextStyle(fontFamily: 'Source Sans Pro', fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                    )),
                SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      logoFile = null;
                      imageFromPreferences = null;
                      prefs.setString('logo', "");
                      Navigator.of(context).pop();
                    });

                  },
                  child: Text(
                    "Delete Image",
                    style: TextStyle(fontFamily: 'Source Sans Pro', fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
