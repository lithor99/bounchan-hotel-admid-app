import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/roomsModel.dart';
import 'package:bounchan_hotel_admin_app/pages/room/roomAddPage.dart';
import 'package:bounchan_hotel_admin_app/pages/room/roomDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/roomService.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  RoomsModel? _roomsModel;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  Future getRooms({String? search}) async {
    _roomsModel = await getRoomsService(search: search);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRooms(search: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (_isSearching) {
                FocusScope.of(context).unfocus();
                getRooms(search: "");
                setState(() {
                  _searchController.clear();
                  _isSearching = false;
                });
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.black,
            )),
        title: _isSearching
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isEmpty || value == "") {
                      _searchController.clear();
                      getRooms(search: _searchController.text);
                    }
                  },
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(width: 0.5, color: ColorConstants.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(width: 1, color: ColorConstants.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(width: 0.5, color: ColorConstants.white),
                      ),
                      hintText: "ຄົ້ນຫາ",
                      hintStyle: getBoldStyle(color: ColorConstants.darkGrey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      fillColor: ColorConstants.white,
                      filled: true),
                  style: getBoldStyle(color: ColorConstants.black),
                ),
              )
            : Text("ຂໍ້ມູນຫ້ອງ"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                if (_isSearching) {
                  FocusScope.of(context).unfocus();
                  getRooms(search: _searchController.text);
                } else {
                  setState(() {
                    _searchController.clear();
                    _isSearching = true;
                  });
                }
              },
              icon: Icon(
                Icons.search_outlined,
                size: 30,
                color: ColorConstants.black,
              ),
            ),
          ),
        ],
      ),
      body: _roomsModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : _roomsModel!.result!.isEmpty
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
                      for (int i = 0; i < _roomsModel!.result!.length; i++)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoomDetailPage(
                                      id: _roomsModel!.result![i].id!)),
                            ).then((value) => getRooms(search: ""));
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
                                        "ຫ້ອງເບີ: ${_roomsModel!.result![i].roomNo ?? ""}",
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
                                        image: NetworkImage(_roomsModel!
                                                .result![i]
                                                .roomImages![0]
                                                .image ??
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
                      MaterialPageRoute(builder: (context) => RoomAddPage()),
                    ).then((value) => getRooms());
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
                        "ເພີ່ມຫ້ອງ",
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
