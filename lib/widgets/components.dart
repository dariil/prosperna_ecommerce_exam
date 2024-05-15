import 'package:flutter/material.dart';

class pageComponents {
  AppBar appBar({scaffoldKey}) {
    return AppBar(
      backgroundColor: Color.fromRGBO(44, 177, 230, 1.0),
      centerTitle: true,
      title: Text(
        'Prosperna E-commerce',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        color: Colors.white,
      ),
    );
  }

  Text labelTexts(BuildContext context, String labelText) {
    return Text(
      labelText,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text inputLabel(BuildContext context, String inputLabel) {
    return Text(
      inputLabel,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  InputDecoration textFieldWhite({required BorderRadius}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius,
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
    );
  }

  Column configItems(
    BuildContext context,
    String product_name,
    String product_intro,
    String product_description,
    String product_price,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: Container(
            height: 200,
            color: Colors.blue[400],
            child: Center(
                child: Text(product_name,
                    style: TextStyle(
                      fontSize: 50.0,
                    ))),
          ),
        ),
        // Image(
        //   image: AssetImage("assets/general/citybg.png"),
        // ),
      ],
    );
  }
}
