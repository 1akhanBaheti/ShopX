import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:ecommerce/FirebaseCredentials.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseProvider extends ChangeNotifier {
  var firebaseApp;
  bool loadMainOnce = false;
  // ignore: non_constant_identifier_names
  List<ProductClass> Products = [];
  // ignore: non_constant_identifier_names
  List<ProductClass> SearchProducts = [];
  firest() async {
    var inst = [];

    Firebase.initializeApp();

    await FirebaseFirestore.instance.collection('Products').get().then((value) {
      value.docs.forEach((element) {
        inst.add(element.data());
      });
    });

    return inst;
  }

  Future getProducts() async {
    // if (!loadMainOnce) {
    //   print("RAN");
    try {
      List<ProductClass> loca = [];
      var url = Uri.parse(credentials().realTimeDatabase + "Products.json");

      var response = await https.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      //print(data);
      data.forEach((id, data) {
        //print(data['id']);
        loca.add(ProductClass(
            //packaging: data['packaging']?data['packaging']:null,
            description: data['description'],
            category: data['category'],
            id: data['id'],
            price: data['price'],
            title: data['title'],
            imageUrl: data['image']));
            //imageUrl: data['imageUrl'][0].toString().replaceAll(RegExp(r'dl=0'),'raw=1')));
      });
      Products = loca;
      //print(Products.length);
      loadMainOnce = true;

      return Products;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
//////////////////////////SEARCH IMPLEMENTATION ///////////////////////////////////////

  void searchItems(String s) {
    if (s.length == 0) {
      SearchProducts = [];
      notifyListeners();
      return;
    }
    SearchProducts = [];
    Products.forEach((element) {
      if (element.title.toLowerCase().startsWith(s.toLowerCase()) ||
          element.title.toLowerCase().contains(s.toLowerCase())) {
        SearchProducts.add(element);
        
      }
    });
    notifyListeners();
  }

  var link = [];
  Future getImages() async {
    try {
      var ref = FirebaseStorage.instance.ref('Products');
      await ref.listAll().then((value) async {
        //print(value.items);
        int n = value.items.length;
       // print(n);
        link = [];
        for (int i = 0; i < n; i++) {
          var url = await value.items[i].getDownloadURL();
          link.add(url);
        }
      });
      return link;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  var compressed;
  Future checkFolder(String name) async {
    try {
      await Dropbox.authorizeWithAccessToken(
          'sl.BDc47BNy1creUSk5UU6nNL0bDi1fImQlGkpiB68wRkJGcsmr-LTI4CWIhO-8f45YMY4pR4R9dVTzgvbHrl9HJKYhY_Curbe8RyEpBPdq9ksWNNMMeJ8CcbtCgyeMM3iScZ8044U3zF0');

      var res = await https.post(
          Uri.parse('https://api.dropboxapi.com/2/files/search_v2'),
          headers: {
            'Authorization':
                "Bearer sl.BDc47BNy1creUSk5UU6nNL0bDi1fImQlGkpiB68wRkJGcsmr-LTI4CWIhO-8f45YMY4pR4R9dVTzgvbHrl9HJKYhY_Curbe8RyEpBPdq9ksWNNMMeJ8CcbtCgyeMM3iScZ8044U3zF0",
            'Content-Type': "application/json"
          },
          body: json.encode({"query": '/Products/$name'}));
      var list = [];
      if (res.statusCode == 200) {
       // print(res.body);
        list = json.decode(res.body)['matches'];
        if (list.length == 0) return false;
        return true;
      } else
        //print(res.body);
      return false;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future compressFile() async {
    var tempPath;
    await getTemporaryDirectory().then((value) => tempPath = value.path);
    try {
      ///await checkFolder('Chakoli');
      // await Dropbox.authorizeWithAccessToken(
      //     "sl.BDfSUido9ITpRZuLx9udKxfDfRlyCeupFqsx1HjX49_xU0Cd4lIxoEQVSOBVD5i7ba4cFIewhW6zXg_xeMfrWU5VAAlaPMqAXnHaTUpAJhA_2bbo1AiHDmo0f_7MR_drjn1G50jJHcc");
      // // await getImages();
      for (int i = 0; i < Products.length; i++) {
        bool c = false;
        await checkFolder(Products[i].title.trimRight())
            .then((value) => c = value);
        if (c == true) {
          print('passed');
          continue;
        }
        var result = new File('$tempPath/temp.jpg');
        var res = await https.get(Uri.parse(Products[i].imageUrl));
        result.writeAsBytesSync(res.bodyBytes);
        var compress = await FlutterImageCompress.compressAndGetFile(
          result.path,
          tempPath + "/compressed.jpg",
          quality: 20,
        );

         await Dropbox.upload(compress!.absolute.path,
                '/Products/${Products[i].title.trimRight()}/${Products[i].title}1.jpg')
            .then((value) {
          print(
              '/Products/${Products[i].title.trimRight()}/${Products[i].title}1.jpg');
          print(value);
        });

        //print(result.lengthSync());
        // print(compress.lengthSync());
        compressed = compress;
      }

      // return compressed;
      // await https
      //     .post(Uri.parse('https://content.dropboxapi.com/2/files/upload'),
      //         headers: {
      //           "path": "/lakhan.jpg",
      //           "Authorization":
      //               "Bearer <sl.BDbOZN7TjL-sl.BDYqZcCbLGTW7_mnqLKxeF-D3A-zQRsRFa-Ppvo-_wdOUC-PQFKy3fKN8hpF2jveXS1YQNi54TrsJUyvRERTN6JK4tpSkCN_VpjCjNwLUeaGHV3Z33KbxUhC-cM-uRoexebdlansFEA>",
      //           "Content-Type": "application/octet-stream",
      //         },
      //         body: result.readAsBytesSync())
      //     .then((value) {
      //   print(value.body);
      // });
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Map<String, String> result = {};
  Future getLinkFromDropbox() async {
    try {
      //await Dropbox.authorizeWithAccessToken(
      //   'sl.BDc47BNy1creUSk5UU6nNL0bDi1fImQlGkpiB68wRkJGcsmr-LTI4CWIhO-8f45YMY4pR4R9dVTzgvbHrl9HJKYhY_Curbe8RyEpBPdq9ksWNNMMeJ8CcbtCgyeMM3iScZ8044U3zF0');
      var res = await https.post(
          Uri.parse('https://api.dropboxapi.com/2/files/list_folder'),
          headers: {
            'Authorization':
                "Bearer sl.BDi7mdZoCKRw2dKFQmy55JmWDxSaOV8PfjyfPLkQdmmlzaUqwmY1lq-yM0SbicnveXzEE_q3RSzHWYx-5oWxs7Wclg6x76UczErv8NOf7nIcUM1oJAInCK6RyEYkAhsIosasXt67-nc",
            'Content-Type': "application/json"
          },
          body: json.encode({"path": "/Products", "recursive": true}));

      if (res.statusCode == 200) {
        var data = json.decode(res.body)['entries'] as List<dynamic>;
        var temp1 = [];
        data.forEach((element) {
          if (element['.tag'] == "file") {
            temp1.add(element);
            //  print(element['path_display']);
          }
        });
        data = temp1;
        result = {};
        // print(temp1.length);
        for (int i = 0; i < data.length; i++) {
          // print(temp1[i]['path_display']);
          var res1 = await https.post(
              Uri.parse(
                  'https://api.dropboxapi.com/2/sharing/list_shared_links'),
              headers: {
                'Authorization':
                    "Bearer sl.BDi7mdZoCKRw2dKFQmy55JmWDxSaOV8PfjyfPLkQdmmlzaUqwmY1lq-yM0SbicnveXzEE_q3RSzHWYx-5oWxs7Wclg6x76UczErv8NOf7nIcUM1oJAInCK6RyEYkAhsIosasXt67-nc",
                'Content-Type': "application/json"
              },
              body: json.encode({"path": temp1[i]['path_display']}));
          //print(json.decode(res1.body)['links'][0]['name']);
          // print(res1.statusCode);
          if (res1.statusCode <= 399 && res1.statusCode >= 200) {
            var temp = json.decode(res1.body);
            // print(temp['links'][0]['name']);
            if (temp['links'][0]['.tag'] == "file") {
              var name = temp['links'][0]['name']
                  .toString()
                  .replaceAll(RegExp(r'.jpg'), "");
              name = name.replaceAll(RegExp(r'1'), "");
              name = name.trimRight();
              result.addEntries(<String, String>{
                name: temp['links'][0]['url'].toString()
              }.entries);
            } else
              result.addEntries(<String, String>{
                temp['links'][0]['name'].toString().trimRight():
                    temp['links'][1]['url'].toString()
              }.entries);
          } else
            print(res1.body);
        }
        //("result");
        //print(result);
        return result;
      } else
        print(res.body);
    } catch (e) {
      throw (e);
    }
  }

  Future updateData() async {
    await getLinkFromDropbox().then((value) async {
      for (int i = 0; i < Products.length; i++) {
        var image = [];
        image.add(result['${Products[i].title.trimRight()}']);
        var temp = {
         // 'packaging': Products[i].packaging,
          "description": Products[i].description,
          'category': Products[i].category,
          'id': i + 1,
          'price': Products[i].price,
          'title': Products[i].title,
          'imageUrl': image,
        };
        var ref = FirebaseDatabase.instance.reference().child('Products2');
        try {
          await ref.push().set(temp);
        } catch (e) {
          print(e);
          throw (e);
        }
      }
      return result;
    });
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  String pi = "lakhan";
  Future p() async {
    await getTemporaryDirectory().then((value) => pi = value.toString());
    pi += "/lakhan/";

    return pi;
  }
///////////////////////////////////////////////////////////////////////////////////////
}
