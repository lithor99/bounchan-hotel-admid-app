import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/booksModel.dart';
import 'package:bounchan_hotel_admin_app/pages/auth/loginPage.dart';
import 'package:bounchan_hotel_admin_app/pages/book/bookDetailPage.dart';
import 'package:bounchan_hotel_admin_app/pages/book/historyBookPage.dart';
import 'package:bounchan_hotel_admin_app/pages/book/scanQrCodePage.dart';
import 'package:bounchan_hotel_admin_app/pages/checkIn/checkInPage.dart';
import 'package:bounchan_hotel_admin_app/pages/checkOut/checkOutPage.dart';
import 'package:bounchan_hotel_admin_app/pages/manualBook/manualBookPage.dart';
import 'package:bounchan_hotel_admin_app/pages/member/memberPage.dart';
import 'package:bounchan_hotel_admin_app/pages/profile/profilePage.dart';
import 'package:bounchan_hotel_admin_app/pages/report/reportPage.dart';
import 'package:bounchan_hotel_admin_app/pages/room/roomPage.dart';
import 'package:bounchan_hotel_admin_app/pages/roomType/roomTypePage.dart';
import 'package:bounchan_hotel_admin_app/pages/staff/staffPage.dart';
import 'package:bounchan_hotel_admin_app/services/bookService.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:bounchan_hotel_admin_app/widgets/warningDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _image;
  String? _name;
  String? _email;
  String? _phoneNumber;
  int? _role = 2;
  BooksModel? _checkInList;
  BooksModel? _checkOutList;
  final _checkInDateController = TextEditingController();
  final _checkOutDateController = TextEditingController();
  late DateTime _selectedCheckInDate;
  late DateTime _selectedCheckOutDate;

  Future _readData() async {
    _selectedCheckInDate = DateTime.now();
    _selectedCheckOutDate = DateTime.now();
    _name = await StorageManager.readData("name");
    _image = await StorageManager.readData("image");
    _email = await StorageManager.readData("email");
    _phoneNumber = await StorageManager.readData("phoneNumber");
    _role = await StorageManager.readData("role");
    await getCheckInList(status: "1");
    await getCheckOutList(status: "2");
    setState(() {});
  }

  Future getCheckInList({
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    _checkInList = await getBooksService(
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future getCheckOutList({
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    _checkOutList = await getBooksService(
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<void> _selectCheckInDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedCheckInDate = picked;
        _checkInDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
      });
    }
  }

  Future<void> _selectCheckOutDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckOutDate,
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedCheckOutDate = picked;
        _checkOutDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckOutDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ໜ້າຫຼັກ"),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ).then((value) => _readData());
            },
            child: CircleAvatar(
              radius: 21,
              backgroundColor: ColorConstants.black,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: ColorConstants.primary,
                backgroundImage: _image != null && _image != ""
                    ? NetworkImage(_image!)
                    : null,
                child: _image == null || _image == ""
                    ? Icon(
                        Icons.person,
                        color: ColorConstants.black,
                        size: 35,
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: double.infinity,
        color: ColorConstants.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 10),
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          ).then((value) => _readData());
                        },
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: ColorConstants.primary,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: _image != null && _image != ""
                                ? NetworkImage(_image!)
                                : null,
                            child: _image == null || _image == ""
                                ? Icon(
                                    Icons.person,
                                    color: ColorConstants.black,
                                    size: 50,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "${_name!.length > 15 ? _name!.substring(0, 15) + '...' : _name}\n${_email!.length > 15 ? _email!.substring(0, 3) + '...' + _email!.split("@")[0].substring(_email!.split("@")[0].length - 2, _email!.split("@")[0].length) + '@' + _email!.split("@")[1] : _email}\n$_phoneNumber",
                        style: getRegularStyle(
                            fontSize: FontSizes.s14,
                            color: ColorConstants.primary),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: ColorConstants.primary,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.person_outline_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຂໍ້ມຸນຜູ້ໃຊ້",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  ).then((value) => _readData());
                },
              ),
              _role != 1
                  ? SizedBox()
                  : ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StaffPage()),
                        );
                      },
                      leading: Icon(
                        Icons.people_outline,
                        color: ColorConstants.primary,
                        size: 30,
                      ),
                      title: Text(
                        "ຂໍ້ມຸນພະນັກງານ",
                        style: getRegularStyle(color: ColorConstants.primary),
                      ),
                    ),
              _role != 1
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.group,
                        color: ColorConstants.primary,
                        size: 30,
                      ),
                      title: Text(
                        "ຂໍ້ມຸນສະມາຊິກ",
                        style: getRegularStyle(color: ColorConstants.primary),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MemberPage()),
                        );
                      },
                    ),
              _role != 1
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.auto_awesome_mosaic_outlined,
                        color: ColorConstants.primary,
                        size: 30,
                      ),
                      title: Text(
                        "ຂໍ້ມຸນປະເພດຫ້ອງ",
                        style: getRegularStyle(color: ColorConstants.primary),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomTypePage()),
                        );
                      },
                    ),
              _role != 1
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.bed_outlined,
                        color: ColorConstants.primary,
                        size: 30,
                      ),
                      title: Text(
                        "ຂໍ້ມຸນຫ້ອງ",
                        style: getRegularStyle(color: ColorConstants.primary),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RoomPage()),
                        );
                      },
                    ),
              ListTile(
                leading: Icon(
                  Icons.add_circle_outline_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ຈອງຫ້ອງ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManualBookPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_circle_down_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ແຈ້ງເຂົ້າ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckInPage()),
                  ).then((value) async {
                    await getCheckInList(status: "1");
                    await getCheckOutList(status: "2");
                    setState(() {});
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.arrow_circle_up_rounded,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ແຈ້ງອອກ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckOutPage()),
                  ).then((value) async {
                    await getCheckInList(status: "1");
                    await getCheckOutList(status: "2");
                    setState(() {});
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.work_history_outlined,
                  color: ColorConstants.primary,
                  size: 30,
                ),
                title: Text(
                  "ປະຫວັດການຈອງ",
                  style: getRegularStyle(color: ColorConstants.primary),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryBookPage()),
                  ).then((value) async {
                    await getCheckInList(status: "1");
                    await getCheckOutList(status: "2");
                    setState(() {});
                  });
                },
              ),
              _role != 1
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(
                        Icons.graphic_eq_rounded,
                        color: ColorConstants.primary,
                        size: 30,
                      ),
                      title: Text(
                        "ລາຍງານ",
                        style: getRegularStyle(color: ColorConstants.primary),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReportPage()),
                        );
                      },
                    ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: ColorConstants.danger,
                  size: 30,
                ),
                title: Text(
                  "ອອກຈາກລະບົບ",
                  style: getRegularStyle(color: ColorConstants.danger),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return WarningDialogWidget(
                        detail: "ທ່ານຕ້ອງອອກຈາກລະບົບບໍ?",
                        onConfirm: () {
                          StorageManager.deleteData("id");
                          StorageManager.deleteData("name");
                          StorageManager.deleteData("image");
                          StorageManager.deleteData("email");
                          StorageManager.deleteData("phoneNumber");
                          StorageManager.deleteData("token");
                          StorageManager.deleteData("password");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _checkInList == null || _checkOutList == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
                backgroundColor: ColorConstants.primary,
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorConstants.black,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2, bottom: 2),
                                  child: Text(
                                    "ຈາກວັນທີ່",
                                    style: getRegularStyle(
                                        color: ColorConstants.white),
                                  ),
                                ),
                                TextFormField(
                                  controller: _checkInDateController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: ColorConstants.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstants.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: ColorConstants.white),
                                    ),
                                    hintText: "YYYY-MM-DD",
                                    hintStyle: getRegularStyle(
                                        color: ColorConstants.lightGrey),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstants.danger),
                                    ),
                                    errorStyle: getRegularStyle(
                                        color: ColorConstants.danger),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        _selectCheckInDateFunction(context);
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        color: ColorConstants.primary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Icon(
                              Icons.arrow_right_alt_rounded,
                              color: ColorConstants.primary,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2, bottom: 2),
                                  child: Text(
                                    "ຫາວັນທີ່",
                                    style: getRegularStyle(
                                        color: ColorConstants.white),
                                  ),
                                ),
                                TextFormField(
                                  controller: _checkOutDateController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: ColorConstants.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstants.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: ColorConstants.white),
                                    ),
                                    hintText: "YYYY-MM-DD",
                                    hintStyle: getRegularStyle(
                                        color: ColorConstants.lightGrey),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: ColorConstants.danger),
                                    ),
                                    errorStyle: getRegularStyle(
                                        color: ColorConstants.danger),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        _selectCheckOutDateFunction(context);
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        color: ColorConstants.primary,
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await getCheckInList(status: "1");
                                  await getCheckOutList(status: "2");
                                  setState(() {
                                    _checkInDateController.clear();
                                    _checkOutDateController.clear();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.danger,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh_rounded,
                                      color: ColorConstants.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "ລ້າງຂໍ້ມູນ",
                                      style: getBoldStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await getCheckInList(
                                    status: "1",
                                    startDate: _checkInDateController.text,
                                    endDate: _checkOutDateController.text,
                                  );
                                  await getCheckOutList(
                                    status: "2",
                                    startDate: _checkInDateController.text,
                                    endDate: _checkOutDateController.text,
                                  );
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_rounded,
                                      color: ColorConstants.black,
                                      size: 30,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "ຄົ້ນຫາ",
                                      style: getBoldStyle(
                                        color: ColorConstants.black,
                                        fontSize: FontSizes.s16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _checkInList!.result!.rows!.isEmpty &&
                              _checkOutList!.result!.rows!.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(
                                child: Text(
                                  "ບໍ່ມີຂໍ້ມູນ",
                                  style: getBoldStyle(fontSize: FontSizes.s20),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "ລາຍການລໍຖ້າແຈ້ງເຂົ້າ",
                                    style: getBoldStyle(),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _checkInList!.result!.rows!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookDetailPage(
                                                      id: _checkInList!.result!
                                                          .rows![index].id!)),
                                        ).then((value) async {
                                          await getCheckInList(status: "1");
                                          await getCheckOutList(status: "2");
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: index == 0
                                                    ? BorderSide(
                                                        color: ColorConstants
                                                            .lightGrey,
                                                        width: 0.3)
                                                    : BorderSide.none,
                                                bottom: BorderSide(
                                                    color: ColorConstants
                                                        .lightGrey,
                                                    width: 0.3))),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 21,
                                              backgroundColor:
                                                  ColorConstants.black,
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    ColorConstants.primary,
                                                backgroundImage: _checkInList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image !=
                                                            null &&
                                                        _checkInList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image !=
                                                            ""
                                                    ? NetworkImage(_checkInList!
                                                        .result!
                                                        .rows![index]
                                                        .member!
                                                        .image!)
                                                    : null,
                                                child: _checkInList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image ==
                                                            null ||
                                                        _checkInList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image ==
                                                            ""
                                                    ? Icon(
                                                        Icons.person,
                                                        color: ColorConstants
                                                            .black,
                                                        size: 35,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_checkInList!.result!.rows![index].member!.gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                                          "${_checkInList!.result!.rows![index].member!.name} "
                                                          "${_checkInList!.result!.rows![index].member!.lastName}" +
                                                      " | " +
                                                      "${_checkInList!.result!.rows![index].createdAt!.substring(0, 10)}",
                                                  style: getRegularStyle(
                                                      color:
                                                          ColorConstants.white),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "ແຈ້ງເຂົ້າ: ${_checkInList!.result!.rows![index].checkInDate!.substring(0, 10)} | ແຈ້ງອອກ: ${_checkInList!.result!.rows![index].checkOutDate!.substring(0, 10)}",
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .lightGrey,
                                                      fontSize: FontSizes.s12),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ColorConstants.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "ລາຍການລໍຖ້າແຈ້ງອອກ",
                                    style: getBoldStyle(),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      _checkOutList!.result!.rows!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookDetailPage(
                                                      id: _checkOutList!.result!
                                                          .rows![index].id!)),
                                        ).then((value) async {
                                          await getCheckInList(status: "1");
                                          await getCheckOutList(status: "2");
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: index == 0
                                                    ? BorderSide(
                                                        color: ColorConstants
                                                            .lightGrey,
                                                        width: 0.3)
                                                    : BorderSide.none,
                                                bottom: BorderSide(
                                                    color: ColorConstants
                                                        .lightGrey,
                                                    width: 0.3))),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 21,
                                              backgroundColor:
                                                  ColorConstants.black,
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    ColorConstants.primary,
                                                backgroundImage: _checkOutList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image !=
                                                            null &&
                                                        _checkOutList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image !=
                                                            ""
                                                    ? NetworkImage(
                                                        _checkOutList!
                                                            .result!
                                                            .rows![index]
                                                            .member!
                                                            .image!)
                                                    : null,
                                                child: _checkOutList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image ==
                                                            null ||
                                                        _checkOutList!
                                                                .result!
                                                                .rows![index]
                                                                .member!
                                                                .image ==
                                                            ""
                                                    ? Icon(
                                                        Icons.person,
                                                        color: ColorConstants
                                                            .black,
                                                        size: 35,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_checkOutList!.result!.rows![index].member!.gender == "ຊາຍ" ? "ທ້າວ" : "ນາງ"} "
                                                          "${_checkOutList!.result!.rows![index].member!.name} "
                                                          "${_checkOutList!.result!.rows![index].member!.lastName}" +
                                                      " | " +
                                                      "${_checkOutList!.result!.rows![index].createdAt!.substring(0, 10)}",
                                                  style: getRegularStyle(
                                                      color:
                                                          ColorConstants.white),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "ແຈ້ງເຂົ້າ: ${_checkOutList!.result!.rows![index].checkInDate!.substring(0, 10)} | ແຈ້ງອອກ: ${_checkOutList!.result!.rows![index].checkOutDate!.substring(0, 10)}",
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .lightGrey,
                                                      fontSize: FontSizes.s12),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ColorConstants.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScanQrCodePage()),
                    ).then((value) async {
                      await getCheckInList(status: "1");
                      await getCheckOutList(status: "2");
                      setState(() {});
                    });
                  },
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 35,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ແຈ້ງເຂົ້າ-ແຈ້ງອອກ",
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
