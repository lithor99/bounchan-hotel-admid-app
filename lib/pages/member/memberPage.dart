import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/member/memberDetailPage.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນສະມາຊິກ"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberDetailPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: index == 0
                            ? BorderSide(
                                color: ColorConstants.lightGrey, width: 0.3)
                            : BorderSide.none,
                        bottom: BorderSide(
                            color: ColorConstants.lightGrey, width: 0.3))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: ColorConstants.black,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorConstants.primary,
                        backgroundImage: NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/3870/3870822.png"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ທ່ານ ອາວຸດ ປະສິດທິພາບ",
                          style: getRegularStyle(color: ColorConstants.white),
                        ),
                        SizedBox(height: 5),
                        Wrap(
                          children: [
                            Text(
                              "2078966646 | ",
                              style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s14),
                            ),
                            Text(
                              "ໃຊ້ງານ",
                              style: getRegularStyle(
                                  color: ColorConstants.success,
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
