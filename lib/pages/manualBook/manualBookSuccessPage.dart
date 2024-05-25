import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/bookModel.dart';
import 'package:bounchan_hotel_admin_app/models/bookResponseModel.dart';
import 'package:bounchan_hotel_admin_app/pages/home/homePage.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ManualBookSuccessPage extends StatefulWidget {
  const ManualBookSuccessPage({super.key, required this.bookResponseModel});
  final BookResponseModel bookResponseModel;

  @override
  State<ManualBookSuccessPage> createState() => _ManualBookSuccessPageState();
}

class _ManualBookSuccessPageState extends State<ManualBookSuccessPage> {
  BookModel? _bookModel;
  Future getBookDetail() async {
    _bookModel = await getBookService(id: widget.bookResponseModel.result!.id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBookDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: _bookModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg_success.png"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                            "${_bookModel!.result!.createdAt!.substring(0, 10)}",
                            style: getRegularStyle(
                                fontSize: FontSizes.s14,
                                color: ColorConstants.black)),
                        SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: ColorConstants.success),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text("ຈອງສຳເລັດ",
                                style: getBoldStyle(
                                    fontSize: FontSizes.s18,
                                    color: ColorConstants.success)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                              "${_bookModel!.result!.createdAt!.substring(11, 19)}",
                              style: getRegularStyle(
                                  fontSize: FontSizes.s14,
                                  color: ColorConstants.black)),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text("ວັນທີ່ແຈ້ງເຂົ້າ",
                                style: getRegularStyle(
                                    fontSize: FontSizes.s12,
                                    color: ColorConstants.darkGrey)),
                            Text(
                                "${_bookModel!.result!.checkInDate!.substring(0, 10)}",
                                style: getBoldStyle(
                                    fontSize: FontSizes.s18,
                                    color: ColorConstants.danger)),
                          ],
                        ),
                        SizedBox(width: 35),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: ColorConstants.black,
                          size: 40,
                        ),
                        SizedBox(width: 35),
                        Column(
                          children: [
                            Text("ວັນທີ່ແຈ້ງອອກ",
                                style: getRegularStyle(
                                    fontSize: FontSizes.s12,
                                    color: ColorConstants.darkGrey)),
                            Text(
                                "${_bookModel!.result!.checkOutDate!.substring(0, 10)}",
                                style: getBoldStyle(
                                    fontSize: FontSizes.s18,
                                    color: ColorConstants.danger)),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: DataTable(
                        headingRowHeight: 40,
                        dataRowHeight: 40,
                        border: TableBorder.all(
                            width: 0.5, color: ColorConstants.darkGrey),
                        columnSpacing: 50,
                        columns: [
                          DataColumn(
                            label: Text('ລຳດັບ',
                                style:
                                    getBoldStyle(color: ColorConstants.black)),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Text('ເບີຫ້ອງ',
                                style:
                                    getBoldStyle(color: ColorConstants.black)),
                          ),
                          DataColumn(
                            label: Text('ລາຄາ',
                                style:
                                    getBoldStyle(color: ColorConstants.black)),
                            numeric: true,
                          ),
                        ],
                        rows: [
                          for (int i = 0;
                              i < _bookModel!.result!.bookDetails!.length;
                              i++)
                            DataRow(
                              cells: [
                                DataCell(Text('${i + 1}',
                                    style: getRegularStyle(
                                        color: ColorConstants.black))),
                                DataCell(Text(
                                    'ຫ້ອງເບີ: ${_bookModel!.result!.bookDetails![i].roomNo!}',
                                    style: getRegularStyle(
                                      color: ColorConstants.black,
                                    ))),
                                DataCell(Text(
                                    '${NumberFormat("#,### ກີບ").format(_bookModel!.result!.bookDetails![i].price ?? 0)}',
                                    style: getRegularStyle(
                                        color: ColorConstants.black))),
                              ],
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text("ລວມທັງໝົດ:",
                            style: getBoldStyle(
                                fontSize: FontSizes.s18,
                                color: ColorConstants.black)),
                        SizedBox(width: 20),
                        Text(
                            "${NumberFormat("#,### ກີບ").format(_bookModel!.result!.amount ?? 0)}",
                            style: getBoldStyle(
                                fontSize: FontSizes.s18,
                                color: ColorConstants.danger)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 3, color: ColorConstants.success),
                          borderRadius: BorderRadius.circular(6)),
                      child: QrImageView(
                        data: _bookModel!.result!.id!,
                        version: QrVersions.auto,
                        size: 260.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: ColorConstants.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: ColorConstants.success,
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
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    },
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ສຳເລັດ",
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
      ),
    );
  }
}
