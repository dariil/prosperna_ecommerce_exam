import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:prosperna_ecommerce_exam/functions/functions.dart';
import 'package:prosperna_ecommerce_exam/pages/editProduct.dart';
import '../widgets/components.dart';
import 'addProduct.dart';
import 'drawer.dart';

class MaintainProduct extends StatefulWidget {
  const MaintainProduct({super.key});

  @override
  State<MaintainProduct> createState() => _MaintainProductState();
}

class _MaintainProductState extends State<MaintainProduct> {
  pageFunctions myFunc = pageFunctions();
  final Box box = Hive.box("mybox");
  var productList;

  void initState() {
    super.initState();

    if (!myFunc.tbl_products.isEmpty) {
      print("Product ID: ${myFunc.tbl_products[0]['product_id']}");
    } else {
      print("Empty Items");
    }
  }

  void checkProduct() {
    if (!myFunc.tbl_products.isEmpty) {
      print("Product Name: ${myFunc.tbl_products[0]['product_name']}");
      print("Product Name: ${myFunc.tbl_products[0]['image']}");
    } else {
      print("Empty Items");
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    pageComponents myComponents = pageComponents();

    return Scaffold(
      key: scaffoldKey,
      appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
      drawer: NavDrawer(),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(margin: EdgeInsets.symmetric(vertical: 15.0), child: myComponents.labelTexts(context, "Modify Products Page")),
            Text("Click add icon to add product"),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: myFunc.tbl_products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                                offset: Offset(4.0, 4.0),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Row(children: [
                              Text('${index + 1}'),
                              myFunc.tbl_products[index]['image'] != null
                                  ? Image.file(
                                      myFunc.tbl_products[index]['image']!,
                                      width: 60,
                                      height: 60,
                                    )
                                  : Text('Select an image'),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(myFunc.tbl_products[index]['product_name'],
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.0,
                                        )),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text('₱${myFunc.tbl_products[index]['price']}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.0,
                                        )),
                                  ),
                                ],
                              ),
                            ]),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct()));
                                  setState(() {
                                    myFunc.selected_product = index;
                                  });
                                },
                                icon: Icon(Icons.edit)),
                          ]),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkProduct();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProduct()));
        },
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
