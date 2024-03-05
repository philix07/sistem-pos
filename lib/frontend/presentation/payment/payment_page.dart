import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/checkout/checkout_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/order/order_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/formatter.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/data_empty.dart';
import 'package:kerja_praktek/frontend/presentation/payment/widgets/order_card.dart';
import 'package:kerja_praktek/frontend/presentation/payment/widgets/payment_process_dialog.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:uuid/uuid.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _buttonIndex = ValueNotifier(0);
  var _paymentMethod = PaymentMethod.cash;

  void _onButtonTap(int index) {
    setState(() {
      _buttonIndex.value = index;

      if (index == 0) {
        _paymentMethod = PaymentMethod.cash;
      } else if (index == 1) {
        _paymentMethod = PaymentMethod.transfer;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve user information

    return AppScaffold(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            var userData = state.user;
            return BlocBuilder<CheckOutBloc, CheckOutState>(
              builder: (context, state) {
                if (state is CheckOutError) {
                  Future.delayed(const Duration(seconds: 1), () {
                    AppDialog.show(
                      context,
                      iconPath: 'assets/icons/error.svg',
                      message: state.message,
                    );
                  });
                } else if (state is CheckOutSuccess) {
                  if (state.orders.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: const DataEmpty(
                        title: "Tidak Ada Order",
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                "Order Detail",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.blue(fontSize: 16.0),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                //* Clear Order
                                AppDialog.showConfirmationDialog(
                                  context,
                                  iconPath: 'assets/icons/information.svg',
                                  message:
                                      'Are you sure you want to clear the cart?',
                                  onConfirmation: () {
                                    context
                                        .read<CheckOutBloc>()
                                        .add(ClearCheckOut());

                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/icons/trash_can.svg",
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SpaceHeight(10.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.orders.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: OrderCard(
                                  order: state.orders[index],
                                ),
                              );
                            },
                          ),
                        ),
                        const SpaceHeight(10.0),
                        ValueListenableBuilder(
                          valueListenable: _buttonIndex,
                          builder: (context, value, _) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButton(
                                withIcon: true,
                                iconPath: 'assets/icons/cash.svg',
                                iconWidth: 30,
                                iconHeight: 30,
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: MediaQuery.of(context).size.height / 8,
                                fontSize: 14.0,
                                title: "Tunai",
                                isActive: _buttonIndex.value == 0,
                                onTap: () {
                                  _onButtonTap(0);
                                },
                              ),
                              const SpaceWidth(3),
                              AppButton(
                                withIcon: true,
                                iconPath: 'assets/icons/qr_code.svg',
                                iconWidth: 30,
                                iconHeight: 30,
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: MediaQuery.of(context).size.height / 8,
                                fontSize: 14.0,
                                title: "Transfer",
                                isActive: _buttonIndex.value == 1,
                                onTap: () {
                                  _onButtonTap(1);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: InkWell(
                            onTap: () {
                              //* Add Order To The Database
                              var order = OrderModel(
                                id: const Uuid().v4(),
                                cashierId: userData.uid,
                                cashierName: userData.name,
                                paymentMethod: _paymentMethod,
                                orders: state.orders,
                                createdAt: DateTime.now(),
                                totalPrice: state.totalPrice,
                              );

                              showDialog(
                                context: context,
                                builder: (context) => PaymentProcessDialog(
                                  orderModel: order,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Rp ${AppFormatter.number(state.totalPrice)}',
                                  style: AppTextStyle.white(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  'Proses',
                                  style: AppTextStyle.white(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SpaceWidth(10.0),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColor.white,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
