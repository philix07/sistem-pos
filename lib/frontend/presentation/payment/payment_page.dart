import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/common/components/app_button.dart';
import 'package:kerja_praktek/frontend/common/components/app_scaffold.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
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
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
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
                  //TODO: Cancel Order
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
          const OrderCard(),
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
            child: Row(
              children: [
                Text(
                  'Rp X.XXX.XXX',
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
        ],
      ),
    );
  }
}
