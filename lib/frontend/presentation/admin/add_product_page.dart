import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kerja_praktek/frontend/common/components/app_back_bar.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/app_text_field.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  var mainTextStyle = AppTextStyle.black(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  File? image;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var selectedCategory = "Makanan";

  @override
  Widget build(BuildContext context) {
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
                title: "Save",
                isActive: true,
                width: double.maxFinite,
                height: 60.0,
                onTap: () {},
              ),
              const SpaceHeight(8.0),
              SizedBox(
                width: double.maxFinite,
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    //TODO: Show Confirmation Dialog First

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
