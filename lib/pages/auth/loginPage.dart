import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/loginModel.dart';
import 'package:bounchan_hotel_admin_app/pages/home/homePage.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:bounchan_hotel_admin_app/widgets/errorDialogWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/loadingDialogWidget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loadingKey = GlobalKey<State>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRemember = false;
  bool _showPassword = false;

  Future loadData() async {
    _emailController.text = await StorageManager.readData("email");
    _passwordController.text = await StorageManager.readData("password");
    setState(() {
      if (_passwordController.text.isNotEmpty) {
        _isRemember = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: ColorConstants.black.withAlpha(150),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 120),
                          Center(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstants.primary, width: 3),
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/logo.jpg"))),
                            ),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              "ຍິນດີຕ້ອນຮັບເຂົ້າສູ່ລະບົບ",
                              style: getBoldStyle(
                                  fontSize: FontSizes.s18,
                                  color: ColorConstants.white),
                            ),
                          ),
                          SizedBox(height: 60),
                          Padding(
                            padding: EdgeInsets.only(left: 2, bottom: 2),
                            child: Text(
                              "ອີເມລ",
                              style:
                                  getRegularStyle(color: ColorConstants.white),
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
                            keyboardType: TextInputType.emailAddress,
                            style: getRegularStyle(color: ColorConstants.white),
                            validator: (value) {
                              if (_emailController.text.isEmpty ||
                                  _emailController.text == "") {
                                return "ກະລຸນາປ້ອນອີເມລ";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 2, bottom: 2),
                            child: Text(
                              "ລະຫັດຜ່ານ",
                              style:
                                  getRegularStyle(color: ColorConstants.white),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
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
                                hintText: "ລະຫັດຜ່ານ",
                                hintStyle: getRegularStyle(
                                    color: ColorConstants.lightGrey),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      width: 1, color: ColorConstants.danger),
                                ),
                                errorStyle: getRegularStyle(
                                    color: ColorConstants.danger),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
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
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                  value: _isRemember,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (!states
                                        .contains(MaterialState.selected)) {
                                      return ColorConstants.white;
                                    }
                                    return null;
                                  }),
                                  activeColor: ColorConstants.white,
                                  checkColor: ColorConstants.black,
                                  onChanged: (_) {
                                    setState(() {
                                      _isRemember = !_isRemember;
                                    });
                                  }),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "ຈື່ຊື່ຜູ້ໃຊ້ໄວ້",
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  LoadingDialogWidget.showLoading(
                                      context, _loadingKey);
                                  await Future.delayed(Duration(seconds: 1));
                                  LoginModel? loginModel = await loginService(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  Navigator.of(_loadingKey.currentContext!,
                                          rootNavigator: true)
                                      .pop();
                                  if (loginModel != null) {
                                    if (_isRemember) {
                                      StorageManager.saveData("password",
                                          loginModel.result!.data!.password);
                                    }
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ErrorDialogWidget(
                                          detail:
                                              "ອີເມລ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ",
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorConstants.primary),
                              ),
                              child: Text(
                                "ເຂົ້າສູ່ລະບົບ",
                                style: getBoldStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: SafeArea(
                  child: Center(
                child: Text(
                  "Version 1.0",
                  style: getRegularStyle(
                      fontSize: FontSizes.s12, color: ColorConstants.lightGrey),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
