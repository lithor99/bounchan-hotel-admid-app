import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  TextEditingController _roomNoController = TextEditingController(text: "01");
  TextEditingController _roomDetailController = TextEditingController(
      text:
          "It seems like you're asking for a concise way to fetch room details. If you're referring to a database query, it would depend on your database structure and the specific details you want to retrieve. Here's a general example using pseudo-code");
  List<String> images = [
    "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY=",
    "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY=",
    "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY=",
    "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY=",
    "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດຂໍ້ມູນຫ້ອງ"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: images.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: ColorConstants.primary,
                                  contentPadding: EdgeInsets.all(0),
                                  content: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    height:
                                        MediaQuery.of(context).size.width - 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  actionsPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_outline,
                                                color: ColorConstants.error,
                                              ),
                                              Text("ລຶບຮູບ",
                                                  style: getBoldStyle(
                                                      color: ColorConstants
                                                          .error)),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.highlight_remove_rounded,
                                                color: ColorConstants.black,
                                              ),
                                              Text(
                                                'ຍົກເລີກ',
                                                style: getBoldStyle(
                                                    color:
                                                        ColorConstants.black),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: ColorConstants.primary,
                            ),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                _isEdit ? SizedBox(height: 10) : SizedBox(),
                _isEdit
                    ? Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY="),
                              fit: BoxFit.cover,
                            )),
                      )
                    : SizedBox(),
                _isEdit ? SizedBox(height: 10) : SizedBox(),
                _isEdit
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 55,
                          decoration: BoxDecoration(
                            color: ColorConstants.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline_rounded),
                                SizedBox(width: 5),
                                Text(
                                  "ເພີ່ມຮູບພາບ",
                                  style: getRegularStyle(
                                      color: ColorConstants.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                Text(
                  "ເບີຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _roomNoController,
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
                    hintText: "ເບີຫ້ອງ",
                    hintStyle: getRegularStyle(color: ColorConstants.lightGrey),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 1, color: ColorConstants.danger),
                    ),
                    errorStyle: getRegularStyle(color: ColorConstants.danger),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  readOnly: !_isEdit,
                  style: getRegularStyle(color: ColorConstants.white),
                  validator: (value) {
                    if (_roomNoController.text.isEmpty ||
                        _roomNoController.text == "") {
                      return "ກະລຸນາປ້ອນເບີຫ້ອງ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "ລາຍລະອຽດຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _roomDetailController,
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
                    hintText: "ລາຍລະອຽດຫ້ອງ",
                    hintStyle: getRegularStyle(color: ColorConstants.lightGrey),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 1, color: ColorConstants.danger),
                    ),
                    errorStyle: getRegularStyle(color: ColorConstants.danger),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  maxLines: null,
                  readOnly: !_isEdit,
                  style: getRegularStyle(color: ColorConstants.white),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: _isEdit,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.selected)) {
                            return ColorConstants.white;
                          }
                          return null;
                        }),
                        activeColor: ColorConstants.white,
                        checkColor: ColorConstants.black,
                        onChanged: (_) {
                          setState(() {
                            _isEdit = !_isEdit;
                          });
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "ເປີດແກ້ໄຂ",
                        style: getRegularStyle(color: ColorConstants.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _isEdit
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: ColorConstants.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
                          if (_formKey.currentState!.validate()) {}
                        },
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_as_outlined,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "ບັນທຶກ",
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
            )
          : null,
    );
  }
}
