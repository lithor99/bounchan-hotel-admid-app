import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/booksModel.dart';
import 'package:bounchan_hotel_admin_app/pages/book/bookDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  BooksModel? _checkInList;
  Future getCheckInList() async {
    _checkInList = await getBooksService(status: "1");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCheckInList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍການລໍແຈ້ງເຂົ້າ"),
      ),
      body: _checkInList == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : _checkInList!.result!.rows!.isEmpty
              ? Center(
                  child: Text(
                    "ບໍ່ມີຂໍ້ມູນ",
                    style: getBoldStyle(fontSize: FontSizes.s20),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: _checkInList!.result!.rows!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                    id: _checkInList!
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
                                  backgroundImage: _checkInList!.result!
                                                  .rows![index].member!.image !=
                                              null &&
                                          _checkInList!.result!.rows![index]
                                                  .member!.image !=
                                              ""
                                      ? NetworkImage(_checkInList!
                                          .result!.rows![index].member!.image!)
                                      : null,
                                  child: _checkInList!.result!.rows![index]
                                                  .member!.image ==
                                              null ||
                                          _checkInList!.result!.rows![index]
                                                  .member!.image ==
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_checkInList!.result!.rows![index].member!.gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                            "${_checkInList!.result!.rows![index].member!.name} "
                                            "${_checkInList!.result!.rows![index].member!.lastName}" +
                                        " | " +
                                        "${_checkInList!.result!.rows![index].createdAt!.substring(0, 10)}",
                                    style: getRegularStyle(
                                        color: ColorConstants.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "ແຈ້ງເຂົ້າ: ${_checkInList!.result!.rows![index].checkInDate!.substring(0, 10)} | ແຈ້ງອອກ: ${_checkInList!.result!.rows![index].checkOutDate!.substring(0, 10)}",
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
                ),
    );
  }
}
