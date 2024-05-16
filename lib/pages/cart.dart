import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prosperna_ecommerce_exam/functions/functions.dart';
import 'package:prosperna_ecommerce_exam/pages/drawer.dart';
import 'package:prosperna_ecommerce_exam/widgets/components.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  pageFunctions myFunc = pageFunctions();
  final Map<int, int> quantityMap = {};
  double cartTotalPrice = 0.0;
  var index;
  File? image;
  pageComponents myComponents = pageComponents();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    _calculateCartTotal();
  }

  void _calculateCartTotal() {
    cartTotalPrice = 0.0;
    for (var i = 0; i < myFunc.tbl_cart.length; i++) {
      int quantity = quantityMap[i] ?? 0;
      double productPrice = double.parse(myFunc.tbl_cart[i]['price']);
      cartTotalPrice += productPrice * quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: myComponents.appBar(scaffoldKey: scaffoldKey),
        drawer: NavDrawer(),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(margin: EdgeInsets.symmetric(vertical: 15.0), child: myComponents.labelTexts(context, "Cart Page")),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: myFunc.tbl_cart.length,
                    itemBuilder: (context, index) {
                      int currentQuantity = quantityMap[index] ?? 1;
                      double productPrice = double.parse(myFunc.tbl_cart[index]['price']);
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
                            child: Row(children: [
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
                                      child: Text('₱${(productPrice * currentQuantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16.0,
                                          )),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text('Qty: ${currentQuantity}',
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16.0,
                                          )),
                                    ),
                                  ],
                                ),
                              ]),
                              Container(
                                width: 30.0,
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: IconButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        quantityMap[index] = currentQuantity + 1;
                                        _calculateCartTotal();
                                      });
                                    },
                                    icon: Icon(Icons.add)),
                              ),
                              Container(
                                width: 30.0,
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        if (quantityMap[index] != null && quantityMap[index]! > 1) {
                                          quantityMap[index] = currentQuantity - 1;
                                          _calculateCartTotal();
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.exposure_minus_1)),
                              ),
                            ]),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₱${cartTotalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
