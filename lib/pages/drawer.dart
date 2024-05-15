import 'package:flutter/material.dart';
import 'package:prosperna_ecommerce_exam/pages/cart.dart';
import 'package:prosperna_ecommerce_exam/pages/maintainProduct.dart';
import 'package:prosperna_ecommerce_exam/pages/store.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildMenuItems(context),
        ],
      ),
    ));
  }
}

Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.only(top: 14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Add/Edit Products'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MaintainProduct()),
          ),
        ),
        ListTile(
          title: Text('Store'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => StorePage()),
          ),
        ),
        ListTile(
          title: Text('Cart'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Cart()),
          ),
        )
      ],
    ));
