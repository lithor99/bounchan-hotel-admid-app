import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/booksModel.dart';
import 'package:bounchan_hotel_admin_app/pages/book/bookDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryBookPage extends StatefulWidget {
  const HistoryBookPage({super.key});

  @override
  State<HistoryBookPage> createState() => _HistoryBookPageState();
}

class _HistoryBookPageState extends State<HistoryBookPage> {
  BooksModel? _booksModel;
  final _checkInDateController = TextEditingController();
  final _checkOutDateController = TextEditingController();
  late DateTime _selectedCheckInDate;
  late DateTime _selectedCheckOutDate;

  Future getBooks({
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    _booksModel = await getBooksService(
      startDate: startDate,
      endDate: endDate,
    );
    setState(() {});
  }

  Future<void> _selectCheckInDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedCheckInDate = picked;
        _checkInDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
      });
    }
  }

  Future<void> _selectCheckOutDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckOutDate,
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedCheckOutDate = picked;
        _checkOutDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckOutDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedCheckInDate = DateTime.now();
      _selectedCheckOutDate = DateTime.now();
    });
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ປະຫວັດການຈອງ"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2, bottom: 2),
                          child: Text(
                            "ຈາກວັນທີ່",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        TextFormField(
                          controller: _checkInDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 0.5, color: ColorConstants.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstants.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 0.5, color: ColorConstants.white),
                            ),
                            hintText: "YYYY-MM-DD",
                            hintStyle: getRegularStyle(
                                color: ColorConstants.lightGrey),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstants.danger),
                            ),
                            errorStyle:
                                getRegularStyle(color: ColorConstants.danger),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            suffixIcon: InkWell(
                              onTap: () {
                                _selectCheckInDateFunction(context);
                              },
                              child: Icon(
                                Icons.date_range,
                                color: ColorConstants.primary,
                                size: 20,
                              ),
                            ),
                          ),
                          readOnly: true,
                          style: getRegularStyle(color: ColorConstants.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: ColorConstants.primary,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2, bottom: 2),
                          child: Text(
                            "ຫາວັນທີ່",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        TextFormField(
                          controller: _checkOutDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 0.5, color: ColorConstants.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstants.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 0.5, color: ColorConstants.white),
                            ),
                            hintText: "YYYY-MM-DD",
                            hintStyle: getRegularStyle(
                                color: ColorConstants.lightGrey),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstants.danger),
                            ),
                            errorStyle:
                                getRegularStyle(color: ColorConstants.danger),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            suffixIcon: InkWell(
                              onTap: () {
                                _selectCheckOutDateFunction(context);
                              },
                              child: Icon(
                                Icons.date_range,
                                color: ColorConstants.primary,
                              ),
                            ),
                          ),
                          readOnly: true,
                          style: getRegularStyle(color: ColorConstants.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await getBooks();
                          setState(() {
                            _checkInDateController.clear();
                            _checkOutDateController.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.danger,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              color: ColorConstants.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "ລ້າງຂໍ້ມູນ",
                              style: getBoldStyle(
                                color: ColorConstants.white,
                                fontSize: FontSizes.s16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await getBooks(
                            startDate: _checkInDateController.text,
                            endDate: _checkOutDateController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: ColorConstants.black,
                              size: 30,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "ຄົ້ນຫາ",
                              style: getBoldStyle(
                                color: ColorConstants.black,
                                fontSize: FontSizes.s16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _booksModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.white,
                        backgroundColor: ColorConstants.primary,
                      ),
                    )
                  : _booksModel!.result!.rows!.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: Text(
                              "ບໍ່ມີຂໍ້ມູນ",
                              style: getBoldStyle(fontSize: FontSizes.s20),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _booksModel!.result!.rows!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookDetailPage(
                                          id: _booksModel!
                                              .result!.rows![index].id!)),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: index == 0
                                            ? BorderSide(
                                                color: ColorConstants.lightGrey,
                                                width: 0.3)
                                            : BorderSide.none,
                                        bottom: BorderSide(
                                            color: ColorConstants.lightGrey,
                                            width: 0.3))),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 21,
                                      backgroundColor: ColorConstants.black,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: ColorConstants.primary,
                                        backgroundImage: _booksModel!
                                                        .result!
                                                        .rows![index]
                                                        .member!
                                                        .image !=
                                                    null &&
                                                _booksModel!
                                                        .result!
                                                        .rows![index]
                                                        .member!
                                                        .image !=
                                                    ""
                                            ? NetworkImage(_booksModel!.result!
                                                .rows![index].member!.image!)
                                            : null,
                                        child: _booksModel!.result!.rows![index]
                                                        .member!.image ==
                                                    null ||
                                                _booksModel!
                                                        .result!
                                                        .rows![index]
                                                        .member!
                                                        .image ==
                                                    ""
                                            ? Icon(
                                                Icons.person,
                                                color: ColorConstants.black,
                                                size: 35,
                                              )
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_booksModel!.result!.rows![index].member!.gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                                  "${_booksModel!.result!.rows![index].member!.name} "
                                                  "${_booksModel!.result!.rows![index].member!.lastName}" +
                                              " | " +
                                              "${_booksModel!.result!.rows![index].createdAt!.substring(0, 10)}",
                                          style: getRegularStyle(
                                              color: ColorConstants.white),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "ແຈ້ງເຂົ້າ: ${_booksModel!.result!.rows![index].checkInDate!.substring(0, 10)} | ແຈ້ງອອກ: ${_booksModel!.result!.rows![index].checkOutDate!.substring(0, 10)}",
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey,
                                              fontSize: FontSizes.s12),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          _booksModel!.result!.rows![index]
                                                      .status ==
                                                  1
                                              ? "ສະຖານະ: ລໍຖ້າແຈ້ງເຂົ້າ"
                                              : _booksModel!
                                                          .result!
                                                          .rows![index]
                                                          .status ==
                                                      2
                                                  ? "ສະຖານະ: ລໍຖ້າແຈ້ງອອກ"
                                                  : _booksModel!
                                                              .result!
                                                              .rows![index]
                                                              .status ==
                                                          3
                                                      ? "ສະຖານະ: ແຈ້ງອອກແລ້ວ"
                                                      : "ສະຖານະ: ຍົກເລີກການຈອງ",
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey,
                                              fontSize: FontSizes.s12),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorConstants.primary,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
