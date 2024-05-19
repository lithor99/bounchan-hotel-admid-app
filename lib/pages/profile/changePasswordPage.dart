import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/succesDialogWidget.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  final String id;
  const ChangePasswordPage({super.key, required this.id});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ປ່ຽນລະຫັດຜ່ານ"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  "ລະຫັດຜ່ານເກົ່າ",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _oldPasswordController,
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
                      hintText: "ລະຫັດຜ່ານເກົ່າ",
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
                    if (_oldPasswordController.text.isEmpty ||
                        _oldPasswordController.text == "") {
                      return "ກະລຸນາປ້ອນລະຫັດຜ່ານເກົ່າ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "ລະຫັດຜ່ານໃໝ່",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _newPasswordController,
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
                      hintText: "ລະຫັດຜ່ານໃໝ່",
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
                    if (_newPasswordController.text.isEmpty ||
                        _newPasswordController.text == "") {
                      return "ກະລຸນາປ້ອນລະຫັດຜ່ານໃໝ່";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "ຢືນຢັນລະຫັດຜ່ານໃໝ່",
                  style: getRegularStyle(color: ColorConstants.lightGrey),
                ),
                TextFormField(
                  controller: _confirmPasswordController,
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
                      hintText: "ຢືນຢັນລະຫັດຜ່ານໃໝ່",
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
                    if (_confirmPasswordController.text.isEmpty ||
                        _confirmPasswordController.text == "") {
                      return "ກະລຸນາຢືນຢັນລະຫັດຜ່ານໃໝ່";
                    } else if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      return "ລະຫັດຜ່ານໃໝ່ບໍ່ກົງກັນ";
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
                      LoadingDialogWidget.showLoading(context, _loadingKey);
                      String result = await changePasswordService(
                          id: widget.id,
                          oldPassword: _oldPasswordController.text,
                          newPassword: _newPasswordController.text);
                      Navigator.of(_loadingKey.currentContext!,
                              rootNavigator: true)
                          .pop();
                      if (result == "success") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SuccessDialogWidget(
                              detail: "ປ່ຽນລະຫັດຜ່ານສຳເລັດ",
                            );
                          },
                        );
                      } else if (result == "incorrect") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialogWidget(
                              detail: "ລະຫັດຜ່ານເກົ່າບໍ່ຖືກຕ້ອງ",
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
