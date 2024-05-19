import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/staffModel.dart';
import 'package:bounchan_hotel_admin_app/pages/profile/changePasswordPage.dart';
import 'package:bounchan_hotel_admin_app/pages/profile/editProfilePage.dart';
import 'package:bounchan_hotel_admin_app/services/staffService.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _blocked = false;
  String? _id;
  StaffModel? _staffModel;

  Future getStaff() async {
    _id = await StorageManager.readData("id");
    _staffModel = await getStaffByIdService(id: _id!);
    StorageManager.saveData("image", _staffModel!.result!.image.toString());
    setState(() {});
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
        title: Text("ຂໍ້ມູນຜູ້ໃຊ້"),
      ),
      body: _staffModel == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                          backgroundImage: _staffModel!.result!.image != null &&
                                  _staffModel!.result!.image != ""
                              ? NetworkImage(_staffModel!.result!.image!)
                              : null,
                          child: _staffModel!.result!.image == null ||
                                  _staffModel!.result!.image == ""
                              ? Icon(
                                  Icons.person,
                                  color: ColorConstants.black,
                                  size: 80,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: ColorConstants.lightGrey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                "ຊື່: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.name ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ນາມສະກຸນ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.lastName ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ເພດ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.gender ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ເບີໂທ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.phoneNumber ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ອີເມລ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.email ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ວັນ, ເດືອນ, ປີເກີດ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.birthDate ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ທີ່ຢູ່: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.address ?? "",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            children: [
                              Text(
                                "ຕຳແໜ່ງ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.role == 1
                                    ? "ຜູ້ຈັດການ"
                                    : "ພະນັກງານທົ່ວໄປ",
                                style: getRegularStyle(
                                    color: ColorConstants.white,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "ສະຖານະ: ",
                                style: getRegularStyle(
                                    color: ColorConstants.lightGrey,
                                    fontSize: FontSizes.s18),
                              ),
                              Text(
                                _staffModel!.result!.blocked == 1
                                    ? "ປິດໃຊ້ງານ"
                                    : "ເປີດໃຊ້ງານ",
                                style: getRegularStyle(
                                    color: _blocked
                                        ? ColorConstants.error
                                        : ColorConstants.success,
                                    fontSize: FontSizes.s18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorConstants.primary,
                        borderRadius: BorderRadius.circular(10),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfilePage()),
                                  ).then((value) => getStaff());
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit_square,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "ແກ້ໄຂຂໍ້ມູນ",
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorConstants.primary,
                        borderRadius: BorderRadius.circular(10),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordPage(
                                                id: _staffModel!.result!.id!)),
                                  );
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.key_rounded,
                                      size: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "ປ່ຽນລະຫັດຜ່ານ",
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
                  ],
                ),
              ),
            ),
    );
  }
}
