import 'dart:io';

import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/staffModel.dart';
import 'package:bounchan_hotel_admin_app/models/uploadModel.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StaffAddPage extends StatefulWidget {
  const StaffAddPage({super.key});

  @override
  State<StaffAddPage> createState() => _StaffAddPageState();
}

class _StaffAddPageState extends State<StaffAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  int _role = 0;
  String _gender = "";
  String? _image;

  CroppedFile? _croppedFile;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ເພີ່ມພະນັກງານ"),
      ),
      body: SingleChildScrollView(
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
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: ColorConstants.primary,
                      backgroundImage:
                          _croppedFile != null && _croppedFile != ""
                              ? FileImage(File(_croppedFile!.path))
                              : null,
                      child: _croppedFile == null || _croppedFile == ""
                          ? Icon(
                              Icons.person,
                              color: ColorConstants.black,
                              size: 50,
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
                    hintText: "ຊື່",
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
                    hintText: "ນາມສະກຸນ",
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
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Radio<String>(
                      value: "ຊາຍ",
                      groupValue: _gender,
                      activeColor: ColorConstants.white,
                      fillColor: MaterialStatePropertyAll(ColorConstants.white),
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
                      fillColor: MaterialStatePropertyAll(ColorConstants.white),
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
                    hintText: "ເບີໂທ",
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
                    if (_phoneNumberController.text.isEmpty ||
                        _phoneNumberController.text == "") {
                      return "ກະລຸນາປ້ອນເບີໂທ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
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
                    hintText: "ອີເມລ",
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
                  keyboardType: TextInputType.emailAddress,
                  style: getRegularStyle(color: ColorConstants.white),
                ),
                SizedBox(height: 15),
                Text(
                  "ລະຫັດຜ່ານ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _passwordController,
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
                      hintText: "ລະຫັດຜ່ານ",
                      hintStyle:
                          getRegularStyle(color: ColorConstants.lightGrey),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(width: 1, color: ColorConstants.danger),
                      ),
                      errorStyle: getRegularStyle(color: ColorConstants.danger),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorConstants.lightGrey,
                        ),
                      )),
                  obscureText: !_showPassword,
                  style: getRegularStyle(color: ColorConstants.white),
                  validator: (value) {
                    if (_passwordController.text.isEmpty ||
                        _passwordController.text == "") {
                      return "ກະລຸນາປ້ອນລະຫັດຜ່ານ";
                    }
                    return null;
                  },
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
                    hintText: "ວັນ, ເດືອນ, ປີເກີດ",
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
                    hintText: "ທີ່ຢູ່",
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
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _role,
                      activeColor: ColorConstants.white,
                      fillColor: MaterialStatePropertyAll(ColorConstants.white),
                      onChanged: (value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                    Text(
                      "ຜູ້ຈັດການ",
                      style: getRegularStyle(color: ColorConstants.white),
                    ),
                    SizedBox(width: 100),
                    Radio<int>(
                      value: 2,
                      groupValue: _role,
                      activeColor: ColorConstants.white,
                      fillColor: MaterialStatePropertyAll(ColorConstants.white),
                      onChanged: (value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                    Text(
                      "ພະນັກງານທົ່ວໄປ",
                      style: getRegularStyle(color: ColorConstants.white),
                    ),
                  ],
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
                      String checkEmail =
                          await checkEmailService(email: _emailController.text);
                      if (checkEmail == "no") {
                        Navigator.of(_loadingKey.currentContext!,
                                rootNavigator: true)
                            .pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialogWidget(
                              detail: "ອີເມລນີ້ມີຢູ່ແລ້ວ",
                            );
                          },
                        );
                      } else {
                        if (_croppedFile != null) {
                          UploadModel? uploadModel = await uploadFileService(
                              file: File(_croppedFile!.path));
                          if (uploadModel!.url != null) {
                            _image = uploadModel.url;
                          }
                          StaffModel? staffModel = await createStaffService(
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            gender: _gender,
                            image: _image!,
                            birthDate: _birthDateController.text,
                            address: _addressController.text,
                            role: _role,
                          );
                          Navigator.of(_loadingKey.currentContext!,
                                  rootNavigator: true)
                              .pop();
                          if (staffModel != null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SuccessDialogWidget(
                                  detail: "ເພີ່ມຂໍ້ມູນສຳເລັດ",
                                );
                              },
                            );
                            setState(() {
                              _nameController.clear();
                              _lastNameController.clear();
                              _emailController.clear();
                              _phoneNumberController.clear();
                              _addressController.clear();
                              _passwordController.clear();
                              _birthDateController.clear();
                              _croppedFile == null;
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
                          StaffModel? staffModel = await createStaffService(
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            gender: _gender,
                            birthDate: _birthDateController.text,
                            address: _addressController.text,
                            role: _role,
                          );
                          Navigator.of(_loadingKey.currentContext!,
                                  rootNavigator: true)
                              .pop();
                          if (staffModel != null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SuccessDialogWidget(
                                  detail: "ເພີ່ມຂໍ້ມູນສຳເລັດ",
                                );
                              },
                            );
                            setState(() {
                              _nameController.clear();
                              _lastNameController.clear();
                              _emailController.clear();
                              _phoneNumberController.clear();
                              _addressController.clear();
                              _passwordController.clear();
                              _birthDateController.clear();
                              _croppedFile == null;
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
