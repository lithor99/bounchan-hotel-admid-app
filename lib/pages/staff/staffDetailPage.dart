import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffDetailPage extends StatefulWidget {
  const StaffDetailPage({super.key});

  @override
  State<StaffDetailPage> createState() => _StaffDetailPageState();
}

class _StaffDetailPageState extends State<StaffDetailPage> {
  bool _blocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດຂໍ້ມູນພະນັກງານ"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 81,
                  backgroundColor: ColorConstants.black,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: ColorConstants.primary,
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3870/3870822.png"),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorConstants.lightGrey),
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
                          "ອາວຸດ",
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
                          "ປະສິດທິພາບ",
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
                          "ຊາຍ",
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
                          "2078966646",
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
                          "user@gmail.com",
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
                          "ວັນ, ເດືອນ, ປີເກີດ: ",
                          style: getRegularStyle(
                              color: ColorConstants.lightGrey,
                              fontSize: FontSizes.s18),
                        ),
                        Text(
                          "07-06-2000",
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
                          "ທີ່ຢູ່: ",
                          style: getRegularStyle(
                              color: ColorConstants.lightGrey,
                              fontSize: FontSizes.s18),
                        ),
                        Text(
                          "ບ້ານດົງໂດກ, ເມືອງໄຊທານີ, ແຂວງນະຄອນຫຼວງວຽງຈັນ",
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
                          "ຕຳແໜ່ງ: ",
                          style: getRegularStyle(
                              color: ColorConstants.lightGrey,
                              fontSize: FontSizes.s18),
                        ),
                        Text(
                          "ພະນັກງານເຄົ້າເຕີ້",
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
                            onChanged: (_) {
                              setState(() {
                                _blocked = !_blocked;
                              });
                            }),
                        SizedBox(width: 5),
                        Text(
                          _blocked ? "ປິດໃຊ້ງານ" : "ເປີດໃຊ້ງານ",
                          style: getRegularStyle(
                              color: _blocked
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
