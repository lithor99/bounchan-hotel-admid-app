import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/book/bookDetailPage.dart';
import 'package:bounchan_hotel_admin_app/pages/book/historyBookPage.dart';
import 'package:bounchan_hotel_admin_app/pages/checkIn/checkInPage.dart';
import 'package:bounchan_hotel_admin_app/pages/checkOut/checkOutPage.dart';
import 'package:bounchan_hotel_admin_app/pages/member/memberPage.dart';
import 'package:bounchan_hotel_admin_app/pages/profile/profilePage.dart';
import 'package:bounchan_hotel_admin_app/pages/room/roomPage.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypePage.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ໜ້າຫຼັກ"),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: CircleAvatar(
              radius: 21,
              backgroundColor: ColorConstants.black,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: ColorConstants.primary,
                child: Icon(
                  Icons.person,
                  color: ColorConstants.black,
                  size: 35,
                ),
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: double.infinity,
        color: ColorConstants.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 10),
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: ColorConstants.primary,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: ColorConstants.black,
                          child: Icon(
                            Icons.person,
                            color: ColorConstants.primary,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "ຊື່ ແລະ ນາມສະກຸນ\n2078966646",
                        style: getBoldStyle(
                            fontSize: FontSizes.s14,
                            color: ColorConstants.primary),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: ColorConstants.primary,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.person_outline_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນຜູ້ໃຊ້",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StaffPage()),
                  );
                },
                leading: Icon(
                  Icons.people_outline,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນພະນັກງານ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນສະມາຊິກ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemberPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.auto_awesome_mosaic_outlined,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນປະເພດຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomTypePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.bed_outlined,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_circle_down_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ແຈ້ງເຂົ້າ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckInPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_circle_up_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ແຈ້ງອອກ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckOutPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.work_history_outlined,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ປະຫວັດການຈອງ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryBookPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.graphic_eq_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ລາຍງານ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: ColorConstants.danger,
                  size: 30,
                ),
                title: Text(
                  "ອອກຈາກລະບົບ",
                  style: getRegularStyle(color: ColorConstants.danger),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConstants.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  "ລາຍການແຈ້ງເຂົ້າ",
                  style: getBoldStyle(),
                ),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetailPage()),
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
                                child: Icon(
                                  Icons.person,
                                  color: ColorConstants.black,
                                  size: 35,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ທ່ານ ອາວຸດ ປະສິດທິພາບ | ຫ້ອງເບີ: 01",
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "ແຈ້ງເຂົ້າ: 2014-01-01 | ແຈ້ງເຂົ້າ: 2014-01-05",
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
                SizedBox(height: 20),
                Text(
                  "ລາຍການແຈ້ງອອກ",
                  style: getBoldStyle(),
                ),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetailPage()),
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
                                child: Icon(
                                  Icons.person,
                                  color: ColorConstants.black,
                                  size: 35,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ທ່ານ ອາວຸດ ປະສິດທິພາບ | ຫ້ອງເບີ: 01",
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "ແຈ້ງເຂົ້າ: 2014-01-01 | ແຈ້ງເຂົ້າ: 2014-01-05",
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
                  onTap: () {},
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ແຈ້ງເຂົ້າ",
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
            VerticalDivider(
              color: ColorConstants.darkGrey,
              width: 0.5,
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 2 - 1,
                child: InkWell(
                  onTap: () {},
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ແຈ້ງອອກ",
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
