import 'dart:io';

import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/uploadModel.dart';
import 'package:bounchan_hotel_admin_app/services/roomTypeService.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RoomTypeAddPage extends StatefulWidget {
  const RoomTypeAddPage({super.key});

  @override
  State<RoomTypeAddPage> createState() => _RoomTypeAddPageState();
}

class _RoomTypeAddPageState extends State<RoomTypeAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  TextEditingController _roomTypeNameController = TextEditingController();

  CroppedFile? _croppedFile;

  Future<void> _onBrowImage() async {
    XFile? fileImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 20);
    if (fileImage != null) {
      _croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: fileImage.path,
        compressQuality: 20,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: ColorConstants.primary,
              toolbarWidgetColor: ColorConstants.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
              title: '',
              aspectRatioPickerButtonHidden: true,
              resetButtonHidden: true),
        ],
      );
      setState(() {});
    }
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorConstants.darkGrey,
                        image: _croppedFile != null
                            ? DecorationImage(
                                image: FileImage(File(_croppedFile!.path)),
                                fit: BoxFit.cover,
                              )
                            : null),
                    child: _croppedFile == null
                        ? SizedBox(
                            height: MediaQuery.of(context).size.width - 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_search_outlined,
                                  size: 100,
                                  color: ColorConstants.primary,
                                ),
                              ],
                            ),
                          )
                        : null),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    _onBrowImage();
                  },
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
                            "ເລືອກຮູບພາບ",
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
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_croppedFile == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialogWidget(
                              detail: "ກະລຸນາເລືອກຮູບພາບ",
                            );
                          },
                        );
                        return;
                      }
                      String results = await checkRoomTypeService(
                          roomType: _roomTypeNameController.text);
                      if (results == "success") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialogWidget(
                              detail: "ຊື່ປະເພດຫ້ອງນີ້ມີຢູ່ແລ້ວ",
                            );
                          },
                        );
                        return;
                      }
                      LoadingDialogWidget.showLoading(context, _loadingKey);
                      UploadModel? uploadModel = await uploadFileService(
                          file: File(_croppedFile!.path));
                      String result = await createRoomTypeService(
                          name: _roomTypeNameController.text,
                          image: uploadModel!.url!);
                      Navigator.of(_loadingKey.currentContext!,
                              rootNavigator: true)
                          .pop();
                      if (result == "success") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SuccessDialogWidget(
                              detail: "ເພີ່ມຂໍ້ມູນສຳເລັດ",
                            );
                          },
                        );
                        setState(() {
                          _roomTypeNameController.clear();
                          _croppedFile = null;
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialogWidget(
                              detail: "ເກີດຂໍ້ຜິດພາດ",
                            );
                          },
                        );
                      }
                    }
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
