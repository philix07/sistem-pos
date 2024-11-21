import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/blocs/checkout/checkout_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/order/order_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:kerja_praktek/frontend/common/utils/app_printer.dart';
import 'package:kerja_praktek/frontend/presentation/setting/widget/text_description.dart';
import 'package:kerja_praktek/main.dart';
import 'package:kerja_praktek/models/order.dart';

class PaymentProcessDialog extends StatelessWidget {
  const PaymentProcessDialog({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    void saveOrderToDatabase() {
      context.read<OrderBloc>().add(OrderAdd(order: orderModel));
    }

    void printReceipt() {
      AppPrinter appPrinter = AppPrinter();
      appPrinter.print(orderModel);
    }

    return AlertDialog(
      content: Stack(
        children: [
          Container(
            // Provide height to it doesn't take all the available height
            height: 30,
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/cancel.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.redAccent,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/information.svg',
                width: 50,
                height: 50,
                colorFilter: const ColorFilter.mode(
                  AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SpaceHeight(20.0),
              Text(
                'Pastikan pembayaran telah sesuai',
                textAlign: TextAlign.center,
                style: AppTextStyle.black(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SpaceHeight(20.0),
              TextDescripton(
                title: 'NAMA KASIR',
                subtitle: orderModel.cashierName,
              ),
              const SpaceHeight(15.0),
              TextDescripton(
                title: 'METODE PEMBAYARAN',
                subtitle: orderModel.paymentMethod.value,
              ),
              const SpaceHeight(15.0),
              TextDescripton(
                title: 'TOTAL TAGIHAN',
                subtitle: "Rp ${AppFormatter.number(orderModel.totalPrice)}",
              ),
              const SpaceHeight(15.0),
              TextDescripton(
                title: 'WAKTU PEMBAYARAN',
                subtitle: AppFormatter.dateTime(orderModel.createdAt),
              ),
              const SpaceHeight(25.0),

              //* Row That Handles Button
              BlocListener<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderSuccess) {
                    context.read<CheckOutBloc>().add(ClearCheckOut());

                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => AppDialog.show(
                        context,
                        contentColor: AppColor.blue,
                        iconPath: 'assets/icons/information.svg',
                        message: 'Order successfully created',
                        customOnBack: true,
                        onBack: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardPage(),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is OrderError) {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => AppDialog.show(
                        context,
                        iconPath: 'assets/icons/error.svg',
                        message: state.message,
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      title: 'Simpan',
                      width: MediaQuery.of(context).size.width / 3,
                      isActive: true,
                      onTap: () {
                        saveOrderToDatabase();
                      },
                    ),
                    AppButton(
                      title: 'Print',
                      width: MediaQuery.of(context).size.width / 3.5,
                      isRow: true,
                      withIcon: true,
                      iconPath: 'assets/icons/print.svg',
                      isActive: false,
                      onTap: () {
                        saveOrderToDatabase();

                        //! Print The Receipt
                        printReceipt();
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
