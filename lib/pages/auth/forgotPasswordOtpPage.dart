import 'dart:async';
import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/auth/resetPasswordPage.dart';
import 'package:bounchan_hotel_admin_app/services/otpService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({super.key, required this.email});
  final String email;

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  final _otpController = TextEditingController();
  late Timer _timer;
  int _start = 120;
  void startTimer() {
    _start = 120;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ຢືນຢັນລະຫັດ OTP"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "ກະລຸນາປ້ອນລະຫັດ OTP ທີ່ສົ່ງໄປຫາອີເມລ",
                            style: getRegularStyle(
                                color: ColorConstants.white,
                                fontSize: FontSizes.s16),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${widget.email}",
                            style: getRegularStyle(
                                color: ColorConstants.white,
                                fontSize: FontSizes.s16),
                          ),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: EdgeInsets.only(left: 2, bottom: 2),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ລະຫັດ OTP",
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                                Text(
                                  "ໝົດເວລາພາຍໃນ $_start ວິນາທີ",
                                  style: getRegularStyle(
                                      color: ColorConstants.danger),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _otpController,
                          autofocus: true,
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
                            hintText: "xxxxxx",
                            hintStyle: getRegularStyle(
                                color: ColorConstants.lightGrey,
                                fontSize: FontSizes.s16),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorConstants.danger),
                            ),
                            errorStyle:
                                getRegularStyle(color: ColorConstants.danger),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          style: getRegularStyle(
                              color: ColorConstants.white,
                              fontSize: FontSizes.s16),
                          validator: (value) {
                            if (_otpController.text.isEmpty ||
                                _otpController.text == "") {
                              return "ກະລຸນາປ້ອນລະຫັດ OTP";
                            } else if (_otpController.text.length < 6) {
                              return "ກະລຸນາປ້ອນລະຫັດ OTP ໃຫ້ຄົບ 6 ໂຕ";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    LoadingDialogWidget.showLoading(context, _loadingKey);
                    String result = await confirmOtpService(
                        email: widget.email, otp: _otpController.text);
                    Navigator.of(_loadingKey.currentContext!,
                            rootNavigator: true)
                        .pop();
                    if (result == "success") {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPasswordPage(email: widget.email)))
                          .then((value) => Navigator.pop(context));
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ຖັດໄປ",
                          style: getRegularStyle(
                              color: ColorConstants.black,
                              fontSize: FontSizes.s16),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: ColorConstants.black,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
