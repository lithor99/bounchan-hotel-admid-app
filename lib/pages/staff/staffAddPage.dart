import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class StaffAddPage extends StatefulWidget {
  const StaffAddPage({super.key});

  @override
  State<StaffAddPage> createState() => _StaffAddPageState();
}

class _StaffAddPageState extends State<StaffAddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  int? _role;
  String _gender = "";

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
                    radius: 81,
                    backgroundColor: ColorConstants.black,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: ColorConstants.primary,
                      backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/3870/3870822.png"),
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {},
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
                      "ພະນັກງານ",
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
