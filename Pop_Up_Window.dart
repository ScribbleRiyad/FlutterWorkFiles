import 'package:flutter/material.dart';

import 'package:garibook/app/utilities/theme_styles.dart';
import 'package:garibook/app/widgets/custom_button.dart';

import 'package:garibook/app/widgets/garibook_text_widgets.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:lottie/lottie.dart';

popUserSuccess({context, onOkTap, text}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Lottie.asset('assets/images/lottie/car.json',
                repeat: false, height: 150, width: 150),
            content: Padding(
              padding: const EdgeInsets.only(
                  top: 5.00, bottom: 5.00, left: 15, right: 15),
              child: GaribookTextWidget(
                text: text,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: ThemeStyles.secondaryTextColor,
                textAlign: TextAlign.center,
                maxLines: 6,
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 18.0),
            actions: [
              SizedBox(
                  height: 50,
                  child: CustomButton(
                    buttonText: 'OK'.tr,
                    fontSize: 18,
                    borderRadius: 10,
                    onTap: onOkTap,
                    buttonColor: ThemeStyles.greenColor,
                    textColor: ThemeStyles.whiteColor,
                  )),
            ]);
      });
}
