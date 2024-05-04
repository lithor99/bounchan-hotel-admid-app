import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class RoomTypeAddPage extends StatefulWidget {
  const RoomTypeAddPage({super.key});

  @override
  State<RoomTypeAddPage> createState() => _RoomTypeAddPageState();
}

class _RoomTypeAddPageState extends State<RoomTypeAddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _roomTypeNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ເພີ່ມປະເພດຫ້ອງ"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1365561421/photo/brown-wooden-bed-with-linens-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=PimPm6zp-jyIm0gj6sUGFitPxl3Upt1WQ5Ew_ztGHHY="),
                        fit: BoxFit.cover,
                      )),
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
                  "ຊື່ປະເພດຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _roomTypeNameController,
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
                    hintText: "ຊື່ປະເພດຫ້ອງ",
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
                    if (_roomTypeNameController.text.isEmpty ||
                        _roomTypeNameController.text == "") {
                      return "ກະລຸນາປ້ອນຊື່ປະເພດຫ້ອງ";
                    }
                    return null;
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
