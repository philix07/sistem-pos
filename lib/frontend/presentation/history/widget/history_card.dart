import 'package:flutter/material.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    var mainTextStyle = AppTextStyle.blue(
      fontSize: 10.0,
      fontWeight: FontWeight.w700,
    );

    var subTextStyle = AppTextStyle.black(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 6.0,
            blurStyle: BlurStyle.outer,
            color: AppColor.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "METODE PEMBAYARAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          Flexible(child: Text("Tunai", style: subTextStyle)),
          const SpaceHeight(10.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "TOTAL TAGIHAN",
              maxLines: 1,
              style: mainTextStyle,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Rp XXX.XXX.XXX", maxLines: 1, style: subTextStyle),
          ),
          const SpaceHeight(10.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("WAKTU TRANSAKSI", maxLines: 1, style: mainTextStyle),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "25 November, 11:17 ",
              maxLines: 1,
              style: subTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
