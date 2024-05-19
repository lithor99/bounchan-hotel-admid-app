import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/roomTypesModel.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypeAddPage.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypeDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/roomTypeService.dart';
import 'package:flutter/material.dart';

class RoomTypePage extends StatefulWidget {
  const RoomTypePage({super.key});

  @override
  State<RoomTypePage> createState() => _RoomTypePageState();
}

class _RoomTypePageState extends State<RoomTypePage> {
  RoomTypesModel? _roomTypesModel;

  Future getRoomTypes() async {
    _roomTypesModel = await getRoomTypesService();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRoomTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຂໍ້ມູນປະເພດຫ້ອງ"),
      ),
      body: _roomTypesModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : _roomTypesModel!.result!.isEmpty
              ? Center(
                  child: Text(
                    "ບໍ່ມີຂໍ້ມູນ",
                    style: getBoldStyle(fontSize: FontSizes.s20),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      for (int i = 0; i < _roomTypesModel!.result!.length; i++)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoomTypeDetailPage(
                                      id: _roomTypesModel!.result![i].id!)),
                            ).then((value) => getRoomTypes());
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.primary,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        _roomTypesModel!.result![i].name ?? "",
                                        style: getBoldStyle(
                                            color: ColorConstants.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.primary,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                  ),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width / 2 -
                                            60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            _roomTypesModel!.result![i].image ??
                                                ""),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
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
                    ).then((value) => getRoomTypes());
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
