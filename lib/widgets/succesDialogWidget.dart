import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class SuccessDialogWidget extends StatelessWidget {
  final String detail;
  SuccessDialogWidget({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstants.white,
      actionsPadding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 20),
      icon: Icon(
        Icons.check_circle_outline_rounded,
        color: ColorConstants.success,
        size: 60,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      buttonPadding: EdgeInsets.zero,
      content: Text(
        detail,
        textAlign: TextAlign.center,
        style: getBoldStyle(color: ColorConstants.black),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "ຕົກລົງ",
            style: getBoldStyle(color: ColorConstants.info),
          ),
        ),
      ],
    );
  }
}
