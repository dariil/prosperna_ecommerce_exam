import 'package:flutter/material.dart';
import 'package:prosperna_ecommerce_exam/functions/functions.dart';
import 'package:prosperna_ecommerce_exam/pages/drawer.dart';
import 'package:prosperna_ecommerce_exam/pages/viewProduct.dart';
import 'package:prosperna_ecommerce_exam/widgets/components.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  pageFunctions myFunc = pageFunctions();
  pageComponents myComponents = pageComponents();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
        drawer: NavDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              // color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.9,
              child: GridView.builder(
                  itemCount: myFunc.tbl_products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewProduct()));
                        setState(() {
                          myFunc.selected_product = index;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            // color: Colors.blue,
                            padding: EdgeInsets.all(2.0),
                            child: myFunc.tbl_products[index]['image'] != null
                                ? Image.file(
                                    myFunc.tbl_products[index]['image']!,
                                    width: 150,
                                    height: 100,
                                  )
                                : Text(''),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              myFunc.tbl_products[index]['product_name'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            // height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              '₱${myFunc.tbl_products[index]['price']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
