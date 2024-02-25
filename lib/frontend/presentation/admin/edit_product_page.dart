import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/app_text_field.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/form_validator.dart';
import 'package:kerja_praktek/frontend/presentation/admin/widget/edit_product_card.dart';
import 'package:kerja_praktek/models/product.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Product(
      id: 'asd',
      image: 'assets/icons/food.svg',
      name: 'Ayam Goreng Yang Sangat Yang Sangat Yang Sangat Yang Sangat',
      category: ProductCategory.drink,
      price: 240000,
      isAvailable: true,
    );

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackBar(title: "Edit Product"),
          EditProductCard(
            product: product,
          ),
        ],
      ),
    );
  }
}

class EditProductPageDetail extends StatefulWidget {
  const EditProductPageDetail({super.key, required this.product});

  final Product product;

  @override
  State<EditProductPageDetail> createState() => _EditProductPageDetailState();
}

class _EditProductPageDetailState extends State<EditProductPageDetail> {
  @override
  Widget build(BuildContext context) {
    var mainTextStyle = AppTextStyle.black(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

    var product = widget.product;

    File? image;
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    var selectedCategory = "Makanan";

    nameController.text = product.name;
    priceController.text = product.price.toString();
    selectedCategory = product.category.value;

    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackBar(title: "Add Product"),
              Text(
                "Product Name",
                style: mainTextStyle,
              ),
              AppTextField(
                controller: nameController,
                labelText: "Name",
                inputFormatter: AppFormValidator().textOnly(),
                validator: (val) => AppFormValidator().validateNotNull(val),
                fontSize: 16.0,
              ),
              const SpaceHeight(20.0),
              Text(
                "Product Price",
                style: mainTextStyle,
              ),
              AppTextField(
                controller: priceController,
                labelText: "Price",
                inputFormatter: AppFormValidator().numberOnly(),
                validator: (val) => AppFormValidator().validateNotNull(val),
                fontSize: 16.0,
              ),
              const SpaceHeight(30.0),
              Text(
                "Product's Picture",
                style: mainTextStyle,
              ),
              Container(
                width: double.maxFinite,
                height: 90,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(vertical: 7.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primary, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        image: image == null
                            ? const DecorationImage(
                                image: AssetImage(
                                "assets/images/pick-image.png",
                              ))
                            : DecorationImage(image: FileImage(image!)),
                      ),
                    ),
                    AppButton(
                      title: "Choose Image",
                      isActive: true,
                      onTap: () async {
                        final imagePicker = ImagePicker();
                        final pickedFile = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (pickedFile != null) {
                          setState(() {
                            image = File(pickedFile.path);
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              const SpaceHeight(30.0),
              Text(
                "Category",
                style: mainTextStyle,
              ),
              const SpaceHeight(7.0),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primary, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  underline: Container(),
                  iconSize: 40,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: <String>['Makanan', 'Minuman', 'Snack', 'None'].map(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTextStyle.blue(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SpaceHeight(50.0),
              AppButton(
                title: "Update",
                isActive: true,
                width: double.maxFinite,
                height: 60.0,
                onTap: () {
                  //TODO: Update Product
                },
              ),
              const SpaceHeight(8.0),
              SizedBox(
                width: double.maxFinite,
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    //TODO: Show Confirmation Dialog First
                    AppDialog.show(
                      context,
                      iconPath: 'assets/icons/cancel.svg',
                      message: "Are you sure you want to delete the product?",
                    );
                    
                    //TODO: CANCEL ADD PRODUCT
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/trash_can.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SpaceWidth(10.0),
                      const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
