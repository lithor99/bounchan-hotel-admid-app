import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/bookBodyModel.dart';
import 'package:bounchan_hotel_admin_app/models/bookResponseModel.dart';
import 'package:bounchan_hotel_admin_app/pages/manualBook/manualBookSuccessPage.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManualBookDetailPage extends StatelessWidget {
  const ManualBookDetailPage(
      {super.key, required this.bookBodyModel, required this.totalBookDays});
  final BookBodyModel bookBodyModel;
  final int totalBookDays;

  @override
  Widget build(BuildContext context) {
    final _loadingKey = GlobalKey<State>();
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດການຈອງ"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text("ວັນທີ່ແຈ້ງເຂົ້າ",
                            style: getRegularStyle(
                                fontSize: FontSizes.s12,
                                color: ColorConstants.lightGrey)),
                        Text("${bookBodyModel.item!.checkInDate}",
                            style: getBoldStyle(fontSize: FontSizes.s18)),
                      ],
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: ColorConstants.primary,
                      size: 30,
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text("ວັນທີ່ແຈ້ງອອກ",
                            style: getRegularStyle(
                                fontSize: FontSizes.s12,
                                color: ColorConstants.lightGrey)),
                        Text("${bookBodyModel.item!.checkOutDate}",
                            style: getBoldStyle(fontSize: FontSizes.s18)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("ຈຳນວນ: $totalBookDays ວັນ",
                    style: getBoldStyle(fontSize: FontSizes.s18)),
                SizedBox(height: 10),
                DataTable(
                  border: TableBorder.all(
                      width: 0.5, color: ColorConstants.lightGrey),
                  columnSpacing: 50,
                  columns: [
                    DataColumn(
                      label: Text('ລຳດັບ', style: getBoldStyle()),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('ເບີຫ້ອງ', style: getBoldStyle()),
                    ),
                    DataColumn(
                      label: Text('ລາຄາ', style: getBoldStyle()),
                      numeric: true,
                    ),
                    // DataColumn(
                    //   label: Text('ລຶບ', style: getBoldStyle()),
                    // ),
                  ],
                  rows: [
                    for (int i = 0; i < bookBodyModel.item!.rooms!.length; i++)
                      DataRow(
                        cells: [
                          DataCell(Text('${i + 1}', style: getRegularStyle())),
                          DataCell(Text(
                              'ຫ້ອງເບີ: ${bookBodyModel.item!.rooms![i].roomNo ?? ""}',
                              style: getRegularStyle())),
                          DataCell(Text(
                              '${NumberFormat("#,### ກີບ").format(bookBodyModel.item!.rooms![i].price ?? 0)}',
                              style: getRegularStyle())),
                          // DataCell(InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       widget.bookBodyModel.item!.rooms!.remove(
                          //           widget.bookBodyModel.item!.rooms![i]);
                          //     });
                          //   },
                          //   child: Icon(
                          //     Icons.delete,
                          //     color: ColorConstants.danger,
                          //   ),
                          // )),
                        ],
                      )
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("ລວມທັງໝົດ:",
                        style: getBoldStyle(fontSize: FontSizes.s18)),
                    SizedBox(width: 10),
                    Text(
                        "${NumberFormat("#,### ກີບ").format(bookBodyModel.item!.amount ?? 0)}",
                        style: getBoldStyle(
                            fontSize: FontSizes.s18,
                            color: ColorConstants.danger)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: ColorConstants.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 2 - 1,
                child: InkWell(
                  onTap: () async {
                    LoadingDialogWidget.showLoading(context, _loadingKey);
                    BookResponseModel? result =
                        await bookService(bookBodyModel: bookBodyModel);

                    Navigator.of(_loadingKey.currentContext!,
                            rootNavigator: true)
                        .pop();
                    if (result != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManualBookSuccessPage(
                                bookResponseModel: result)),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ErrorDialogWidget(
                            detail: "ເກີດຂໍ້ຜິດພາດ",
                          );
                        },
                      );
                    }
                  },
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ບັນທຶກ",
                        style: getBoldStyle(
                          color: ColorConstants.black,
                          fontSize: FontSizes.s18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
