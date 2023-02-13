import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garibook/app/provider/authenticaiton/authentication_provider.dart';
import 'package:garibook/app/utilities/theme_styles.dart';
import 'package:garibook/app/widgets/custom_button.dart';
import 'package:garibook/app/widgets/garibook_text_widgets.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  bool onPressedButton = true;

  dynamic authenticationProvider;
  String? appSignature;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authenticationProvider = ref.watch(signInSignUpController);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeStyles.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Lottie.asset("assets/images/lottie/otp.json",
                      repeat: true, height: 320.00),
                  const Center(
                    child: GaribookTextWidget(
                      text: "OTP VERIFICATION",
                      fontSize: 28.00,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GaribookTextWidget(
                    text:
                        'An OTP has been sent to +${authenticationProvider.mobileController.text}',
                    fontWeight: FontWeight.bold,
                    color: ThemeStyles.primaryColor,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const GaribookTextWidget(
                    text: 'Please Verify The OTP',
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PinFieldAutoFill(
                      decoration: BoxLooseDecoration(
                        textStyle:
                            const TextStyle(fontSize: 22, color: Colors.black),
                        strokeColorBuilder: FixedColorBuilder(
                            ThemeStyles.primaryColor.withOpacity(0.8)),
                      ),

                      enableInteractiveSelection: true,
                      currentCode: authenticationProvider.oTP,
                      onCodeChanged: (value) {
                        authenticationProvider.updateOtp(value: value);
                      },

                      // onSubmit: _listenSmsCode(),
                      cursor: Cursor(
                          color: ThemeStyles.primaryColor,
                          width: 2,
                          height: 20,
                          enabled: true),
                    ),
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onTap: () async {
                          authenticationProvider.verifyOTP(
                              context: context, deviceID: appSignature);
                        },
                        buttonColor: ThemeStyles.primaryColor,
                        borderColor: ThemeStyles.blackColor,
                        buttonText: "Verify",
                        textColor: ThemeStyles.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  Timerwidgets(
                    provider: authenticationProvider,
                  ),
                ]),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * .835,
                  left: 1,
                  right: 1,
                  child: Image.asset("assets/images/home/logo2.png"))
            ]),
          ),
        ),
      ),
    );
  }
}

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 00;
  final time = '00.00'.obs;

  @override
  void onReady() {
    _startTimer(150);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
  }
}

class Timerwidgets extends GetView<TimerController> {
  const Timerwidgets({this.provider, Key? key}) : super(key: key);
  final provider;
  @override
  Widget build(BuildContext context) {
    Get.put(TimerController());
    return Center(
      child: Obx(() => Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GaribookTextWidget(
                        text: "Resend OTP ",
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: GaribookTextWidget(
                      text: controller.time.value,
                      fontSize: 20,
                      color: ThemeStyles.redColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  controller.remainingSeconds == 00
                      ? Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: CustomButton(
                              onTap: () {
                                provider.resendOtp(context: context);
                                controller._startTimer(150);
                              },
                              buttonColor: ThemeStyles.primaryColor,
                              textColor: ThemeStyles.primaryTextColor,
                              buttonText: "Resend"),
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }
}
