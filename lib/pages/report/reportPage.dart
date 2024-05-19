import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/membersModel.dart';
import 'package:bounchan_hotel_admin_app/models/reportBookModel.dart';
import 'package:bounchan_hotel_admin_app/models/reportIncomeModel.dart';
import 'package:bounchan_hotel_admin_app/services/reportService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  ReportIncomeModel? _incomeModel;
  ReportBookModel? _bookModel;
  MembersModel? _membersModel;

  Future getReportIncome({
    required String startDate,
    required String endDate,
  }) async {
    _incomeModel =
        await reportIncomeService(startDate: startDate, endDate: endDate);
  }

  Future getReportBook({
    required String startDate,
    required String endDate,
  }) async {
    _bookModel =
        await reportBookService(startDate: startDate, endDate: endDate);
  }

  Future getReportMember({
    required String startDate,
    required String endDate,
  }) async {
    _membersModel =
        await reportMemberService(startDate: startDate, endDate: endDate);
  }

  Future searchData({
    required String startDate,
    required String endDate,
  }) async {
    await getReportIncome(
        startDate: _startDateController.text, endDate: _endDateController.text);
    await getReportBook(
        startDate: _startDateController.text, endDate: _endDateController.text);
    await getReportMember(
        startDate: _startDateController.text, endDate: _endDateController.text);
    setState(() {});
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
        _startDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedStartDate!);
        if (_selectedStartDate!.isAfter(DateTime(
            int.parse(_endDateController.text.substring(0, 4)),
            int.parse(_endDateController.text.substring(5, 7)),
            int.parse(_endDateController.text.substring(8, 10))))) {
          _selectedEndDate = _selectedStartDate!.add(Duration(days: 1));
          _endDateController.text =
              DateFormat('yyyy-MM-dd').format(_selectedEndDate!);
        }
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
        _endDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedEndDate!);
        if (_selectedEndDate!.isBefore(DateTime(
            int.parse(_startDateController.text.substring(0, 4)),
            int.parse(_startDateController.text.substring(5, 7)),
            int.parse(_startDateController.text.substring(8, 10))))) {
          _selectedStartDate = _selectedEndDate!.add(Duration(days: -1));
          _startDateController.text =
              DateFormat('yyyy-MM-dd').format(_selectedStartDate!);
        }
      });
    }
  }

  Future initialData() async {
    _selectedStartDate = DateTime.now().add(Duration(days: -30));
    if (_selectedStartDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(_selectedStartDate!);
      setState(() {
        _startDateController.text = formattedDate;
      });
    }
    _selectedEndDate = DateTime.now();
    if (_selectedEndDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedEndDate!);
      setState(() {
        _endDateController.text = formattedDate;
      });
    }
    await searchData(
        startDate: _startDateController.text, endDate: _endDateController.text);
  }

  @override
  void initState() {
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          title: Text("ລາຍງານ"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: ColorConstants.danger,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "ລາຍງານລາຍຮັບ",
                        style: getRegularStyle(
                            fontSize: FontSizes.s14,
                            color: ColorConstants.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    height: 45,
                    width: double.infinity,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "ລາຍງານການຈອງ",
                        style: getRegularStyle(
                            fontSize: FontSizes.s14,
                            color: ColorConstants.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    height: 45,
                    width: double.infinity,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        "ລາຍງານສະມາຊິກ",
                        style: getRegularStyle(
                            fontSize: FontSizes.s14,
                            color: ColorConstants.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    height: 45,
                    width: double.infinity,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _startDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectStartDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "ຫາ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _endDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectEndDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await searchData(
                                startDate: _startDateController.text,
                                endDate: _endDateController.text);
                          },
                          splashColor: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: ColorConstants.black,
                                border: Border.all(
                                    color: ColorConstants.primary, width: 1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              Icons.search_rounded,
                              color: ColorConstants.primary,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                _incomeModel == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.black,
                          backgroundColor: ColorConstants.primary,
                        ),
                      )
                    : _incomeModel!.result!.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "ບໍ່ມີຂໍ້ມູນ",
                                style: getBoldStyle(fontSize: FontSizes.s20),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: DataTable(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  width: 1,
                                                  color: ColorConstants
                                                      .lightGrey))),
                                      columnSpacing: 30,
                                      showBottomBorder: true,
                                      columns: <DataColumn>[
                                        DataColumn(
                                            label: Text(
                                              'ລຳດັບ',
                                              style: getRegularStyle(
                                                  color:
                                                      ColorConstants.lightGrey),
                                            ),
                                            numeric: true),
                                        DataColumn(
                                            label: Text(
                                              'ຈຳນວນໃບບິນ',
                                              style: getRegularStyle(
                                                  color:
                                                      ColorConstants.lightGrey),
                                            ),
                                            numeric: true),
                                        DataColumn(
                                            label: Text(
                                              'ຈຳນວນເງິນ',
                                              style: getRegularStyle(
                                                  color:
                                                      ColorConstants.lightGrey),
                                            ),
                                            numeric: true),
                                        DataColumn(
                                            label: Text(
                                          'ວັນທີ',
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey),
                                        )),
                                      ],
                                      rows: <DataRow>[
                                        for (int i = 0;
                                            i < _incomeModel!.result!.length;
                                            i++)
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text('${i + 1}',
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .white))),
                                              DataCell(Text(
                                                  '${_incomeModel!.result![i].count ?? ""}',
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .white))),
                                              DataCell(Text(
                                                  '${NumberFormat("#,### ກີບ").format(int.parse(_incomeModel!.result![i].amount ?? "0"))}',
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .white))),
                                              DataCell(Text(
                                                  '${_incomeModel!.result![i].date ?? ""}',
                                                  style: getRegularStyle(
                                                      color: ColorConstants
                                                          .white))),
                                            ],
                                          )
                                      ]),
                                ),
                              ),
                            ),
                          ),
              ],
            ),
            Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _startDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectStartDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "ຫາ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _endDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectEndDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await searchData(
                                startDate: _startDateController.text,
                                endDate: _endDateController.text);
                          },
                          splashColor: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: ColorConstants.black,
                                border: Border.all(
                                    color: ColorConstants.primary, width: 1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              Icons.search_rounded,
                              color: ColorConstants.primary,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                _bookModel == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.black,
                          backgroundColor: ColorConstants.primary,
                        ),
                      )
                    : _bookModel!.result!.rows!.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "ບໍ່ມີຂໍ້ມູນ",
                                style: getBoldStyle(fontSize: FontSizes.s20),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color:
                                                    ColorConstants.lightGrey))),
                                    showBottomBorder: true,
                                    columnSpacing: 30,
                                    columns: <DataColumn>[
                                      DataColumn(
                                          label: Text(
                                            'ລຳດັບ',
                                            style: getRegularStyle(
                                                color:
                                                    ColorConstants.lightGrey),
                                          ),
                                          numeric: true),
                                      DataColumn(
                                          label: Text(
                                            'ຈຳນວນຫ້ອງ',
                                            style: getRegularStyle(
                                                color:
                                                    ColorConstants.lightGrey),
                                          ),
                                          numeric: true),
                                      DataColumn(
                                          label: Text(
                                            'ຈຳນວນເງິນ',
                                            style: getRegularStyle(
                                                color:
                                                    ColorConstants.lightGrey),
                                          ),
                                          numeric: true),
                                      DataColumn(
                                          label: Text(
                                        'ວັນທີ',
                                        style: getRegularStyle(
                                            color: ColorConstants.lightGrey),
                                      )),
                                      DataColumn(
                                        label: Text(
                                          'ສະຖານະ',
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey),
                                        ),
                                      ),
                                    ],
                                    rows: <DataRow>[
                                      for (int i = 0;
                                          i < _bookModel!.result!.rows!.length;
                                          i++)
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text('${i + 1}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                '${_bookModel!.result!.rows![i].bookDetails!.length}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                '${NumberFormat("#,###.00").format(_bookModel!.result!.rows![i].amount ?? 0)}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                '${_bookModel!.result!.rows![i].createdAt!.substring(0, 10)}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                '${_bookModel!.result!.rows![i].status == 1 ? "ລໍຖ້າແຈ້ງເຂົ້າ" : _bookModel!.result!.rows![i].status == 2 ? "ລໍຖ້າແຈ້ງອອກ" : _bookModel!.result!.rows![i].status == 3 ? "ແຈ້ງອອກແລ້ວ" : "ຍົກເລີກການຈອງ"}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                          ],
                                        )
                                    ]),
                              ),
                            ),
                          ),
              ],
            ),
            Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _startDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectStartDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "ຫາ",
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: TextFormField(
                            controller: _endDateController,
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
                                    width: 1, color: ColorConstants.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 0.5, color: ColorConstants.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.date_range,
                                    color: ColorConstants.primary),
                                onPressed: () {
                                  selectEndDate(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await searchData(
                                startDate: _startDateController.text,
                                endDate: _endDateController.text);
                          },
                          splashColor: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: ColorConstants.black,
                                border: Border.all(
                                    color: ColorConstants.primary, width: 1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              Icons.search_rounded,
                              color: ColorConstants.primary,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                _membersModel == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.black,
                          backgroundColor: ColorConstants.primary,
                        ),
                      )
                    : _membersModel!.result!.rows!.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                "ບໍ່ມີຂໍ້ມູນ",
                                style: getBoldStyle(fontSize: FontSizes.s20),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color:
                                                    ColorConstants.lightGrey))),
                                    showBottomBorder: true,
                                    columnSpacing: 30,
                                    columns: <DataColumn>[
                                      DataColumn(
                                          label: Text(
                                            'ລຳດັບ',
                                            style: getRegularStyle(
                                                color:
                                                    ColorConstants.lightGrey),
                                          ),
                                          numeric: true),
                                      DataColumn(
                                          label: Text(
                                        'ຊື່ ແລະ ນາມສະກຸນ',
                                        style: getRegularStyle(
                                            color: ColorConstants.lightGrey),
                                      )),
                                      DataColumn(
                                        label: Text(
                                          'ເພດ',
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey),
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                            'ວັນທີລົງທະບຽນ',
                                            style: getRegularStyle(
                                                color:
                                                    ColorConstants.lightGrey),
                                          ),
                                          numeric: true),
                                      DataColumn(
                                        label: Text(
                                          'ສະຖານະ',
                                          style: getRegularStyle(
                                              color: ColorConstants.lightGrey),
                                        ),
                                      ),
                                    ],
                                    rows: <DataRow>[
                                      for (int i = 0;
                                          i <
                                              _membersModel!
                                                  .result!.rows!.length;
                                          i++)
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text('${i + 1}',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                _membersModel!.result!.rows![i]
                                                        .name! +
                                                    ' ' +
                                                    _membersModel!.result!
                                                        .rows![i].lastName!,
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                _membersModel!
                                                    .result!.rows![i].gender!,
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                _membersModel!
                                                    .result!.rows![i].createdAt!
                                                    .substring(0, 10),
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                            DataCell(Text(
                                                _membersModel!.result!.rows![i]
                                                            .blocked ==
                                                        1
                                                    ? "ປິດ"
                                                    : "ເປີດ",
                                                style: getRegularStyle(
                                                    color:
                                                        ColorConstants.white))),
                                          ],
                                        )
                                    ]),
                              ),
                            ),
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
