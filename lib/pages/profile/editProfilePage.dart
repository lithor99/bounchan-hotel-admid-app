import 'dart:io';

import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/staffModel.dart';
import 'package:bounchan_hotel_admin_app/models/uploadModel.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String _gender = "";
  String? _image;
  CroppedFile? _croppedFile;
  String? _id;
  StaffModel? _staffModel;

  Future getStaff() async {
    _id = await StorageManager.readData("id");
    _staffModel = await getStaffByIdService(id: _id!);
    setState(() {
      _nameController.text = _staffModel!.result!.name!;
      _lastNameController.text = _staffModel!.result!.lastName!;
      _phoneNumberController.text = _staffModel!.result!.phoneNumber!;
      _emailController.text = _staffModel!.result!.email!;
      _birthDateController.text = _staffModel!.result!.birthDate ?? "";
      _addressController.text = _staffModel!.result!.address ?? "";
      _gender = _staffModel!.result!.gender!;
      _image = _staffModel!.result!.image ?? "";
    });
  }

  Future<void> _onTakeImage() async {
    XFile? fileImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
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
  void initState() {
    super.initState();
    getStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ"),
      ),
      body: _staffModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 82,
                          backgroundColor: ColorConstants.primary,
                          child: _croppedFile != null && _croppedFile != ""
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: ColorConstants.primary,
                                  backgroundImage:
                                      _croppedFile != null && _croppedFile != ""
                                          ? FileImage(File(_croppedFile!.path))
                                          : null,
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundColor: ColorConstants.primary,
                                  backgroundImage:
                                      _image != null && _image != ""
                                          ? NetworkImage(_image!)
                                          : null,
                                  child: _image == null || _image == ""
                                      ? Icon(
                                          Icons.person,
                                          color: ColorConstants.black,
                                          size: 80,
                                        )
                                      : null,
                                ),
                        ),
                      ),
                      Center(
                        child: IconButton(
                            onPressed: () {
                              _onTakeImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo_rounded,
                              size: 30,
                              color: ColorConstants.primary,
                            )),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ຊື່",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ຊື່",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: getRegularStyle(color: ColorConstants.white),
                        validator: (value) {
                          if (_nameController.text.isEmpty ||
                              _nameController.text == "") {
                            return "ກະລຸນາປ້ອນຊື່";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ນາມສະກຸນ",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ນາມສະກຸນ",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: getRegularStyle(color: ColorConstants.white),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Radio<String>(
                            value: "ຊາຍ",
                            groupValue: _gender,
                            activeColor: ColorConstants.white,
                            fillColor:
                                MaterialStatePropertyAll(ColorConstants.white),
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text(
                            "ຊາຍ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                          SizedBox(width: 100),
                          Radio<String>(
                            value: "ຍິງ",
                            groupValue: _gender,
                            activeColor: ColorConstants.white,
                            fillColor:
                                MaterialStatePropertyAll(ColorConstants.white),
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          Text(
                            "ຍິງ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ເບີໂທ",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ເບີໂທ",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: getRegularStyle(color: ColorConstants.white),
                        validator: (value) {
                          if (_phoneNumberController.text.isEmpty ||
                              _phoneNumberController.text == "") {
                            return "ກະລຸນາປ້ອນເບີໂທ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ອີເມລ",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ອີເມລ",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: getRegularStyle(color: ColorConstants.white),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ວັນ, ເດືອນ, ປີເກີດ",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ວັນ, ເດືອນ, ປີເກີດ",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
                        style: getRegularStyle(color: ColorConstants.white),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "ທີ່ຢູ່",
                        style: getRegularStyle(color: ColorConstants.lightGrey),
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 0.5, color: ColorConstants.white),
                          ),
                          hintText: "ທີ່ຢູ່",
                          hintStyle:
                              getRegularStyle(color: ColorConstants.lightGrey),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstants.danger),
                          ),
                          errorStyle:
                              getRegularStyle(color: ColorConstants.danger),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        ),
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
                      if (_croppedFile != null) {
                        UploadModel? uploadModel = await uploadFileService(
                            file: File(_croppedFile!.path));
                        if (uploadModel!.url != null) {
                          _image = uploadModel.url;
                        }
                        String result = await updateStaffService(
                          id: _id!,
                          name: _nameController.text,
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          email: _emailController.text,
                          gender: _gender,
                          image: _image,
                          birthDate: _birthDateController.text,
                          address: _addressController.text,
                        );
                        Navigator.of(_loadingKey.currentContext!,
                                rootNavigator: true)
                            .pop();
                        if (result == "success") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SuccessDialogWidget(
                                detail: "ແກ້ໄຂຂໍ້ມູນສຳເລັດ",
                              );
                            },
                          );
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
                        String result = await updateStaffService(
                          id: _id!,
                          name: _nameController.text,
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          email: _emailController.text,
                          gender: _gender,
                          birthDate: _birthDateController.text,
                          address: _addressController.text,
                        );
                        Navigator.of(_loadingKey.currentContext!,
                                rootNavigator: true)
                            .pop();
                        if (result == "success") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SuccessDialogWidget(
                                detail: "ແກ້ໄຂຂໍ້ມູນສຳເລັດ",
                              );
                            },
                          );
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
