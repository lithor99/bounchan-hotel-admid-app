import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/reportChartModel.dart';
import 'package:bounchan_hotel_admin_app/services/reportService.dart';
import 'package:bounchan_hotel_admin_app/widgets/IncomeChartWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/bookChartWidget.dart';
import 'package:bounchan_hotel_admin_app/widgets/memberChartWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _yearController = TextEditingController();
  DateTime? _startYear;
  ReportChartModel? _reportChartModel;
  bool _isLoading = false;

  Future<void> selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startYear!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _startYear) {
      setState(() {
        _startYear = picked;
        _yearController.text = DateFormat('yyyy').format(_startYear!);
      });
    }
  }

  Future getReportChart({required String year}) async {
    _reportChartModel = await reportChartService(year: _yearController.text);
  }

  Future searchData({required String year}) async {
    print("year--------------------> $year");
    await getReportChart(year: year);
    setState(() {});
  }

  Future initialData() async {
    _isLoading = true;
    _startYear = DateTime.now();
    if (_startYear != null) {
      String formattedDate = DateFormat('yyyy').format(_startYear!);
      setState(() {
        _yearController.text = formattedDate;
      });
    }
    await searchData(year: _yearController.text);
    _isLoading = false;
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? SizedBox()
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 80,
                          margin: EdgeInsets.all(10),
                          height: 50,
                          child: TextFormField(
                            controller: _yearController,
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
                                  selectYear(context);
                                },
                              ),
                            ),
                            style: getRegularStyle(color: ColorConstants.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await searchData(year: _yearController.text);
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
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: double.infinity,
                      color: ColorConstants.black,
                      child: AspectRatio(
                        aspectRatio: 1.23,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(
                                  height: 37,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 6),
                                    child: MemberChartWidget(
                                      data: _reportChartModel!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                        "ເສັ້ນສະແດງການສະໝັກເປັນສະມາຊິກປະຈຳປີ ${_yearController.text}",
                        style: getBoldStyle(fontSize: FontSizes.s16)),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: double.infinity,
                      color: ColorConstants.black,
                      child: AspectRatio(
                        aspectRatio: 1.23,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(
                                  height: 37,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 6),
                                    child: BookChartWidget(
                                      data: _reportChartModel!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("ເສັ້ນສະແດງການຈອງປະຈຳປີ ${_yearController.text}",
                        style: getBoldStyle(fontSize: FontSizes.s16)),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: ColorConstants.success,
                        ),
                        SizedBox(width: 5),
                        Text("ລາຍການສຳເລັດ", style: getRegularStyle()),
                        SizedBox(width: 50),
                        Container(
                          height: 10,
                          width: 10,
                          color: ColorConstants.danger,
                        ),
                        SizedBox(width: 5),
                        Text("ລາຍການຍົກເລີກ", style: getRegularStyle()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: double.infinity,
                      color: ColorConstants.black,
                      child: AspectRatio(
                        aspectRatio: 1.23,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(
                                  height: 37,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 6),
                                    child: IncomeChartWidget(
                                      data: _reportChartModel!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("ເສັ້ນສະແດງລາຍຮັບປະຈຳປີ ${_yearController.text}",
                        style: getBoldStyle(fontSize: FontSizes.s16)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }
}
