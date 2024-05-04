import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class RoomTypeDetailPage extends StatefulWidget {
  const RoomTypeDetailPage({super.key});

  @override
  State<RoomTypeDetailPage> createState() => _RoomTypeDetailPageState();
}

class _RoomTypeDetailPageState extends State<RoomTypeDetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  TextEditingController _roomTypeNameController =
      TextEditingController(text: "ຫ້ອງຕຽງຄູ່");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດຂໍ້ມູນປະເພດຫ້ອງ"),
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
                  readOnly: !_isEdit,
                  style: getRegularStyle(color: ColorConstants.white),
                  validator: (value) {
                    if (_roomTypeNameController.text.isEmpty ||
                        _roomTypeNameController.text == "") {
                      return "ກະລຸນາປ້ອນຊື່ປະເພດຫ້ອງ";
                    }
                    return null;
                  },
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
