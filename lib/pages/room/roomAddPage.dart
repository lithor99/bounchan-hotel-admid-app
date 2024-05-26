import 'dart:io';

import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/roomTypesModel.dart';
import 'package:bounchan_hotel_admin_app/models/uploadModel.dart';
import 'package:bounchan_hotel_admin_app/services/roomService.dart';
import 'package:bounchan_hotel_admin_app/services/roomTypeService.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RoomAddPage extends StatefulWidget {
  const RoomAddPage({super.key});

  @override
  State<RoomAddPage> createState() => _RoomAddPageState();
}

class _RoomAddPageState extends State<RoomAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  TextEditingController _roomNoController = TextEditingController();
  TextEditingController _roomDetailController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String? _roomType;
  String? _roomTypeId;
  List<CroppedFile?> _croppedFiles = [];
  RoomTypesModel? _roomTypesModel;
  List<String> _roomTypes = [];
  List<String> _roomTypeIds = [];
  List<String> _imageUrls = [];

  Future<void> _onBrowImage() async {
    XFile? fileImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 20);
    if (fileImage != null) {
      CroppedFile? _croppedFile = await ImageCropper().cropImage(
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
      setState(() {
        _croppedFiles.add(_croppedFile);
      });
    }
  }

  Future getRoomTypes() async {
    _roomTypesModel = await getRoomTypesService();
    print(_roomTypesModel);
    for (int i = 0; i < _roomTypesModel!.result!.length; i++) {
      _roomTypes.add(_roomTypesModel!.result![i].name!);
      _roomTypeIds.add(_roomTypesModel!.result![i].id!);
    }
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
                _croppedFiles.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 1,
                        ),
                        items: _croppedFiles.map((file) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: ColorConstants.primary,
                                ),
                                child: Image.file(
                                  File(file!.path),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                    : SizedBox(
                        height: 200.0,
                        width: double.infinity,
                        child: Icon(
                          Icons.image_search_outlined,
                          size: 100,
                          color: ColorConstants.primary,
                        ),
                      ),
                SizedBox(height: 10),
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
                  "ປະເພດຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    fillColor: ColorConstants.primary,
                    filled: true,
                    contentPadding: const EdgeInsets.only(right: 10, left: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstants.lightGrey, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.lightGrey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    errorStyle: getRegularStyle(color: ColorConstants.danger),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.danger),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                  ),
                  elevation: 0,
                  isExpanded: true,
                  hint: Text(
                    "ເລືອກປະເພດຫ້ອງ",
                    style: getRegularStyle(color: ColorConstants.darkGrey),
                  ),
                  style: getRegularStyle(color: ColorConstants.black),
                  dropdownColor: ColorConstants.white,
                  iconSize: 30,
                  iconEnabledColor: ColorConstants.black,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 20,
                  ),
                  value: _roomType,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາເລືອກປະເພດຫ້ອງ';
                    } else {
                      return null;
                    }
                  },
                  items:
                      _roomTypes.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                        style: getRegularStyle(color: ColorConstants.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? _value) {
                    setState(() {
                      _roomType = _value;
                      _roomTypeId = _roomTypeIds[_roomTypes.indexOf(_value!)];
                    });
                  },
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
                  "ລາຄາ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _priceController,
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
                    hintText: "ລາຄາ",
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
                    if (_priceController.text.isEmpty ||
                        _priceController.text == "") {
                      return "ກະລຸນາປ້ອນລາຄາ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      LoadingDialogWidget.showLoading(context, _loadingKey);
                      if (_croppedFiles.isNotEmpty) {
                        for (int i = 0; i < _croppedFiles.length; i++) {
                          UploadModel? uploadModel = await uploadFileService(
                              file: File(_croppedFiles[i]!.path));
                          _imageUrls.add(uploadModel!.url!);
                        }
                        String result = await createRoomService(
                            roomNo: _roomNoController.text,
                            price: _priceController.text,
                            roomTypeId: _roomTypeId!,
                            images: _imageUrls);
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
                            _roomNoController.clear();
                            _priceController.clear();
                            _roomDetailController.clear();
                            _croppedFiles.clear();
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
                      } else {
                        String result = await createRoomService(
                            roomNo: _roomNoController.text,
                            price: _priceController.text,
                            roomTypeId: _roomTypeId!,
                            images: _imageUrls);
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
                            _roomNoController.clear();
                            _priceController.clear();
                            _roomDetailController.clear();
                            _croppedFiles.clear();
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
