import 'dart:io';
import 'dart:ui';

import 'package:kerja_praktek/frontend/common/utils/app_formatter.dart';
import 'package:kerja_praktek/models/order.dart';
import 'package:kerja_praktek/models/product.dart';
import 'package:kerja_praktek/models/report.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class AppPdfGenerator {
  Future<void> createPDF(ReportModel reportModel, String dateInterval) async {
    // create the document
    PdfDocument document = PdfDocument();

    // add single pages to the document
    final page = document.pages.add();

    // draw strings
    page.graphics.drawString(
      'Laporan Keuangan $dateInterval',
      PdfStandardFont(PdfFontFamily.timesRoman, 12),
    );

    page.graphics.drawString(
      'Total Pendapatan : Rp ${AppFormatter.number(reportModel.totalRevenue)}',
      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      bounds: const Rect.fromLTRB(0, 15, 0, 10),
    );

    // manage table section
    //! separate each product based on category
    List<OrderItem> foodsItem = [];
    List<OrderItem> drinksItem = [];
    List<OrderItem> snacksItem = [];

    reportModel.items.forEach(((item) {
      if (item.product.category == ProductCategory.food) {
        foodsItem.add(item);
      } else if (item.product.category == ProductCategory.drink) {
        drinksItem.add(item);
      } else if (item.product.category == ProductCategory.snack) {
        snacksItem.add(item);
      }
    }));

    foodsItem.sort((a, b) => b.quantity.compareTo(a.quantity));

    //! jumlah produk terjual berdasarkan kategori
    PdfGrid grid1 = PdfGrid();
    grid1.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
      cellPadding: PdfPaddings(left: 10, right: 10, top: 5, bottom: 5),
    );

    grid1.columns.add(count: 3);
    grid1.headers.add(1);

    // header
    PdfGridRow header = grid1.headers[0];
    header.cells[0].value = 'Makanan Terjual';
    header.cells[1].value = 'Minuman Terjual';
    header.cells[2].value = 'Snack Terjual';

    // rows
    PdfGridRow row = grid1.rows.add();
    row.cells[0].value = reportModel.foodsSold.toString();
    row.cells[1].value = reportModel.drinksSold.toString();
    row.cells[2].value = reportModel.snacksSold.toString();

    grid1.draw(
      page: page,
      bounds: const Rect.fromLTRB(20, 50, 20, 10),
    )!;

    //! jumlah produk terjual berdasarkan satuan produk
    int highestProductSoldQuantity = 0;
    if (foodsItem.length >= drinksItem.length &&
        foodsItem.length >= snacksItem.length) {
      highestProductSoldQuantity = foodsItem.length;
    } else if (drinksItem.length >= foodsItem.length &&
        drinksItem.length >= snacksItem.length) {
      highestProductSoldQuantity = drinksItem.length;
    } else if (snacksItem.length >= foodsItem.length &&
        snacksItem.length >= drinksItem.length) {
      highestProductSoldQuantity = snacksItem.length;
    }

    PdfGrid grid2 = PdfGrid();
    grid2.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
      cellPadding: PdfPaddings(left: 10, right: 10, top: 5, bottom: 5),
    );

    grid2.columns.add(count: 3);
    grid2.headers.add(1);

    // header
    PdfGridRow header2 = grid2.headers[0];
    header2.cells[0].value = 'Makanan';
    header2.cells[1].value = 'Minuman';
    header2.cells[2].value = 'Snack';

    // print('Highest quantity sold ${highestProductSoldQuantity}');
    // print('Food Item Length ${foodsItem.length}');
    // print('Drink Item Length ${drinksItem.length}');
    // print('Snack Item Length ${snacksItem.length}');

    for (int i = 0; i < highestProductSoldQuantity; i++) {
      String cell0 = '-';
      String cell1 = '-';
      String cell2 = '-';

      if (foodsItem.length > i) {
        cell0 = "${foodsItem[i].product.name} (${foodsItem[i].quantity})";
      }
      if (drinksItem.length > i) {
        cell1 = "${drinksItem[i].product.name} (${drinksItem[i].quantity})";
      }
      if (snacksItem.length > i) {
        cell2 = "${snacksItem[i].product.name} (${snacksItem[i].quantity})";
      }

      PdfGridRow row = grid2.rows.add();
      row.cells[0].value = cell0;
      row.cells[1].value = cell1;
      row.cells[2].value = cell2;
    }

    grid2.draw(
      page: page,
      bounds: const Rect.fromLTRB(20, 140, 20, 10),
    );

    // store all the information into document for print later
    List<int> bytes = await document.save();

    // release all the resources used by document instances
    document.dispose();

    saveAndLaunchFile(bytes, 'Testing.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String filename) async {
    //* decide where to store the file
    final path = (await getExternalStorageDirectory())!.path;

    //* create the file
    final file = File('$path/$filename');
    await file.writeAsBytes(bytes, flush: true);

    //* open the file in our apps
    OpenFile.open('$path/$filename');
  }
}
