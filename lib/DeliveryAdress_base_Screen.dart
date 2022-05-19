
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DelieveryAdress extends StatefulWidget {
  // const DelieveryAdress({Key? key}) : super(key: key);

  @override
  _DelieveryAdressState createState() => _DelieveryAdressState();
}

class _DelieveryAdressState extends State<DelieveryAdress> {
  var country;
  var state;

  var fullName = TextEditingController();
  var isFullnameEmpty = false;
  var mobileNumber = TextEditingController();
  var isMobileNoEmpty = false;
  var pincode = TextEditingController();
  var isPincodeEmpty = false;
  var houseNo = TextEditingController();
  var isHouseNoEmpty = false;
  var area = TextEditingController();
  var isAreaEmpty = false;
  var landmark = TextEditingController();
  var isLandmarkEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus) focus.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
              SizedBox(
                height: 10,
              ),
               
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  'Add a new address',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  menuMaxHeight: 500,
                  focusColor: Colors.deepPurple,
                  underline: Container(),
                  icon: Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (co) {
                    setState(() {
                      country = co as String;
                    });
                  },
                  hint: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Select Country")),
                  value: country,
                  items: countries
                      .map(
                        (e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              width: MediaQuery.of(context).size.width - 90,

                              height: 60,
                              // color: Colors.amber,
                              // alignment: Alignment.centerLeft,
                              child: Text(
                                "${e.toString()}",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Full name',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                //  color: Colors.deepOrange,
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.grey.shade800
                //     ),
                //     borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isFullnameEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: fullName,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                      //   hintText: "Full name",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2))),
                ),
              ),
              isFullnameEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Mobile number',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isMobileNoEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: mobileNumber,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "10-digit mobile number without prefixes",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              isMobileNoEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Pincode',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isPincodeEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: pincode,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      // hintText: "Pincode",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              isPincodeEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Flat, House no, Building, Company, Apartment',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isHouseNoEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: houseNo,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      // hintText: "Flat, House no, Building, Company, Apartment",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              isHouseNoEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Area, Colony, Street, Sector, Village',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isAreaEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: area,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      //  hintText: "Area, Colony, Street, Sector, Village",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              isAreaEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('Landmark e.g. near Apollo Hospital',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  onChanged: (e) {
                    if (isLandmarkEmpty)
                      setState(() {
                        isFullnameEmpty = false;
                      });
                  },
                  controller: landmark,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Landmark e.g. near Apollo Hospital",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              isLandmarkEmpty
                  ? Container(
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text('*This field is required',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)))
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5),
                  child: Text('State',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  menuMaxHeight: 500,
                  focusColor: Colors.deepPurple,
                  underline: Container(),
                  icon: Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (co) {
                    setState(() {
                      state = co as String;
                    });
                  },
                  hint: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Select State")),
                  value: state,
                  items: states
                      .map(
                        (e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              width: MediaQuery.of(context).size.width - 90,

                              height: 60,
                              // color: Colors.amber,
                              // alignment: Alignment.centerLeft,
                              child: Text(
                                "${e.toString()}",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  onPressed: () {
                    // if (fullName.text == '') isFullnameEmpty = true;

                    // if (mobileNumber.text == '') isMobileNoEmpty = true;

                    // if (pincode.text == '') isPincodeEmpty = true;

                    // if (houseNo.text == '') isHouseNoEmpty = true;

                    // if (area.text == '') isAreaEmpty = true;

                    // if (landmark.text == '') isLandmarkEmpty = true;

                    if (isFullnameEmpty ||
                        isMobileNoEmpty ||
                        isPincodeEmpty ||
                        isHouseNoEmpty ||
                        isAreaEmpty ||
                        isLandmarkEmpty)
                      setState(() {});
                    else {
                      //  FirebaseFirestore.instance
                      //     .collection('Users')
                      //     .doc(FirebaseAuth.instance.currentUser!.uid)
                      //     .update({
                      //   'address': [
                      //     {
                      //       'Country': 'India',
                      //       'Fullname': 'Lakhan Baheti 1',
                      //       'Mobilenumber': '9999999999',
                      //       'Pincode': '492001',
                      //       'Flat,House no,Building,Company,Apartment':
                      //           'Luv Kush Vihar B-20',
                      //       'Area,Colony,Street,Sector,Village':
                      //           'Choubey Colony',
                      //       'Landmark': 'near RKC',
                      //       'City':'Raipur',
                      //       'State':'Chattisgarh'
                      //     },
                      //      {
                      //       'Country': 'India',
                      //       'Fullname': 'Lakhan Baheti 2',
                      //       'Mobilenumber': '9999999999',
                      //       'Pincode': '492001',
                      //       'Flat,House no,Building,Company,Apartment':
                      //           'Luv Kush Vihar B-20',
                      //       'Area,Colony,Street,Sector,Village':
                      //           'Choubey Colony',
                      //       'Landmark': 'near RKC',
                      //       'City':'Raipur',
                      //       'State':'Chattisgarh'
                      //     }
                      //   ]
                      // });
                      // .get()
                      // .then((value) {
                      //   value.
                      // });
                     // Navigator.of(context).popAndPushNamed('toCheckoutScreen');
                    }
                  },
                  child: Text(
                    'Add address',
                    style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
