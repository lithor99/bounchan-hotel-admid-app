import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/pages/auth/forgotPasswordOtpPage.dart';
import 'package:bounchan_hotel_admin_app/services/otpService.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailPage extends StatelessWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _loadingKey = GlobalKey<State>();
    final _emailController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ອີເມລ"),
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
                        Padding(
                          padding: EdgeInsets.only(left: 2, bottom: 2),
                          child: Text(
                            "ອີເມລ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
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
                            hintText: "example@gmail.com",
                            hintStyle: getRegularStyle(
                                color: ColorConstants.lightGrey),
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
                          style: getRegularStyle(color: ColorConstants.white),
                          validator: (value) {
                            if (_emailController.text.isEmpty ||
                                _emailController.text == "") {
                              return "ກະລຸນາປ້ອນອີເມລ";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
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
                    String result =
                        await sendOtpService(email: _emailController.text);
                    Navigator.of(_loadingKey.currentContext!,
                            rootNavigator: true)
                        .pop();
                    if (result == "success") {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordOtpPage(
                                      email: _emailController.text)))
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
