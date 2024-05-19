import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/bookBodyModel.dart';
import 'package:bounchan_hotel_admin_app/models/roomManualModel.dart';
import 'package:bounchan_hotel_admin_app/pages/manualBook/manualBookDetailPage.dart';
import 'package:bounchan_hotel_admin_app/services/roomService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bounchan_hotel_admin_app/models/bookBodyModel.dart'
    as bookBodyModel;

class ManualBookPage extends StatefulWidget {
  const ManualBookPage({super.key});

  @override
  State<ManualBookPage> createState() => _ManualBookPageState();
}

class _ManualBookPageState extends State<ManualBookPage> {
  final _checkInDateController = TextEditingController();
  final _checkOutDateController = TextEditingController();
  late DateTime _selectedCheckInDate;
  late DateTime _selectedCheckOutDate;
  RoomsManualModel? _roomsModel;
  bookBodyModel.BookBodyModel _bookBodyModel = BookBodyModel(
      item: Item(checkInDate: "", checkOutDate: "", amount: 0, rooms: []));
  bookBodyModel.Rooms room =
      bookBodyModel.Rooms(roomId: "", roomNo: "", price: 0);

  Future getRooms() async {
    _roomsModel = await getRoomsManualService();
    _selectedCheckInDate = DateTime.now();
    _selectedCheckOutDate = DateTime.now().add(Duration(days: 1));
    setState(() {
      _checkInDateController.text =
          DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
      _checkOutDateController.text =
          DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
      _bookBodyModel.item!.checkInDate = _checkInDateController.text;
      _bookBodyModel.item!.checkOutDate = _checkOutDateController.text;
    });
  }

