import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoEdit extends StatefulWidget {
  //UserInfoEdit({Key? key}) : super(key: key);

  @override
  _UserInfoEditState createState() => _UserInfoEditState();
}

class _UserInfoEditState extends State<UserInfoEdit> {
  var file;
  var name = TextEditingController();

  var email = TextEditingController();
  var phoneNo = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    name.text = FirebaseAuth.instance.currentUser!.displayName!;
    email.text = FirebaseAuth.instance.currentUser!.email!;
    var focus = FocusScope.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (!focus.hasPrimaryFocus) focus.unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.black,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            'Info',
                            style: GoogleFonts.lato(
                                color: Colors.black, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                              backgroundImage: file != null
                                  ? FileImage(File(file.path))
                                  : null,
                              // FirebaseAuth.instance.currentUser!.photoURL !=null ?NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!):null,
                              radius: 75,
                              backgroundColor: Colors.grey.shade400,
                              child: isLoading
                                  ? Shimmer.fromColors(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(90)),
                                      ),
                                      baseColor: Colors.grey.shade400,
                                      highlightColor: Colors.grey.shade300)
                                  : Container()),
                        ),
                        Container(
                          // decoration: BoxDecoration(

                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(40)),
                          margin: EdgeInsets.only(
                              top: 100,
                              left:
                                  MediaQuery.of(context).size.width * .50 + 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 10,
                            child: IconButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) {
                                      return Container(
                                          height: 100,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    var file1 =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    Navigator.pop(context);
                                                    if (file1 != null) {
                                                      setState(() {
                                                        file = file1;
                                                        //  isLoading = true;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    // color: Colors.amber,
                                                    decoration: BoxDecoration(
                                                        border: BorderDirectional(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                width: 2))),
                                                    height: 50,
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 10),
                                                    child: Text(
                                                      'Pick From Gallery',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.lato(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      file = null;
                                                    });
                                                  },
                                                  child: Container(
                                                    // margin: EdgeInsets.only(left:10,top: 5),
                                                    padding: EdgeInsets.only(
                                                        left: 10, top: 10),
                                                    height: 50,

                                                    child: Text(
                                                      'remove',
                                                      style: GoogleFonts.lato(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                )
                                              ]));
                                    });
                              },
                              // var file1 = await ImagePicker()
                              //     .pickImage(source: ImageSource.gallery);

                              // if (file1 != null) {
                              //   setState(() {
                              //     file = file1;
                              //   //  isLoading = true;
                              //   });
                              ///////////////////////////////////////////////////////////
                              //  await http.post(Uri.parse('gs://adminpanel-23c73.appspot.com/lakhan',),body: File(file.path));
                              // await FirebaseStorage.instance
                              //     .ref('lakhan')
                              //     .putFile(File(file.path))
                              //     .then((p0) async {
                              //   var url = await p0.ref.getDownloadURL();
                              //   FirebaseAuth.instance.currentUser!
                              //       .updatePhotoURL(url)
                              //       .then((_) {
                              //     setState(() {
                              //       isLoading = false;
                              //     });
                              //   });
                              // });
                              //  }
                              // },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Name',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 4),
                    child: TextFormField(
                      //initialValue: FirebaseAuth.instance.currentUser!.displayName,
                      controller: name,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Email ',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 4),
                    child: TextFormField(
                      controller: email,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Phone no',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 4),
                    child: TextFormField(
                      controller: phoneNo,
                      enabled: true,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                          // disabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.grey, width: 3),
                          //   ),
                          //   border: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                          //   ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          )),
                    ),
                  ),
                  Spacer(),
                  Container(
                    color: Colors.deepPurple,
                    height: 50,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'Save',
                      style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
