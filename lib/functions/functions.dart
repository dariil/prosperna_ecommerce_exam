import 'package:hive_flutter/adapters.dart';

class pageFunctions {
  final Box box = Hive.box("mybox");

  static List<Map<dynamic, dynamic>> _tbl_products = [];
  List<Map<dynamic, dynamic>> get tbl_products => _tbl_products;

  set tbl_users(List<Map<dynamic, dynamic>> value) {
    _tbl_products = value;
  }

  static List<Map<dynamic, dynamic>> _tbl_cart = [];
  List<Map<dynamic, dynamic>> get tbl_cart => _tbl_cart;

  set tbl_cart(List<Map<dynamic, dynamic>> value) {
    _tbl_cart = value;
  }

  static int _product_id = 0;
  int get product_id => _product_id;

  set product_id(int value) {
    _product_id = value;
  }

  static int? _selected_product;
  int get selected_product => _selected_product!;

  set selected_product(int value) {
    _selected_product = value;
  }
}
