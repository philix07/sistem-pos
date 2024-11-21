import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerja_praktek/frontend/blocs/auth/auth_bloc.dart';
import 'package:kerja_praktek/frontend/blocs/history/history_bloc.dart';
import 'package:kerja_praktek/frontend/common/components/app_dialog.dart';
import 'package:kerja_praktek/frontend/common/components/spaces.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/frontend/common/utils/form_validator.dart';
import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:kerja_praktek/frontend/presentation/history/widget/order_detail_dialog.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/user.dart';

class SuccessHistoryCard extends StatelessWidget {
  const SuccessHistoryCard({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var mainTextStyle = AppTextStyle.blue(
      fontSize: 10.0,
      fontWeight: FontWeight.w700,
    );

    var subTextStyle = AppTextStyle.black(
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );

    var textController = TextEditingController();
    var formValidator = AppFormValidator();
    var appUser = context.read<AuthBloc>().appUser;

    bool canDeleteOrder(UserRole role) {
      if (role == UserRole.supervisor || role == UserRole.owner) {
        return true;
      }
      return false;
    }

    return InkWell(
      onTap: () {
        //* Display Order Detail
        showDialog(
          context: context,
          builder: (context) => OrderDetailDialog(orderModel: orderModel),
        );
      },
      child: Container(
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
        child: Stack(
          children: [
            //* column that handle history card
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Cashier Name
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "NAMA KASIR",
                    maxLines: 1,
                    style: mainTextStyle,
                  ),
                ),
                Flexible(
                  child: Text(
                    orderModel.cashierName,
                    style: subTextStyle,
                  ),
                ),
                const SpaceHeight(5.0),

                //* Total Price
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
                  child: Text(
                    "Rp ${AppFormatter.number(orderModel.totalPrice)}",
                    maxLines: 1,
                    style: subTextStyle,
                  ),
                ),
                const SpaceHeight(5.0),

                //* Transaction Date
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("WAKTU TRANSAKSI",
                      maxLines: 1, style: mainTextStyle),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppFormatter.dateTime(orderModel.createdAt),
                    maxLines: 1,
                    style: subTextStyle,
                  ),
                ),
              ],
            ),

            //* container that handles delete button
            canDeleteOrder(appUser.role)
                ? Container(
                    // Provide height to it doesn't take all the available height
                    height: 30,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        //* Ask For Deletion Reason And Then Set
                        showDialog(
                          context: context,
                          builder: (context) => Form(
                            key: formValidator.formState,
                            child: AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Deletion Reason',
                                    style: AppTextStyle.blue(fontSize: 18.0),
                                  ),
                                  const SpaceHeight(20.0),
                                  TextFormField(
                                    controller: textController,
                                    maxLines: null, // Allow unlimited lines
                                    keyboardType: TextInputType.multiline,
                                    validator: (val) {
                                      if (val == '' || val == null) {
                                        return "Insert Deletion Reason";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'What is your deletion reason?',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  BlocListener<HistoryBloc, HistoryState>(
                                    listener: (context, state) {
                                      if (state is HistorySuccess) {
                                        Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () => AppDialog.show(
                                            context,
                                            iconPath:
                                                'assets/icons/information.svg',
                                            message:
                                                'Order Successfully Deleted',
                                            customOnBack: true,
                                            onBack: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        if (formValidator
                                            .formState.currentState!
                                            .validate()) {
                                          context.read<HistoryBloc>().add(
                                                HistoryDelete(
                                                  id: orderModel.id,
                                                  deletionReason:
                                                      textController.text,
                                                ),
                                              );
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        height: 45,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 5.0,
                                              blurStyle: BlurStyle.outer,
                                              spreadRadius: 0,
                                              color: AppColor.black
                                                  .withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          'Delete',
                                          style: AppTextStyle.white(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
