import 'package:ecommerce/Account.dart';
import 'package:ecommerce/DeliveryAdress_base_Screen.dart';
import 'package:ecommerce/FavoriteScreen.dart';
import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/Search.dart';
import 'package:ecommerce/authentication.dart';
import 'package:ecommerce/cartScreen.dart';
import 'package:ecommerce/firebaseProvider.dart';
import 'package:ecommerce/mainScreen.dart';
import 'package:ecommerce/popularItems.dart';
import 'package:ecommerce/productDetailScreen.dart';
import 'package:ecommerce/signupScreens/mainOtions.dart';
import 'package:ecommerce/signupScreens/signin.dart';
import 'package:ecommerce/signupScreens/signup.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  print("INITIALIZATION COMPLETE  ");
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isFirst = false;

  var _firebaseApp;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future setFirst(bool l) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool('first', l);
  }

  Future getIsFirst() async {
    var pref = await SharedPreferences.getInstance();

    // await pref.remove('first');
    
    

    if (pref.getBool('first') == true) {
      print("true1");
      setFirst(false);
      return false;
    } else if (pref.getBool('first') == null) {
      print("true");
      setFirst(true);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var prov = Provider.of<FirebaseProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_)=>Auth()),
        ChangeNotifierProvider<provider>(create: (_) => provider()),
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider()),
      ],
      // create: (ctx) => provider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Text('Error initializing firebase app');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // prov.firebaseApp = _firebaseApp;

                 if (snapshot.data == true) return MainSignupLogin();

                return Mainscreen();
              } else
                return CircularProgressIndicator();
            },
            future: getIsFirst(),
          )),
          routes: {
            'toSpalshScreen': (ctx) => Splashscreen(),
            'toMainScreen': (ctx) => Mainscreen(),
            'toProductDetailScreen': (ctx) => ProductDetailScreen(),
            'toFavouriteScreen': (ctx) => Favourite(),
            'toPopularScreen': (ctx) => Popular(),
            'toCartScreen': (ctx) => CartScreen(),
            'Base_delievery_address': (ctx) => DelieveryAdress(),
            //'toAccount': (ctx) => Account(),
            'toSearch': (ctx) => Search(),
            'toMainoptions': (ctx) => MainSignupLogin(),
            'toSignupScreen': (ctx) => Signup(),
            'toSignInScreen': (ctx) => Signin(),
          }),
    );
  }
}
