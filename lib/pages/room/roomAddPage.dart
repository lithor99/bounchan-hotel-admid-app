import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class RoomAddPage extends StatefulWidget {
  const RoomAddPage({super.key});

  @override
  State<RoomAddPage> createState() => _RoomAddPageState();
}

class _RoomAddPageState extends State<RoomAddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _roomNoController = TextEditingController();
  TextEditingController _roomDetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດຫ້ອງ"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Center(
                    child: ListView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: ColorConstants.primary),
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY="),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
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
                            style: getRegularStyle(color: ColorConstants.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                  style: getRegularStyle(color: ColorConstants.white),
                  validator: (value) {
                    if (_roomNoController.text.isEmpty ||
                        _roomNoController.text == "") {
                      return "ກະລຸນາປ້ອນເບີຫ້ອງ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
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
                  style: getRegularStyle(color: ColorConstants.white),
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
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
      ),
    );
  }
}
