import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/bookModel.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/warningDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.id});
  final String id;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final _loadingKey = GlobalKey<State>();
  BookModel? _bookModel;
  Future getBookDetail() async {
    _bookModel = await getBookService(id: widget.id);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBookDetail();
  }

  @override
  Widget build(BuildContext context) {
    if (_bookModel == null) {
      return Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          title: Text("ລາຍລະອຽດ"),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: ColorConstants.white,
            backgroundColor: ColorConstants.primary,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text(_bookModel == null
            ? "ລາຍລະອຽດ"
            : _bookModel!.result!.status == 1
                ? "ແຈ້ງເຂົ້າ"
                : _bookModel!.result!.status == 2
                    ? "ແຈ້ງອອກ"
                    : "ລາຍລະອຽດ"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Container(
            width: MediaQuery.of(context).size.width - 12,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorConstants.white),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ຊື່:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.member!.name ?? ""}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ນາມສະກຸນ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.member!.lastName ?? ""}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ເບີໂທ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.member!.phoneNumber ?? ""}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ອີເມລ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.member!.email ?? ""}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີແຈ້ງເຂົ້າ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.checkInDate!.substring(0, 10)}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີ່ແຈ້ງອອກ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${_bookModel!.result!.checkOutDate!.substring(0, 10)}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີຈອງ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          "${DateTime.parse(_bookModel!.result!.createdAt!).toLocal().toString().substring(0, 10)}  ${DateTime.parse(_bookModel!.result!.createdAt!).toLocal().toString().substring(11, 19)}",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ເລກບິນ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: _bookModel!.result!.billNo ?? "",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Text(
                            _bookModel!.result!.status == 1
                                ? " ລໍຖ້າແຈ້ງເຂົ້າ"
                                : _bookModel!.result!.status == 2
                                    ? " ລໍຖ້າແຈ້ງອອກ"
                                    : _bookModel!.result!.status == 3
                                        ? " ແຈ້ງອອກແລ້ວ"
                                        : " ຍົກເລີກການຈອງ",
                            style: getBoldStyle(
                              fontSize: FontSizes.s18,
                              color: _bookModel!.result!.status == 1
                                  ? ColorConstants.info
                                  : _bookModel!.result!.status == 2
                                      ? ColorConstants.success
                                      : _bookModel!.result!.status == 3
                                          ? ColorConstants.black
                                          : ColorConstants.error,
                            )),
                      ),
                    ],
                  ),
                ),
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
                  ],
                  rows: [
                    for (int i = 0;
                        i < _bookModel!.result!.bookDetails!.length;
                        i++)
                      DataRow(
                        cells: [
                          DataCell(Text('${i + 1}', style: getRegularStyle())),
                          DataCell(Text(
                              'ຫ້ອງເບີ: ${_bookModel!.result!.bookDetails![i].roomNo ?? ""}',
                              style: getRegularStyle())),
                          DataCell(Text(
                              '${NumberFormat("#,### ກີບ").format(_bookModel!.result!.bookDetails![i].price ?? 0)}',
                              style: getRegularStyle())),
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
                        "${NumberFormat("#,### ກີບ").format(_bookModel!.result!.amount ?? 0)}",
                        style: getBoldStyle(
                            fontSize: FontSizes.s18,
                            color: ColorConstants.danger)),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bookModel == null
          ? null
          : _bookModel!.result!.status == 3 || _bookModel!.result!.status == 4
              ? null
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                              String result = "";
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return WarningDialogWidget(
                                    detail: "ທ່ານຕ້ອງການຍົກເລີກການຈອງບໍ?",
                                    onConfirm: () async {
                                      LoadingDialogWidget.showLoading(
                                          context, _loadingKey);
                                      result = await cancelBookService(
                                          bookId: widget.id);
                                      Navigator.of(_loadingKey.currentContext!,
                                              rootNavigator: true)
                                          .pop();
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                              if (result == "success") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SuccessDialogWidget(
                                        detail: "ຍົກເລີກສຳເລັດ");
                                  },
                                ).then((value) => getBookDetail());
                              } else if (result == "failed") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ErrorDialogWidget(
                                        detail: "ຍົກເລີກບໍ່ສຳເລັດ");
                                  },
                                );
                              }
                            },
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cancel_outlined,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "ຍົກເລີກ",
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
                      VerticalDivider(color: ColorConstants.black),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 2 - 1,
                          child: InkWell(
                            onTap: () async {
                              if (_bookModel!.result!.status == 1) {
                                String result = "";
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WarningDialogWidget(
                                      detail: "ຢືນຢັນການແຈ້ງເຂົ້າ",
                                      onConfirm: () async {
                                        LoadingDialogWidget.showLoading(
                                            context, _loadingKey);
                                        result = await checkInService(
                                            bookId: widget.id);

                                        Navigator.of(
                                                _loadingKey.currentContext!,
                                                rootNavigator: true)
                                            .pop();
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                                if (result == "success") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SuccessDialogWidget(
                                          detail: "ແຈ້ງເຂົ້າສຳເລັດ");
                                    },
                                  ).then((value) => getBookDetail());
                                } else if (result == "failed") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ErrorDialogWidget(
                                          detail: "ແຈ້ງເຂົ້າບໍ່ສຳເລັດ");
                                    },
                                  );
                                }
                              } else if (_bookModel!.result!.status == 2) {
                                String result = "";
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WarningDialogWidget(
                                      detail: "ຢືນຢັນການແຈ້ງອອກ",
                                      onConfirm: () async {
                                        LoadingDialogWidget.showLoading(
                                            context, _loadingKey);
                                        result = await checkOutService(
                                            bookId: widget.id);
                                        Navigator.of(
                                                _loadingKey.currentContext!,
                                                rootNavigator: true)
                                            .pop();
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                                if (result == "success") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SuccessDialogWidget(
                                          detail: "ແຈ້ງອອກສຳເລັດ");
                                    },
                                  ).then((value) => getBookDetail());
                                } else if (result == "failed") {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ErrorDialogWidget(
                                          detail: "ແຈ້ງອອກບໍ່ສຳເລັດ");
                                    },
                                  );
                                }
                              }
                            },
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _bookModel!.result!.status == 1
                                      ? "ແຈ້ງເຂົ້າ"
                                      : _bookModel!.result!.status == 2
                                          ? "ແຈ້ງອອກ"
                                          : "",
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
