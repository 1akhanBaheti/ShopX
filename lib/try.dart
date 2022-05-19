import 'package:ecommerce/firebaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class trial extends StatelessWidget {
  //const try({Key? key}) : super(key: key);
  var image;
  var compressed;

  Future getImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      image = file;
      return image;
    } catch (e) {
      throw (e);
    }
  }

  var pi;

  @override
  Widget build(BuildContext context) {
    var fire = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(fire.result.toString()),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  // await fire.compressFile().then((value) => image = value);
                  // compressed = fire.compressed;
                  // fire.notifyListeners();
                  await fire.updateData().then((value) {
                    pi = value.toString();
                  });
                  fire.notifyListeners();
                },
                child: Container(
                  height: 50,
                  width: 70,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
