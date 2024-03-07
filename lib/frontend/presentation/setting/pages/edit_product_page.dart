import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:kerja_praktek/frontend/presentation/setting/widget/edit_product_card.dart';
import 'package:kerja_praktek/frontend/blocs/product/product_bloc.dart';
import 'package:kerja_praktek/models/product.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackBar(title: "Edit Product"),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductError) {
                Future.delayed(
                  const Duration(seconds: 1),
                  () => AppDialog.show(
                    context,
                    iconPath: 'assets/icons/error.svg',
                    message: state.message,
                  ),
                );
              } else if (state is ProductSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return EditProductCard(
                        product: state.products[index],
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
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
  late Product product;

  var mainTextStyle = AppTextStyle.black(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  File? image;
  bool isNewProductImage = false;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var category = ProductCategory.none.value;

  @override
  void initState() {
    product = widget.product;
    category = product.category.value;
    nameController.text = product.name;
    priceController.text = product.price.toString();
    super.initState();
  }

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
                        image: isNewProductImage == true
                            ? DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(image!),
                              )
                            : DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(product.image),
                              ),
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
                            isNewProductImage = true;
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
                  value: category,
                  padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  underline: Container(),
                  iconSize: 40,
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue!;
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
                onTap: () async {
                  //TODO: Update Product
                  context.read<ProductBloc>().add(ProductUpdate(
                        isNewImage: isNewProductImage,
                        product: Product(
                          id: product.id,
                          image: isNewProductImage == true
                              ? image!.path
                              : product.image,
                          name: nameController.text,
                          category: ProductCategory.fromString(category),
                          price: int.parse(priceController.text),
                          isAvailable: true,
                        ),
                      ));

                  //TODO: There's flaw in this implementation.
                  // error might occur while updating product
                  AppDialog.show(
                    context,
                    contentColor: AppColor.blue,
                    iconPath: 'assets/icons/information.svg',
                    message: "Successfully updated product",
                    customOnBack: true,
                    onBack: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SpaceHeight(8.0),
              SizedBox(
                width: double.maxFinite,
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    //TODO: Show Confirmation Dialog
                    AppDialog.showConfirmationDialog(
                      context,
                      iconPath: 'assets/icons/cancel.svg',
                      message: "Are you sure you want to discard the edit?",
                      onConfirmation: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
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
                        "Discard Edit",
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
