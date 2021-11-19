import 'package:ecommerce/Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  //const Search({Key? key}) : super(key: key);
  var current;
  //Search(this.current);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    print('Builded');
    var searchController = TextEditingController();
    var is1 = false;
    var pro = Provider.of<provider>(context, listen: false);
    pro.search = false;

    var focus = FocusNode();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 7, bottom: 7),
                child:
                    //color: Colors.white,
                    Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Container(
                        padding: EdgeInsets.only(top: 11),
                        // color: Colors.deepOrange,
                        height: 50,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (e) {
                            if (e == '') {
                              print('if');
                              pro.isSearchEnabeled(false);
                            } else {
                              print('else');
                              pro.isSearchEnabeled(true);
                            }
                          },
                          cursorHeight: 20,
                          autofocus: true,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.lato(
                                  color: Colors.grey, fontSize: 16),
                              hintText: 'Search for Products',
                              fillColor: Colors.transparent,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                    Consumer<provider>(builder: (_, d, __) {
                      return d.search
                          ? Container(
                              child: IconButton(
                              onPressed: () {
                                searchController.text = '';
                                pro.isSearchEnabeled(false);
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: Colors.black,
                              ),
                            ))
                          : Container();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
