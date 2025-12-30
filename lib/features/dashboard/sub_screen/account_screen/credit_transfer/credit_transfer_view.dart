import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/credit_transfer/credit_transfer_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

class CreditTransferView extends StatelessWidget {
  const CreditTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => CreditTransferController(),
          child: Consumer<CreditTransferController>(
            builder: (context, controller, child) {
              return appBackgroundContainer(
                isScroll: true,
                isAppDismissKeyboard: true,
                children: [
                  appBody(
                    body: [
                      SizedBox(height: ch(20)),
                      _buildHeader(context),
                      SizedBox(height: ch(40)),
                      // Card Number
                      _buildLabel("Card Number"),
                      SizedBox(height: ch(8)),
                      _buildTextField(
                        controller: controller.cardNumberController,
                        hint: "4725 2136 7453 3254",
                        inputType: TextInputType.number,
                      ),
                      SizedBox(height: ch(20)),

                      // Expiration & CVC
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Expiration"),
                                SizedBox(height: ch(8)),
                                _buildTextField(
                                  controller: controller.expirationController,
                                  hint: "**/**",
                                  isObscure: !controller.isExpirationVisible,
                                  suffixIcon: InkWell(
                                    onTap: () =>
                                        controller.isExpirationVisible =
                                            !controller.isExpirationVisible,
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.cFFFFFF,
                                      size: cw(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: cw(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("CVC"),
                                SizedBox(height: ch(8)),
                                _buildTextField(
                                  controller: controller.cvcController,
                                  hint: "***",
                                  isObscure: !controller.isCvcVisible,
                                  suffixIcon: InkWell(
                                    onTap: () => controller.isCvcVisible =
                                        !controller.isCvcVisible,
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.cFFFFFF,
                                      size: cw(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ch(20)),

                      // Account Holder Name
                      _buildLabel("Account Holder Name"),
                      SizedBox(height: ch(8)),
                      _buildTextField(
                        controller: controller.holderNameController,
                        hint: "Zakib Al Hareeray",
                      ),

                      SizedBox(height: ch(62)), // Spacer

                      AppButton(
                        showIcon: true,
                        icon: SvgPicture.asset(AssetUtils.creditCard),
                        isBorder: false,
                        text: "Deposit \$100 Now",
                        isButtonEnable: true,
                        onPressed: () {
                          // Handle success/next step
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: ch(16)),

                      Container(
                        width: double.infinity,
                        height: ch(48),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cw(25)),
                          border: Border.all(color: AppColor.c787B7F, width: 1),
                          color: AppColor.transparent,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(cw(25)),
                          child: Center(
                            child: AppText(
                              txt: "Cancel",
                              fontSize: AppFontSize.f16,
                              color: AppColor.c787B7F,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ch(20)),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: AppColor.cFFFFFF),
        ),
        SizedBox(width: cw(16)),
        AppText(
          txt: "Card Payment",
          fontSize: AppFontSize.f18,
          color: AppColor.cFFFFFF,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return AppText(
      txt: text,
      fontSize: AppFontSize.f14,
      color: AppColor.cFFFFFF,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType inputType = TextInputType.text,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return primaryTextField(
      fillColor: AppColor.c121717,
      textFieldHeight: ch(46),
      controller: controller,
      hintText: hint,
      obscureText: isObscure,
      keyboardType: inputType,
      suffixIcon: suffixIcon,
    );
  }
}
