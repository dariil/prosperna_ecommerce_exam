import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prosperna_ecommerce_exam/functions/functions.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  pageFunctions myFunc = pageFunctions();
  var index;
  File? image;

  void initState() {
    super.initState();
    print(myFunc.selected_product);
    index = myFunc.selected_product;
    image = myFunc.tbl_products[index]['image'];
  }

  void addToCart() {
    myFunc.tbl_cart.add({
      "id": myFunc.tbl_products[index]['product_id'],
      "product_name": myFunc.tbl_products[index]['product_name'],
      "product_intro": myFunc.tbl_products[index]['product_intro'],
      "price": myFunc.tbl_products[index]['price'],
      "image": myFunc.tbl_products[index]['image'],
    });
    print("Product Successfully Added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myFunc.tbl_products[index]['image'] != null
                ? Image.file(
                    myFunc.tbl_products[index]['image']!,
                    width: MediaQuery.of(context).size.width * 1,
                    height: 290,
                  )
                : Text(''),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              // height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                myFunc.tbl_products[index]['product_name'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              // height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                '₱${myFunc.tbl_products[index]['price']}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              myFunc.tbl_products[index]['product_intro'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            Divider(
              thickness: 1.0,
              height: 20.0,
              color: Colors.grey,
              indent: 0.0,
              endIndent: 0.0,
            ),
            Container(
              // width: MediaQuery.of(context).size.width * 0.4,
              // height: MediaQuery.of(context).size.height * 1,
              child: Text(
                myFunc.tbl_products[index]['product_description'],
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                      onPressed: () {
                        // do nothing
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Buy",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                      onPressed: () {
                        addToCart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
