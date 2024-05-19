import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/memberModel.dart';
import 'package:bounchan_hotel_admin_app/services/memberService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberDetailPage extends StatefulWidget {
  final String id;
  const MemberDetailPage({super.key, required this.id});

  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  bool _blocked = false;
  MemberModel? _memberModel;

  Future getMember() async {
    _memberModel = await getMemberByIdService(id: widget.id);
    setState(() {
      if (_memberModel!.result!.blocked == 1) {
        _blocked = true;
      } else {
        _blocked = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດຂໍ້ມູນສະມາຊິກ"),
      ),
      body: _memberModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 82,
                        backgroundColor: ColorConstants.primary,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: ColorConstants.primary,
                          backgroundImage:
                              _memberModel!.result!.image != null &&
                                      _memberModel!.result!.image != ""
                                  ? NetworkImage(_memberModel!.result!.image!)
                                  : null,
                          child: _memberModel!.result!.image == null ||
                                  _memberModel!.result!.image == ""
                              ? Icon(
                                  Icons.person,
                                  color: ColorConstants.black,
                                  size: 80,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: ColorConstants.lightGrey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                "ຊື່: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _memberModel!.result!.name ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ນາມສະກຸນ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _memberModel!.result!.lastName ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ເພດ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _memberModel!.result!.gender ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ເບີໂທ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _memberModel!.result!.phoneNumber ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ອີເມລ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _memberModel!.result!.email ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "ສະຖານະ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              CupertinoSwitch(
                                  activeColor: ColorConstants.success,
                                  thumbColor: ColorConstants.white,
                                  trackColor: ColorConstants.error,
                                  value: !_blocked,
                                  onChanged: (_) async {
                                    _blocked = !_blocked;
                                    await blockMemberService(
                                        id: widget.id,
                                        status: _blocked ? 1 : 0);
                                    await getMember();
                                  }),
                              SizedBox(width: 5),
                              Text(
                                _memberModel!.result!.blocked == 1
                                    ? "ປິດໃຊ້ງານ"
                                    : "ເປີດໃຊ້ງານ",
                                style: getRegularStyle(
                                    color: _memberModel!.result!.blocked == 1
                                        ? ColorConstants.error
                                        : ColorConstants.success,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
