import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        title: Text("ລາຍລະອຽດ"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Container(
            width: MediaQuery.of(context).size.width - 12,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorConstants.white),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ຊື່:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "ທ່ານ ອາວຸດ",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ນາມສະກຸນ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "ປະສິດທິພາບ",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ເບີໂທ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "2078966646",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ອີເມລ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "example@gmail.com",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ຫ້ອງເບີ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "01",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ປະເພດຫ້ອງ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "ຕຽງຄູ່",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີແຈ້ງເຂົ້າ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "2024-01-01",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີ່ແຈ້ງອອກ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "2024-01-05",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorConstants.lightGrey, height: 1),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ວັນທີຈອງ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "2014-01-01",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: ColorConstants.lightGrey,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ສະຖານະ:\n",
                                style: getRegularStyle(
                                  color: ColorConstants.lightGrey,
                                  fontSize: FontSizes.s16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "ລໍແຈ້ງເຂົ້າ",
                                      style: getRegularStyle(
                                        color: ColorConstants.white,
                                        fontSize: FontSizes.s16,
                                      ))
                                ]),
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
                  onTap: () {},
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ແຈ້ງເຂົ້າ",
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
