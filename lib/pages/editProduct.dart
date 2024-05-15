import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosperna_ecommerce_exam/functions/functions.dart';
import 'package:prosperna_ecommerce_exam/pages/maintainProduct.dart';
import '../widgets/components.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productIntroController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final ImagePicker _picker = ImagePicker();
  pageFunctions myFunc = pageFunctions();
  final Box box = Hive.box("mybox");
  var index;
  File? image;

  void initState() {
    super.initState();
    print(myFunc.selected_product);
    index = myFunc.selected_product;
    productNameController.text = myFunc.tbl_products[index]['product_name'];
    productIntroController.text = myFunc.tbl_products[index]['product_intro'];
    productDescriptionController.text = myFunc.tbl_products[index]['product_description'];
    productPriceController.text = myFunc.tbl_products[index]['price'];
    image = myFunc.tbl_products[index]['image'];
  }

  Future _pickImage(BuildContext context) async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      image = File(returnedImage.path);
    });
  }

  void updateProduct() {
    if (_formKey.currentState!.validate()) {
      myFunc.tbl_products[index]['product_name'] = productNameController.text;
      myFunc.tbl_products[index]['product_intro'] = productIntroController.text;
      myFunc.tbl_products[index]['product_description'] = productDescriptionController.text;
      myFunc.tbl_products[index]['price'] = productPriceController.text;
      myFunc.tbl_products[index]['image'] = image;

      print('Product Added');

      productNameController.text = "";
      productIntroController.text = "";
      productDescriptionController.text = "";
      productPriceController.text = "";
      setState(() {
        image = null;
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const MaintainProduct(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myComponents.labelTexts(context, "Basic Information"),
                  SizedBox(
                    height: 40.0,
                  ),
                  myComponents.inputLabel(context, 'Product Name:'),
                  TextFormFieldsWidget(
                    thisTextInputType: TextInputType.text,
                    controller: productNameController,
                  ),
                  SizedBox(height: 20.0),
                  myComponents.inputLabel(context, 'Product Introduction:'),
                  TextFormFieldsWidget(
                    thisTextInputType: TextInputType.text,
                    controller: productIntroController,
                  ),
                  SizedBox(height: 20.0),
                  myComponents.inputLabel(context, 'Product Description:'),
                  TextFormFieldsWidget(
                    thisTextInputType: TextInputType.text,
                    controller: productDescriptionController,
                  ),
                  SizedBox(height: 20.0),
                  myComponents.inputLabel(context, 'Price:'),
                  TextFormFieldsWidget(
                    thisTextInputType: TextInputType.number,
                    controller: productPriceController,
                  ),
                  SizedBox(height: 20.0),
                  myComponents.inputLabel(context, 'Add Image:'),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _pickImage(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                      )),
                  image != null ? Image.file(image!) : Text('Select an image'),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: ElevatedButton(
                        onPressed: () {
                          updateProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          )),
    ));
  }
}

class TextFormFieldsWidget extends StatelessWidget {
  TextFormFieldsWidget({super.key, required this.thisTextInputType, required this.controller});
  final TextInputType thisTextInputType;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    pageComponents myComponents = pageComponents();
    return SizedBox(
      // width: double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: thisTextInputType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid input';
          }
          return null;
        },
        decoration: myComponents.textFieldWhite(
          BorderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
