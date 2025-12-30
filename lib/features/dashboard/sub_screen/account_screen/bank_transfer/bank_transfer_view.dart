import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/bank_transfer/bank_transfer_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/dotted_divider/dotted_divider.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

class BankTransferView extends StatelessWidget {
  const BankTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => BankTransferController(),
          child: Consumer<BankTransferController>(
            builder: (context, controller, child) {
              return appBackgroundContainer(
                isScroll: true,
                isAppDismissKeyboard: true,
                children: [
                  appBody(
                    body: [
                      SizedBox(height: ch(20)),
                      _buildHeader(context),
                      SizedBox(height: ch(50)),
                      AppText(
                        txt:
                            "Use the bank details below to complete your transfer.",
                        fontSize: AppFontSize.f14,
                        color: AppColor.cFFFFFF,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: ch(32)),
                      AppText(
                        txt: "Bank Details",
                        fontSize: AppFontSize.f16,
                        color: AppColor.cFFFFFF,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: ch(25)),
                      _buildBankDetailsCard(controller),
                      SizedBox(height: ch(16)),
                      Center(
                        child: AppText(
                          txt:
                              "You must enter this in their bank transfer notes",
                          fontSize: AppFontSize.f12,
                          color: AppColor.cFFFFFF,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ch(50)),
                      AppButton(
                        isBorder: false,
                        text: "I Have Transferred",
                        isButtonEnable: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
          txt: "Transfer Funds to Nommia",
          fontSize: AppFontSize.f16 - 1.5,
          color: AppColor.cFFFFFF,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildBankDetailsCard(BankTransferController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: cw(16), vertical: ch(24)),
      decoration: BoxDecoration(
        color: AppColor.c0C1010,
        borderRadius: BorderRadius.circular(cw(16)),
        border: Border.all(color: AppColor.fieldBg.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Bank Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: "Bank Name:",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              Expanded(
                child: TextField(
                  controller: controller.bankNameController,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColor.cFFFFFF,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: AppColor.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "XYZ Bank",
                    hintStyle: TextStyle(
                      color: AppColor.cFFFFFF.withOpacity(0.5),
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ch(16)),
          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(4),
            dashSpace: cw(4),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          // Account Holder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: "Account holder:",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              AppText(
                txt: "Nommia Financial Services",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(height: ch(16)),
          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(4),
            dashSpace: cw(4),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          // IBAN
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: "IBAN:",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(width: cw(20)),
              Expanded(
                child: TextField(
                  controller: controller.ibanController,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColor.cFFFFFF,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: AppColor.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "XXXX-XXXX-XXXX",
                    hintStyle: TextStyle(
                      color: AppColor.cFFFFFF.withOpacity(0.5),
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ch(16)),
          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(4),
            dashSpace: cw(4),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          // SWIFT CODE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: "SWIFT CODE:",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              SizedBox(width: cw(20)),
              Expanded(
                child: TextField(
                  controller: controller.swiftController,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColor.cFFFFFF,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: AppColor.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "XXXXXX",
                    hintStyle: TextStyle(
                      color: AppColor.cFFFFFF.withOpacity(0.5),
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ch(16)),
          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(4),
            dashSpace: cw(4),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          // Reference Code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: "Reference Code:",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
              AppText(
                txt: "NOM-USD-8756XQ629",
                fontSize: AppFontSize.f14,
                color: AppColor.cFFFFFF,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
