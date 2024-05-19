import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:flutter/material.dart';

class LoadingDialogWidget {
  static Future<void> showLoading(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: ColorConstants.darkGrey,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: ColorConstants.black,
                          backgroundColor: ColorConstants.primary,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'ກຳລັງດຳເນີນ...',
                          style: getRegularStyle(),
                        )
                      ],
                    ),
                  )
                ]),
          );
        });
  }
}
