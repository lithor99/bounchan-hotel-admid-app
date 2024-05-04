import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/book/bookDetailPage.dart';
import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍການລໍແຈ້ງເຂົ້າ"),
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
                  MaterialPageRoute(builder: (context) => BookDetailPage()),
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
                          style: getRegularStyle(color: ColorConstants.white),
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
      ),
    );
  }
}
