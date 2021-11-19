import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DelieveryAdress extends StatefulWidget {
  // const DelieveryAdress({Key? key}) : super(key: key);

  @override
  _DelieveryAdressState createState() => _DelieveryAdressState();
}

class _DelieveryAdressState extends State<DelieveryAdress> {
  var country;
  var state;
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onTap: () {
           var focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus)
           focus.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Full name",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Mobile number",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Pincode",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Flat, House no, Building, Company, Apartment",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Area, Colony, Street, Sector, Village",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  cursorHeight: 23,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      hintText: "Landmark e.g. near Apollo Hospital",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 10,
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
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  onPressed: null,
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
