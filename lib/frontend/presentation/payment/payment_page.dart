import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/formatter.dart';
import 'package:kerja_praktek/frontend/presentation/home/bloc/order/order_bloc.dart';
import 'package:kerja_praktek/frontend/presentation/home/widgets/data_empty.dart';
import 'package:kerja_praktek/frontend/presentation/payment/widgets/order_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _buttonIndex = ValueNotifier(0);

  void _onButtonTap(int index) {
    setState(() {
      _buttonIndex.value = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderError) {
            //TODO: Handle Order Error
          } else if (state is OrderSuccess) {
            if (state.orders.isEmpty) {
              return const Expanded(
                child: DataEmpty(
                  title: "Tidak Ada Order",
                ),
              );
            } else {
              var orders = context.read<OrderBloc>().orders;
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
                          //TODO: Clear Order
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
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          child: OrderCard(
                            order: orders[index],
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
                          iconPath: 'assets/icons/trash_can.svg',
                          iconWidth: 25,
                          iconHeight: 25,
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
                          iconPath: 'assets/icons/trash_can.svg',
                          iconWidth: 25,
                          iconHeight: 25,
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
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: InkWell(
                      onTap: () {
                        AppDialog.show(
                          context,
                          contentColor: AppColor.primary,
                          iconPath: 'assets/icons/information.svg',
                          message: "Coming Soon Capek Ui",
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          print("Current state is $state");
          return const SizedBox();
        },
      ),
    );
  }
}
