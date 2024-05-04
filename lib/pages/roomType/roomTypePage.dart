import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypeAddPage.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypeDetailPage.dart';
import 'package:flutter/material.dart';

class RoomTypePage extends StatefulWidget {
  const RoomTypePage({super.key});

  @override
  State<RoomTypePage> createState() => _RoomTypePageState();
}

class _RoomTypePageState extends State<RoomTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນປະເພດຫ້ອງ"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            for (int i = 0; i < 2; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomTypeDetailPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    border: Border.all(color: ColorConstants.primary, width: 2),
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY="),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: ColorConstants.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              "ຫ້ອງນອນຕຽງຄູ່",
                              style: getBoldStyle(color: ColorConstants.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
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
                      MaterialPageRoute(
                          builder: (context) => RoomTypeAddPage()),
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
                        "ເພີ່ມປະເພດຫ້ອງ",
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
