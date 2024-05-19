import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/membersModel.dart';
import 'package:bounchan_hotel_admin_app/pages/member/memberDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/memberService.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  MembersModel? _membersModel;

  Future getMembers() async {
    _membersModel = await getMembersService();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນສະມາຊິກ"),
      ),
      body: _membersModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : _membersModel!.result!.rows!.isEmpty
              ? Center(
                  child: Text(
                    "ບໍ່ມີຂໍ້ມູນ",
                    style: getBoldStyle(fontSize: FontSizes.s20),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: _membersModel!.result!.rows!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MemberDetailPage(
                                    id: _membersModel!
                                        .result!.rows![index].id!)),
                          ).then((value) => getMembers());
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
                                  backgroundImage: _membersModel!
                                                  .result!.rows![index].image !=
                                              null &&
                                          _membersModel!
                                                  .result!.rows![index].image !=
                                              ""
                                      ? NetworkImage(_membersModel!
                                          .result!.rows![index].image!)
                                      : null,
                                  child: _membersModel!
                                                  .result!.rows![index].image ==
                                              null ||
                                          _membersModel!
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
                                    "${_membersModel!.result!.rows![index].gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                    "${_membersModel!.result!.rows![index].name} "
                                    "${_membersModel!.result!.rows![index].lastName}",
                                    style: getRegularStyle(
                                        color: ColorConstants.white),
                                  ),
                                  SizedBox(height: 5),
                                  Wrap(
                                    children: [
                                      Text(
                                        "${_membersModel!.result!.rows![index].email} | ",
                                        style: getRegularStyle(
                                            color: ColorConstants.lightGrey,
                                            fontSize: FontSizes.s14),
                                      ),
                                      Text(
                                        _membersModel!.result!.rows![index]
                                                    .blocked ==
                                                1
                                            ? "ປິດໃຊ້ງານ"
                                            : "ໃຊ້ງານ",
                                        style: getRegularStyle(
                                            color: _membersModel!.result!
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
    );
  }
}
