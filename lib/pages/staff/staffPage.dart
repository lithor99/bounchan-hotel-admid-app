import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/staffsModel.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffAddPage.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  StaffsModel? _staffModels;

  Future getStaffs() async {
    _staffModels = await getStaffsService();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນພະນັກງານ"),
      ),
      body: _staffModels == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : _staffModels!.result!.rows!.isEmpty
              ? Center(
                  child: Text(
                    "ບໍ່ມີຂໍ້ມູນ",
                    style: getBoldStyle(fontSize: FontSizes.s20),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: _staffModels!.result!.rows!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StaffDetailPage(
                                      id: _staffModels!
                                          .result!.rows![index].id!,
                                    )),
                          ).then((value) => getStaffs());
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
                                backgroundColor: ColorConstants.primary,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorConstants.primary,
                                  backgroundImage: _staffModels!
                                                  .result!.rows![index].image !=
                                              null &&
                                          _staffModels!
                                                  .result!.rows![index].image !=
                                              ""
                                      ? NetworkImage(_staffModels!
                                          .result!.rows![index].image!)
                                      : null,
                                  child: _staffModels!
                                                  .result!.rows![index].image ==
                                              null ||
                                          _staffModels!
                                                  .result!.rows![index].image ==
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
                                    "${_staffModels!.result!.rows![index].gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                    "${_staffModels!.result!.rows![index].name} "
                                    "${_staffModels!.result!.rows![index].lastName}",
                                    style: getRegularStyle(
                                        color: ColorConstants.white),
                                  ),
                                  SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        "${_staffModels!.result!.rows![index].email} | ",
                                        style: getRegularStyle(
                                            color: ColorConstants.lightGrey,
                                            fontSize: FontSizes.s14),
                                      ),
                                      Text(
                                        _staffModels!.result!.rows![index]
                                                    .blocked ==
                                                1
                                            ? "ປິດໃຊ້ງານ"
                                            : "ໃຊ້ງານ",
                                        style: getRegularStyle(
                                            color: _staffModels!.result!
                                                        .rows![index].blocked ==
                                                    1
                                                ? ColorConstants.danger
                                                : ColorConstants.success,
                                            fontSize: FontSizes.s14),
                                      ),
                                    ],
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffAddPage()),
                    ).then((value) => getStaffs());
                  },
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ເພີ່ມພະນັກງານ",
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
