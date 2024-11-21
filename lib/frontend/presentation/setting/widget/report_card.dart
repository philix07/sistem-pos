import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kerja_praktek/frontend/common/components/app_card.dart';
import 'package:kerja_praktek/frontend/common/style/app_colors.dart';
import 'package:kerja_praktek/frontend/common/style/app_style.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';

class ReportSummarizeCard extends StatefulWidget {
  const ReportSummarizeCard({super.key, required this.items});

  final List<OrderItem> items;

  @override
  State<ReportSummarizeCard> createState() => _ReportSummarizeCardState();
}

class _ReportSummarizeCardState extends State<ReportSummarizeCard> {
  List<OrderItem> foodsItem = [];
  List<OrderItem> drinksItem = [];
  List<OrderItem> snacksItem = [];

  @override
  void initState() {
    _splitItemByCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReportCard(items: foodsItem, category: 'Makanan'),
          ReportCard(items: drinksItem, category: 'Minuman'),
          ReportCard(items: snacksItem, category: 'Snack'),
        ],
      ),
    );
  }

  void _splitItemByCategories() {
    widget.items.forEach(((item) {
      if (item.product.category == ProductCategory.food) {
        foodsItem.add(item);
      } else if (item.product.category == ProductCategory.drink) {
        drinksItem.add(item);
      } else if (item.product.category == ProductCategory.snack) {
        snacksItem.add(item);
      }
    }));

    foodsItem.sort((a, b) => b.quantity.compareTo(a.quantity));
  }
}

//* each category have different report card
class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.items,
    required this.category,
  });

  final List<OrderItem> items;
  final String category;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: AppTextStyle.black(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: items.length * 30,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\t\t> ${items[index].product.name}'),
                    Text('${items[index].quantity}\t\t'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