  Future<void> _selectCheckInDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedCheckInDate) {
      setState(() {
        _selectedCheckInDate = picked;
        _checkInDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
        _bookBodyModel.item!.checkInDate = _checkInDateController.text;
        if (_selectedCheckInDate.isAfter(DateTime(
            int.parse(_checkOutDateController.text.substring(0, 4)),
            int.parse(_checkOutDateController.text.substring(5, 7)),
            int.parse(_checkOutDateController.text.substring(8, 10))))) {
          _selectedCheckOutDate = _selectedCheckInDate.add(Duration(days: 1));
          _checkOutDateController.text =
              DateFormat('yyyy-MM-dd').format(_selectedCheckOutDate);
          _bookBodyModel.item!.checkOutDate = _checkOutDateController.text;
        }
      });
    }
  }

  Future<void> _selectCheckOutDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckOutDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedCheckOutDate) {
      setState(() {
        _selectedCheckOutDate = picked;
        _checkOutDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedCheckOutDate);
        _bookBodyModel.item!.checkOutDate = _checkOutDateController.text;
        if (_selectedCheckOutDate.isBefore(DateTime(
            int.parse(_checkInDateController.text.substring(0, 4)),
            int.parse(_checkInDateController.text.substring(5, 7)),
            int.parse(_checkInDateController.text.substring(8, 10))))) {
          _selectedCheckInDate = _selectedCheckOutDate.add(Duration(days: -1));
          _checkInDateController.text =
              DateFormat('yyyy-MM-dd').format(_selectedCheckInDate);
          _bookBodyModel.item!.checkInDate = _checkInDateController.text;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text(_bookBodyModel.item!.rooms!.isEmpty
            ? "ຈອງຫ້ອງ"
            : "ຈອງຫ້ອງ (${_bookBodyModel.item!.rooms!.length})"),
      ),
      body: _roomsModel == null
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
              padding: EdgeInsets.only(bottom: 1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2, bottom: 2),
                                  child: Text(
                                    "ວັນທີ່ແຈ້ງເຂົ້າ",
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
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  style: getRegularStyle(
                                      color: ColorConstants.white),
                                  validator: (value) {
                                    if (_checkInDateController.text.isEmpty ||
                                        _checkInDateController.text == "") {
                                      return "ກະລຸນາເລືອກວັນທີ່ແຈ້ງເຂົ້າ";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2, bottom: 2),
                                  child: Text(
                                    "ວັນທີ່ແຈ້ງອອກ",
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
                                  validator: (value) {
                                    if (_checkOutDateController.text.isEmpty ||
                                        _checkOutDateController.text == "") {
                                      return "ກະລຸນາເລືອກວັນທີ່ແຈ້ງອອກ";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: _roomsModel!.result!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (_roomsModel!.result![index].rooms!.isEmpty) {
                          return SizedBox();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 5, right: 5, bottom: 5),
                              child: Text(
                                "${_roomsModel!.result![index].roomType!.name!}",
                                style:
                                    getBoldStyle(color: ColorConstants.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: SizedBox(
                                height: 260,
                                child: ListView.builder(
                                  itemCount:
                                      _roomsModel!.result![index].rooms!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: i == 0 ? 0 : 3,
                                          right: i == 9 ? 0 : 3),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ColorConstants.primary,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: ColorConstants.black
                                                      .withAlpha(_roomsModel!
                                                              .result![index]
                                                              .rooms![i]
                                                              .checked!
                                                          ? 50
                                                          : 0),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(6),
                                                              topRight: Radius
                                                                  .circular(6)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            "${_roomsModel!.result![index].rooms![i].roomImages![0].image!}"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 200,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "ຫ້ອງເບີ: ${_roomsModel!.result![index].rooms![i].roomNo ?? ""}",
                                                            style: getRegularStyle(
                                                                color:
                                                                    ColorConstants
                                                                        .black),
                                                          ),
                                                          SizedBox(width: 20),
                                                          Container(
                                                            height: 25,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                color: _roomsModel!.result![index].rooms![i].status == 3
                                                                    ? ColorConstants.danger
                                                                    : _roomsModel!.result![index].rooms![i].status == 2
                                                                        ? _selectedCheckInDate.isAfter(DateTime(int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(0, 4)), int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(5, 7)), int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(8, 10))))
                                                                            ? ColorConstants.success
                                                                            : ColorConstants.danger
                                                                        : ColorConstants.success,
                                                                borderRadius: BorderRadius.circular(12)),
                                                            child: Center(
                                                              child: Text(
                                                                _roomsModel!
                                                                            .result![
                                                                                index]
                                                                            .rooms![
                                                                                i]
                                                                            .status ==
                                                                        3
                                                                    ? "ບໍ່ຫວ່າງ"
                                                                    : _roomsModel!.result![index].rooms![i].status ==
                                                                            2
                                                                        ? _selectedCheckInDate.isAfter(DateTime(
                                                                                int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(0, 4)),
                                                                                int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(5, 7)),
                                                                                int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(8, 10))))
                                                                            ? "ຫວ່າງ"
                                                                            : "ບໍ່ຫວ່າງ"
                                                                        : "ຫວ່າງ",
                                                                style:
                                                                    getRegularStyle(),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 0),
                                                    child: Wrap(
                                                      children: [
                                                        Text(
                                                          "ລາຄາ: ",
                                                          style: getRegularStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .black,
                                                              fontSize:
                                                                  FontSizes
                                                                      .s16),
                                                        ),
                                                        Text(
                                                          "${NumberFormat("#,###.## ກີບ").format(_roomsModel!.result![index].rooms![i].price ?? 0)}",
                                                          style: getBoldStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .error,
                                                              fontSize:
                                                                  FontSizes
                                                                      .s16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: _roomsModel!.result![index]
                                                        .rooms![i].status ==
                                                    3
                                                ? SizedBox()
                                                : _roomsModel!.result![index]
                                                            .rooms![i].status ==
                                                        2
                                                    ? _selectedCheckInDate.isAfter(DateTime(
                                                            int.parse(_roomsModel!
                                                                .result![index]
                                                                .rooms![i]
                                                                .lastCheckOut
                                                                .substring(
                                                                    0, 4)),
                                                            int.parse(_roomsModel!
                                                                .result![index]
                                                                .rooms![i]
                                                                .lastCheckOut
                                                                .substring(
                                                                    5, 7)),
                                                            int.parse(_roomsModel!.result![index].rooms![i].lastCheckOut.substring(8, 10))))
                                                        ? Checkbox(
                                                            value: _roomsModel!.result![index].rooms![i].checked ?? false,
                                                            fillColor: MaterialStateProperty.resolveWith((states) {
                                                              if (!states.contains(
                                                                  MaterialState
                                                                      .selected)) {
                                                                return ColorConstants
                                                                    .black;
                                                              }
                                                              return null;
                                                            }),
                                                            visualDensity: VisualDensity(
                                                              horizontal: -3.0,
                                                              vertical: -3.0,
                                                            ),
                                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                            activeColor: ColorConstants.black,
                                                            checkColor: ColorConstants.white,
                                                            onChanged: (value) {
                                                              _roomsModel!
                                                                      .result![
                                                                          index]
                                                                      .rooms![i]
                                                                      .checked =
                                                                  !_roomsModel!
                                                                      .result![
                                                                          index]
                                                                      .rooms![i]
                                                                      .checked!;
                                                              if (value ==
                                                                  true) {
                                                                _bookBodyModel
                                                                    .item!
                                                                    .amount = _bookBodyModel
                                                                        .item!
                                                                        .amount! +
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price!;
                                                                room = bookBodyModel
                                                                    .Rooms(
                                                                        roomId:
                                                                            "",
                                                                        roomNo:
                                                                            "",
                                                                        price:
                                                                            0);
                                                                room.roomId =
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .id!;
                                                                room.roomNo =
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .roomNo!;
                                                                room.price = _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price ??
                                                                    0;
                                                                _bookBodyModel
                                                                    .item!
                                                                    .rooms!
                                                                    .add(room);
                                                              } else {
                                                                print(
                                                                    "--------->>>0 ${room.roomNo}");
                                                                _bookBodyModel
                                                                    .item!
                                                                    .amount = _bookBodyModel
                                                                        .item!
                                                                        .amount! -
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price!;
                                                                if (_bookBodyModel
                                                                        .item!
                                                                        .amount! <
                                                                    0) {
                                                                  _bookBodyModel
                                                                      .item!
                                                                      .amount = 0;
                                                                }
                                                                room = bookBodyModel
                                                                    .Rooms(
                                                                        roomId:
                                                                            "",
                                                                        roomNo:
                                                                            "",
                                                                        price:
                                                                            0);
                                                                room.roomId =
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .id!;
                                                                room.roomNo =
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .roomNo!;
                                                                room.price = _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price ??
                                                                    0;
                                                                _bookBodyModel
                                                                    .item!
                                                                    .rooms!
                                                                    .removeWhere((item) =>
                                                                        item.roomNo ==
                                                                        room.roomNo);
                                                              }
                                                              setState(() {});
                                                            })
                                                        : SizedBox()
                                                    : Checkbox(
                                                        value: _roomsModel!.result![index].rooms![i].checked ?? false,
                                                        fillColor: MaterialStateProperty.resolveWith((states) {
                                                          if (!states.contains(
                                                              MaterialState
                                                                  .selected)) {
                                                            return ColorConstants
                                                                .black;
                                                          }
                                                          return null;
                                                        }),
                                                        visualDensity: VisualDensity(
                                                          horizontal: -3.0,
                                                          vertical: -3.0,
                                                        ),
                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        activeColor: ColorConstants.black,
                                                        checkColor: ColorConstants.white,
                                                        onChanged: (value) {
                                                          if (value!) {
                                                            _bookBodyModel.item!
                                                                    .amount =
                                                                _bookBodyModel
                                                                        .item!
                                                                        .amount! +
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price!;
                                                            room = bookBodyModel
                                                                .Rooms(
                                                                    roomId: "",
                                                                    roomNo: "",
                                                                    price: 0);
                                                            room.roomId =
                                                                _roomsModel!
                                                                    .result![
                                                                        index]
                                                                    .rooms![i]
                                                                    .id!;
                                                            room.roomNo =
                                                                _roomsModel!
                                                                    .result![
                                                                        index]
                                                                    .rooms![i]
                                                                    .roomNo!;
                                                            room.price =
                                                                _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price ??
                                                                    0;
                                                            _bookBodyModel
                                                                .item!.rooms!
                                                                .add(room);
                                                          } else {
                                                            _bookBodyModel.item!
                                                                    .amount =
                                                                _bookBodyModel
                                                                        .item!
                                                                        .amount! -
                                                                    _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price!;
                                                            if (_bookBodyModel
                                                                    .item!
                                                                    .amount! <
                                                                0) {
                                                              _bookBodyModel
                                                                  .item!
                                                                  .amount = 0;
                                                            }
                                                            room = bookBodyModel
                                                                .Rooms(
                                                                    roomId: "",
                                                                    roomNo: "",
                                                                    price: 0);
                                                            room.roomId =
                                                                _roomsModel!
                                                                    .result![
                                                                        index]
                                                                    .rooms![i]
                                                                    .id!;
                                                            room.roomNo =
                                                                _roomsModel!
                                                                    .result![
                                                                        index]
                                                                    .rooms![i]
                                                                    .roomNo!;
                                                            room.price =
                                                                _roomsModel!
                                                                        .result![
                                                                            index]
                                                                        .rooms![
                                                                            i]
                                                                        .price ??
                                                                    0;
                                                            _bookBodyModel
                                                                .item!.rooms!
                                                                .removeWhere((item) =>
                                                                    item.roomNo ==
                                                                    room.roomNo);
                                                          }
                                                          setState(() {
                                                            _roomsModel!
                                                                    .result![index]
                                                                    .rooms![i]
                                                                    .checked =
                                                                !_roomsModel!
                                                                    .result![
                                                                        index]
                                                                    .rooms![i]
                                                                    .checked!;
                                                          });
                                                        }),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
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
                  onTap: _bookBodyModel.item!.rooms!.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManualBookDetailPage(
                                    bookBodyModel: _bookBodyModel)),
                          );
                        },
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ຖັດໄປ",
                        style: getBoldStyle(
                          color: ColorConstants.black,
                          fontSize: FontSizes.s18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorConstants.black,
                        size: 25,
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
