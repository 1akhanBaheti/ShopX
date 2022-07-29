import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirmation extends StatelessWidget {
  //const Confirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Colors.deepPurple.withOpacity(0.9),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'toMainScreen', (route) => false);
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      )),
                )),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.23),
                height: 90,
                width: 90,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SvgPicture.asset('assets/images/orderDone.svg'),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Order Placed!',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Your order has been placed successully',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  'For more details check order status',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('toMainScreen', (route) => false);
              },
              child: Container(
                //height:40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 30, right: 30),
                margin: EdgeInsets.only(top: 25),

                child: Wrap(
                    spacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Order Status',
                        style: GoogleFonts.lato(
                            color: Colors.deepPurple, fontSize: 18),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
