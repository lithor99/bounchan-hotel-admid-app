import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffAddPage.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffDetailPage.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນພະນັກງານ"),
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
                  MaterialPageRoute(builder: (context) => StaffDetailPage()),
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
                    );
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
