import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/firebaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  //const Search({Key? key}) : super(key: key);
  var current;
  //Search(this.current);
  var searchController = TextEditingController();
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    print('Builded');

    //var is1 = false;
    var pro = Provider.of<provider>(context, listen: false);
    pro.search = false;
    var focusScope = FocusScope.of(context);
    var fireprov = Provider.of<FirebaseProvider>(context, listen: true);
   // var focus = FocusNode();
    return WillPopScope(
      onWillPop: () async {
        print('pop');
        fireprov.SearchProducts = [];
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (!focusScope.hasPrimaryFocus)
                focusScope.requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
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
                          top: MediaQuery.of(context).padding.top + 7,
                          bottom: 7),
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
                                controller: widget.searchController,
                                onChanged: (e) {
                                  print(e.length);
                                  fireprov.searchItems(e);
                                  // if (e == '') {
                                  //   print('if');
                                  //   pro.isSearchEnabeled(false);
                                  // } else {
                                  //   print('else');
                                  //   pro.isSearchEnabeled(true);
                                  // }
                                },
                                cursorHeight: 20,
                                autofocus: true,
                                cursorColor: Colors.deepPurple,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
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
                                      widget.searchController.text = '';
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
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          14 -
                          50,
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                            itemCount: fireprov.SearchProducts.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      'toProductDetailScreen',
                                      arguments:
                                          fireprov.SearchProducts[index]);
                                },
                                child: Container(
                                    child: ListTile(
                                  leading: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    fireprov.SearchProducts[index].title,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  ),
                                )),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
