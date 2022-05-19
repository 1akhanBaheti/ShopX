import 'package:ecommerce/Account.dart';
import 'package:ecommerce/ChangeOrAddAddress.dart';
import 'package:ecommerce/DeliveryAdress_base_Screen.dart';
import 'package:ecommerce/FavoriteScreen.dart';
import 'package:ecommerce/NotificationScreen.dart';
import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/Search.dart';
import 'package:ecommerce/authentication.dart';
import 'package:ecommerce/cartScreen.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:ecommerce/checkoutScreen.dart';
import 'package:ecommerce/confirmationScreen.dart';
import 'package:ecommerce/firebaseProvider.dart';
import 'package:ecommerce/mainScreen.dart';
import 'package:ecommerce/orderDetailsScreenBeforeDelivery.dart';
import 'package:ecommerce/orders.dart';
import 'package:ecommerce/paymentScreen.dart';
import 'package:ecommerce/popularItems.dart';
import 'package:ecommerce/productDetailScreen.dart';
import 'package:ecommerce/signupScreens/mainOptions.dart';
import 'package:ecommerce/signupScreens/signin.dart';
import 'package:ecommerce/signupScreens/signup.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:ecommerce/try.dart';
import 'package:ecommerce/userInfoEdit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Dropbox.init('first', '1td1ee9mpwemhae', '1td1ee9mpwemhae');
 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isFirst = false;

  @override
  void initState() {
    super.initState();
  }

  Future setFirst(bool l) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool('first', l);
  }

  Future getIsFirst() async {
    var pref = await SharedPreferences.getInstance();

    // await pref.remove('first');

    if (pref.getBool('first') == true) {
      //print("true1");
      setFirst(false);
      return false;
    } else if (pref.getBool('first') == null) {
      //print("true");
      setFirst(true);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var prov = Provider.of<FirebaseProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider<provider>(create: (_) => provider()),
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider()),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (_) => CheckoutProvider()),

        //ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ],
      // create: (ctx) => provider(),
      child: MaterialApp(
       // darkTheme: ThemeData.dark(), // standard dark theme
       //themeMode: ThemeMode.system, 
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
            'trial': (ctx) => trial(),
            'toSpalshScreen': (ctx) => Splashscreen(),
            'toMainScreen': (ctx) => Mainscreen(),
            'toSearch': (ctx) => Search(),
            'toCheckoutScreen': (ctx) => CheckoutScreen(),
            'toPaymentScreen': (ctx) => PaymentScreen(),
            'toAccount': (ctx) => Account(),
            'toMainoptions': (ctx) => MainSignupLogin(),
            'toConfirmation': (ctx) => Confirmation(),
            'toProductDetailScreen': (ctx) => ProductDetailScreen(),
            'toOrderDetailsScreenBeforeDelivery': (ctx) =>
                OrderDetailsScreenBeforeDelivery(),
            'toOrdersScreen': (ctx) => Orders(),
            'toFavouriteScreen': (ctx) => Favourite(),
            'toNotificationScreen': (ctx) => Notifications(),
            'toPopularScreen': (ctx) => Popular(),
            'toCartScreen': (ctx) => CartScreen(),
            'toChangeOrAddAddressScreen': (ctx) => ChangeOrAddAdress(),
            'Base_delievery_address': (ctx) => DelieveryAdress(),
            'toSignupScreen': (ctx) => Signup(),
            'toSignInScreen': (ctx) => Signin(),
            'toUserInfoEditScreen': (ctx) => UserInfoEdit()
          }),
    );
  }
}
