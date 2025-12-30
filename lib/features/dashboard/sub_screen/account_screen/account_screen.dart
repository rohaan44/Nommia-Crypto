import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/account_screen_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/bank_transfer/bank_transfer_view.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/credit_transfer/credit_transfer_view.dart';

import 'package:nommia_crypto/ui_molecules/bottom_sheets/create_account_v2_bottomsheet.dart';
import 'package:nommia_crypto/ui_molecules/bottom_sheets/main_bottomsheet.dart';
import 'package:nommia_crypto/ui_molecules/custom_dropdown/custom_dropdown.dart';
import 'package:nommia_crypto/ui_molecules/dotted_divider/dotted_divider.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/ui_molecules/show_dialogue/show_dialoge.dart';
import 'package:nommia_crypto/utils/asset_utils.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:nommia_crypto/utils/theme/app_gradient.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountScreenController>(
      builder: (context, model, child) {
        return appBackgroundContainer(
          isScroll: true,
          isAppDismissKeyboard: true,
          children: [_buildBody(context: context, model: model)],
        );
      },
    );
  }
}

Widget _buildBody({
  required BuildContext context,

  required AccountScreenController model,
}) {
  return appBody(
    body: [
      Row(
        children: [
          Expanded(
            child: DropdownBottomSheet(
              title: "Account 1",
              selectedValue: model.selectedAccount,
              items: model.accountList,
              onSelect: (value) {
                model.selectedAccount = value;
              },
            ),
          ),
          SizedBox(width: cw(23)),

          InkWell(
            onTap: () {
              mainBottomsheet(
                context: context,
                modalContent: createAccountBottomesheetV2(
                  isDivider: true,
                  context: context,
                  heading: "Create Account",
                  title1: "Name",
                  title2: "Currency",
                  hint1: "Account Name",
                  hint2: "Select Currency",
                  title3: "Account Type",
                  hint3: "Select Account Type",
                  primarybtnHandler: () {
                    Navigator.pop(context);
                  },

                  secondarybtnHandler: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
            child: Container(
              height: ch(40),
              width: cw(40),
              decoration: BoxDecoration(
                color: AppColor.c0C1010,

                borderRadius: BorderRadius.circular(cw(8)),
              ),
              child: Center(child: Icon(Icons.add, color: AppColor.c787B7F)),
            ),
          ),
        ],
      ),

      SizedBox(height: ch(30)),
      Center(
        child: AppText(
          txt: "Total Balance",
          fontSize: AppFontSize.f14,
          color: AppColor.cFFFFFF.withOpacity(0.4),
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: ch(7)),
      Center(
        child: AppText(
          txt: "\$12,500.00",
          fontSize: AppFontSize.f32,

          color: AppColor.cFFFFFF,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: ch(50)),

      ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          final key = model.dataList[index]["key"];
          final value = model.dataList[index]["value"];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                txt: key ?? "",
                fontSize: AppFontSize.f14,

                color: AppColor.c787B7F,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),

              AppText(
                txt: value ?? "",
                fontSize: AppFontSize.f14,

                color: AppColor.cFFFFFF,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(thickness: ch(1), color: Color(0xff1F242A));
        },
        itemCount: model.dataList.length,
      ),
      SizedBox(height: ch(48)),
      _buildBottomBody(context: context, model: model),
      SizedBox(height: ch(250)),
    ],
  );
}

Widget _buildBottomBody({
  required BuildContext context,
  required AccountScreenController model,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final titles = model.btnList[index]["title"];
          // final img = model.btnList[index]["img"];

          return primaryButton(
            width: cw(100),
            context: context,
            // icon: SvgPicture.asset(img ?? ""),
            icon: SvgPicture.asset(
              index == 0
                  ? AssetUtils.arrowDeposit
                  : index == 1
                  ? AssetUtils.arrowWithdra
                  : AssetUtils.arrowTransfer,
              color: model.selectIndex == index
                  ? AppColor.c000000
                  : AppColor.white,
            ),
            // icon: Icon(
            //   index == 0
            //       ? Icons.arrow_upward
            //       : index == 1
            //       ? Icons.arrow_downward
            //       : Icons.compare_arrows,
            //   color: model.selectIndex == index
            //       ? AppColor.c000000
            //       : AppColor.white,
            // ),
            title: titles ?? "",
            titleColor: model.selectIndex == index
                ? AppColor.c000000
                : AppColor.white,
            isAppGradient: model.selectIndex == index,
            onTap: () {
              model.selectIndex = index; // 👈 assignment

              model.selectedLabel = titles;

              // print("$titles tapped");
              // print("${model.selectedLabel} asas");
            },
          );
        }),
      ),

      SizedBox(height: ch(22)),
      Divider(color: AppColor.fieldBg),

      SizedBox(height: ch(22)),

      if (model.selectedLabel == "Deposit" ||
          model.selectedLabel == "Withdraw") ...[
        AppButton(
          height: ch(42),
          buttonColor: AppColor.c0C1010,
          padding: EdgeInsets.zero,
          isButtonEnable: false,
          borderColor: AppColor.transparent,

          onPressed: () {},

          child: Row(
            children: [
              Expanded(
                child: primaryButton(
                  context: context,
                  title: "Crypto",

                  isBorderColor: false,
                  fontsize: AppFontSize.f16,
                  titleColor: model.isCrypto == true
                      ? AppColor.cFFFFFF
                      : AppColor.c787B7F,
                  boxColor: model.isCrypto == true
                      ? AppColor.c575B60
                      : AppColor.c0C1010,
                  onTap: () {
                    model.isCrypto = true;
                    model.isFiat = false;
                  },
                  width: cw(178),
                ),
              ),
              SizedBox(width: cw(20)),
              Expanded(
                child: primaryButton(
                  context: context,
                  title: "Fiat",
                  fontsize: AppFontSize.f16,
                  titleColor: model.isFiat == true
                      ? AppColor.cFFFFFF
                      : AppColor.c787B7F,
                  isBorderColor: false,
                  boxColor: model.isFiat == true
                      ? AppColor.c575B60
                      : AppColor.c0C1010,
                  onTap: () {
                    model.isCrypto = false;
                    model.isFiat = true;
                  },
                  width: cw(178),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ch(27)),
      ],

      if (model.selectedLabel == "Deposit") ...[
        if (model.isFiat == true) ...[
          // Fiat Methods
          AppText(
            txt: "Fiat Deposit Methods",
            fontSize: AppFontSize.f14,

            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),

          SizedBox(height: ch(16)),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreditTransferView(),
                ),
              );
            },
            child: Container(
              height: ch(60),
              decoration: BoxDecoration(
                color: AppColor.c0C1010, // Dark background
                borderRadius: BorderRadius.circular(cw(18)),
                border: Border.all(color: AppColor.fieldBg),
              ),
              padding: EdgeInsets.symmetric(horizontal: cw(24)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AssetUtils.cardIcon,
                    color: AppColor.cFFFFFF,
                  ),
                  SizedBox(width: cw(15)),
                  AppText(
                    txt: "Credit/Debit Card",
                    fontSize: AppFontSize.f14,
                    color: AppColor.cFFFFFF,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ch(12)),
          InkWell(
            onTap: () {
              _showDepositFundsBottomSheet(context: context, controller: model);
            },
            child: Container(
              height: ch(60),
              decoration: BoxDecoration(
                color: AppColor.c0C1010,
                borderRadius: BorderRadius.circular(cw(18)),
                border: Border.all(color: AppColor.fieldBg),
              ),
              padding: EdgeInsets.symmetric(horizontal: cw(24)),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_rounded,
                    color: AppColor.cFFFFFF,
                    size: 24,
                  ),
                  SizedBox(width: cw(15)),
                  AppText(
                    txt: "Bank Transfer",
                    fontSize: AppFontSize.f14,
                    color: AppColor.cFFFFFF,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // Crypto Methods
          // DropdownBottomSheet(
          //   title: "Select Wallet",
          //   selectedValue: model.selectedWallet,
          //   items: model.accountList,
          //   onSelect: (value) {
          //     model.selectedWallet = value;
          //   },
          // ),
          AppText(
            txt: "Select Crypto",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          DropdownBottomSheet(
            title: "Select Crypto",
            selectedValue: model.selectedCrypto,
            items: model.cryptoList,
            onSelect: (value) {
              model.selectedCrypto = value;
            },
          ),

          SizedBox(height: ch(16)),
          // if (model.selectedLabel == "Transfer") ...[
          //   DropdownBottomSheet(
          //     title: "Select Currency",
          //     selectedValue: model.selectedNetwork,
          //     items: model.accountList,
          //     onSelect: (value) {
          //       model.selectedNetwork = value;
          //     },
          //   ),
          // ] else
          // DropdownBottomSheet(
          //   title: "Select Network",
          //   selectedValue: model.selectedNetwork,
          //   items: model.accountList,
          //   onSelect: (value) {
          //     model.selectedNetwork = value;
          //   },
          // ),
          // SizedBox(height: ch(16)),

          // if (model.selectedLabel == "Deposit") ...[
          // DropdownBottomSheet(
          //   title: "Select Currency",
          //   selectedValue: model.selectedCurrency,
          //   items: model.accountList,
          //   onSelect: (value) {
          //     model.selectedCurrency = value;
          //   },
          // ),
          // SizedBox(height: ch(16)),
          //  ],
          AppText(
            txt: "Amount (USD)",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          primaryTextField(
            keyboardType: TextInputType.number,
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "\$",
            borderColor: AppColor.transparent,
            border: InputBorder.none,
          ),
          SizedBox(height: ch(16)),

          AppText(
            txt: "Wallet Address",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          TextFormField(
            controller: model.walletController,
            cursorColor: AppColor.red,
            maxLines: 4,
            style: TextStyle(
              color: AppColor.cFFFFFF, // input text color
              fontSize: AppFontSize.f14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(14)),
                borderSide: BorderSide(color: AppColor.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(14)),
                borderSide: BorderSide(color: AppColor.transparent),
              ),
              fillColor: AppColor.c0C1010,
              hintText: "Wallet Address",
              hintStyle: TextStyle(
                color: AppColor.cFFFFFF.withOpacity(0.5),
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),

          SizedBox(height: ch(16)),
          AppButton(
            onPressed: () {
              showDepositDialog(
                isDeposit: true,
                fontSize: AppFontSize.f18,
                context,
                image: AssetUtils.qrCode,
                title:
                    "Your ${model.selectedLabel!.toLowerCase()} request is being processed",
                fontWeight: FontWeight.w500,

                description: Padding(
                  padding: EdgeInsets.symmetric(horizontal: cw(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wallet Address
                      AppText(
                        txt: "Wallet Address",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF,
                      ),
                      SizedBox(height: ch(8)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppText(
                              txt: "TYfDPybMszAx4mSGfNUvAbNE4Y\nSM8NJ4HR",
                              fontSize: AppFontSize.f14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cFFFFFF.withOpacity(0.8),
                              height: 1.4,
                            ),
                          ),
                          Icon(Icons.copy, color: AppColor.cFFFFFF, size: 20),
                        ],
                      ),
                      SizedBox(height: ch(16)),

                      // Network
                      AppText(
                        txt: "Network",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF,
                      ),
                      SizedBox(height: ch(4)),
                      AppText(
                        txt: "USDT",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF.withOpacity(0.8),
                      ),
                      SizedBox(height: ch(16)),

                      // Amount
                      AppText(
                        txt: "Amount",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF,
                      ),
                      SizedBox(height: ch(4)),
                      AppText(
                        txt: "10 USDT",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF.withOpacity(0.8),
                      ),
                      SizedBox(height: ch(16)),

                      // Status
                      AppText(
                        txt: "Status",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.cFFFFFF,
                      ),
                      SizedBox(height: ch(4)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetUtils.pending,
                            height: ch(16),
                            width: cw(16),
                          ),
                          SizedBox(width: cw(8)),
                          AppText(
                            txt: "Pending",
                            fontSize: AppFontSize.f14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.cFF9214,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onDone: () {
                  showDepositDialog(
                    onDone: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    context,
                    title: "${model.selectedLabel} Successfull",
                    description: Column(
                      children: [
                        AppText(
                          txt:
                              "Your funds has been ${model.selectedLabel}\nto your Account 1",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                        SizedBox(height: ch(20)),
                        AppText(
                          txt:
                              "You can now use the funds for\ntransactions, payments, or other wallet\n operations. Check your wallet summary\nfor updated balance.",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            isButtonEnable: true,
            isBorder: false,
            text: model.selectedLabel == "Deposit"
                ? "Deposit"
                : model.selectedLabel == "Withdraw"
                ? "Withdraw"
                : "Transfer",
          ),
          SizedBox(height: ch(16)),

          antiMoneyText(context: context, model: model),

          SizedBox(height: ch(16)),

          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(6),
            dashSpace: cw(5),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          _buildRow(
            context: context,
            icon: AssetUtils.coinsIcon,
            title: model.selectedLabel == "Deposit"
                ? "Minimum Amount: \$3"
                : "Minimum Amount: \$3",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.clockIcon,
            title:
                "Processing time: Up to 2 hours\nThe processing time may be extended due to\nvarious reasons",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.infoIcon,
            title: "Additional info.",
          ),
        ],
      ],

      if (model.selectedLabel == "Withdraw") ...[
        if (model.isFiat == true) ...[
          AppText(
            txt: "Account Holder Name",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          primaryTextField(
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "Holder Name",
            border: InputBorder.none,
          ),
          // SizedBox(height: ch(16)),
          // primaryTextField(
          //   isBorderColor: false,
          //   textFieldHeight: ch(48),
          //   fillColor: AppColor.c0C1010,
          //   hintText: "Account Number",
          //   border: InputBorder.none,
          // ),
          SizedBox(height: ch(16)),
          AppText(txt: "Bank Name", color: AppColor.cFFFFFF.withOpacity(0.5)),
          SizedBox(height: ch(8)),
          primaryTextField(
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "Bank",
            border: InputBorder.none,
          ),
          SizedBox(height: ch(16)),
          AppText(
            txt: "Bank Country",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          DropdownBottomSheet(
            title: "Bank Country",
            items: model.countryList,
            onSelect: (v) {
              model.selectedCountry = v;
            },
            selectedValue: model.selectedCountry,
          ),

          SizedBox(height: ch(16)),
          AppText(
            txt: "Account IBAN Number",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          primaryTextField(
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "0000",
            border: InputBorder.none,
          ),
          SizedBox(height: ch(16)),
          AppText(txt: "BIC", color: AppColor.cFFFFFF.withOpacity(0.5)),
          SizedBox(height: ch(8)),
          primaryTextField(
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "0000",
            border: InputBorder.none,
          ),
          SizedBox(height: ch(70)),
          AppButton(
            borderColor: AppColor.transparent,
            onPressed: () {
              model.selectedLabel = "Withdraw";
              log(model.selectedLabel!);
              showDepositDialog(
                fontSize: AppFontSize.f18,
                context,
                image: AssetUtils.rocketIcon,
                title:
                    "Your ${model.selectedLabel!.toLowerCase()} request is being processed",
                fontWeight: FontWeight.w500,

                description: AppText(
                  txt:
                      "Our team is verifying your transfer.\nYou will be notified once the funds are\nadded to your Nommia wallet.",
                  textAlign: TextAlign.center,
                  fontSize: AppFontSize.f13,
                  height: 1.4,
                  color: AppColor.c787B7F,
                ),

                onDone: () {
                  showDepositDialog(
                    onDone: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    context,
                    title: "${model.selectedLabel} Successfull",
                    description: Column(
                      children: [
                        AppText(
                          txt:
                              "Your funds has been ${model.selectedLabel}\nto your Account 1",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                        SizedBox(height: ch(20)),
                        AppText(
                          txt:
                              "You can now use the funds for\ntransactions, payments, or other wallet\n operations. Check your wallet summary\nfor updated balance.",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            text: "Withdraw",
          ),
          SizedBox(height: ch(16)),

          antiMoneyText(context: context, model: model),

          SizedBox(height: ch(16)),

          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(6),
            dashSpace: cw(5),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          _buildRow(
            context: context,
            icon: AssetUtils.coinsIcon,
            title: model.selectedLabel == "Deposit"
                ? "Minimum Amount: \$3"
                : "Minimum Amount: \$3",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.clockIcon,
            title:
                "Processing time: Up to 2 hours\nThe processing time may be extended due to\nvarious reasons",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.infoIcon,
            title: "Additional info.",
          ),
        ] else ...[
          // Crypto Methods
          AppText(
            txt: "Select Crypto",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          DropdownBottomSheet(
            title: "Select Crypto",
            selectedValue: model.selectedCrypto,
            items: model.cryptoList,
            onSelect: (value) {
              model.selectedCrypto = value;
            },
          ),

          // SizedBox(height: ch(16)),

          // DropdownBottomSheet(
          //   title: "Select Currency",
          //   selectedValue: model.selectedWithdrawCurrency,
          //   items: model.accountList,
          //   onSelect: (value) {
          //     model.selectedWithdrawCurrency = value;
          //   },
          // ),
          SizedBox(height: ch(16)),
          // DropdownBottomSheet(
          //   title: "Select Network",
          //   selectedValue: model.selectedNetwork,
          //   items: model.accountList,
          //   onSelect: (value) {
          //     model.selectedNetwork = value;
          //   },
          // ),
          AppText(
            txt: "Amount (USD)",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          primaryTextField(
            isBorderColor: false,
            textFieldHeight: ch(48),
            fillColor: AppColor.c0C1010,
            hintText: "\$",
            borderColor: AppColor.transparent,
            border: InputBorder.none,
          ),

          SizedBox(height: ch(16)),
          AppText(
            txt: "Wallet Address",
            color: AppColor.cFFFFFF.withOpacity(0.5),
          ),
          SizedBox(height: ch(8)),
          TextFormField(
            controller: model.walletController,
            cursorColor: AppColor.red,
            maxLines: 4,
            style: TextStyle(
              color: AppColor.cFFFFFF, // input text color
              fontSize: AppFontSize.f14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(14)),
                borderSide: BorderSide(color: AppColor.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cw(14)),
                borderSide: BorderSide(color: AppColor.transparent),
              ),
              fillColor: AppColor.c0C1010,
              hintText: "Wallet Address",
              hintStyle: TextStyle(
                color: AppColor.cFFFFFF.withOpacity(0.5),
                fontSize: AppFontSize.f14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),

          SizedBox(height: ch(16)),

          AppButton(
            onPressed: () {
              showDepositDialog(
                fontSize: AppFontSize.f18,
                context,
                image: AssetUtils.rocketIcon,
                title:
                    "Your ${model.selectedLabel!.toLowerCase()} request is being processed",
                fontWeight: FontWeight.w500,

                description: AppText(
                  txt:
                      "Our team is verifying your transfer.\nYou will be notified once the funds are\nadded to your Nommia wallet.",
                  textAlign: TextAlign.center,
                  fontSize: AppFontSize.f13,
                  height: 1.4,
                  color: AppColor.c787B7F,
                ),

                onDone: () {
                  showDepositDialog(
                    onDone: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    context,
                    title: "${model.selectedLabel} Successfull",
                    description: Column(
                      children: [
                        AppText(
                          txt:
                              "Your funds has been ${model.selectedLabel}\nto your Account 1",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                        SizedBox(height: ch(20)),
                        AppText(
                          txt:
                              "You can now use the funds for\ntransactions, payments, or other wallet\n operations. Check your wallet summary\nfor updated balance.",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.f14,
                          height: 1.4,
                          color: AppColor.c787B7F,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            isButtonEnable: true,
            isBorder: false,
            text: model.selectedLabel == "Deposit"
                ? "Deposit"
                : model.selectedLabel == "Withdraw"
                ? "Withdraw"
                : "Transfer",
          ),
          SizedBox(height: ch(16)),

          antiMoneyText(context: context, model: model),

          SizedBox(height: ch(16)),

          DottedDivider(
            color: AppColor.fieldBg,
            dashWidth: cw(6),
            dashSpace: cw(5),
            thickness: 1,
          ),
          SizedBox(height: ch(16)),

          _buildRow(
            context: context,
            icon: AssetUtils.coinsIcon,
            title: model.selectedLabel == "Deposit"
                ? "Minimum Amount: \$3"
                : "Minimum Amount: \$3",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.clockIcon,
            title:
                "Processing time: Up to 2 hours\nThe processing time may be extended due to\nvarious reasons",
          ),
          _buildRow(
            context: context,
            icon: AssetUtils.infoIcon,
            title: "Additional info.",
          ),
        ],
      ],

      if (model.selectedLabel == "Transfer") ...[
        // DropdownBottomSheet(
        //   title: "Select Wallet",
        //   selectedValue: model.selectedWallet,
        //   items: model.accountList,
        //   onSelect: (value) {
        //     model.selectedWallet = value;
        //   },
        // ),
        AppText(
          txt: "Select Account",
          color: AppColor.cFFFFFF.withOpacity(0.5),
        ),
        SizedBox(height: ch(8)),

        // SizedBox(height: ch(16)),
        DropdownBottomSheet(
          title: "Select Account",
          selectedValue: model.selectedAccount,
          items: model.accountList,
          onSelect: (value) {
            model.selectedAccount = value;
          },
        ),
        // SizedBox(height: ch(16)),
        // DropdownBottomSheet(
        //   title: "Select Currency",
        //   selectedValue: model.selectedNetwork,
        //   items: model.accountList,
        //   onSelect: (value) {
        //     model.selectedNetwork = value;
        //   },
        // ),
        SizedBox(height: ch(16)),
        AppText(txt: "Amount (USD)", color: AppColor.cFFFFFF.withOpacity(0.5)),
        SizedBox(height: ch(8)),
        primaryTextField(
          isBorderColor: false,
          textFieldHeight: ch(48),
          fillColor: AppColor.c0C1010,
          hintText: "\$",
          borderColor: AppColor.transparent,
          border: InputBorder.none,
        ),
        SizedBox(height: ch(20)),
        AppButton(
          borderColor: AppColor.transparent,
          onPressed: () {
            showDepositDialog(
              fontSize: AppFontSize.f18,
              context,
              image: AssetUtils.rocketIcon,
              title:
                  "Your ${model.selectedLabel!.toLowerCase()} request is being processed",
              fontWeight: FontWeight.w500,

              description: AppText(
                txt:
                    "Our team is verifying your transfer.\nYou will be notified once the funds are\nadded to your Nommia wallet.",
                textAlign: TextAlign.center,
                fontSize: AppFontSize.f13,
                height: 1.4,
                color: AppColor.c787B7F,
              ),

              onDone: () {
                showDepositDialog(
                  onDone: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  context,
                  title: "${model.selectedLabel} Successfull",
                  description: Column(
                    children: [
                      AppText(
                        txt:
                            "Your funds has been ${model.selectedLabel}\nto your Account 1",
                        textAlign: TextAlign.center,
                        fontSize: AppFontSize.f14,
                        height: 1.4,
                        color: AppColor.c787B7F,
                      ),
                      SizedBox(height: ch(20)),
                      AppText(
                        txt:
                            "You can now use the funds for\ntransactions, payments, or other wallet\n operations. Check your wallet summary\nfor updated balance.",
                        textAlign: TextAlign.center,
                        fontSize: AppFontSize.f14,
                        height: 1.4,
                        color: AppColor.c787B7F,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          text: "Transfer",
        ),
        SizedBox(height: ch(16)),

        antiMoneyText(context: context, model: model),

        SizedBox(height: ch(16)),

        DottedDivider(
          color: AppColor.fieldBg,
          dashWidth: cw(6),
          dashSpace: cw(5),
          thickness: 1,
        ),
        SizedBox(height: ch(16)),

        _buildRow(
          context: context,
          icon: AssetUtils.coinsIcon,
          title: model.selectedLabel == "Deposit"
              ? "Minimum Amount: \$3"
              : "Minimum Amount: \$3",
        ),
        _buildRow(
          context: context,
          icon: AssetUtils.clockIcon,
          title:
              "Processing time: Up to 2 hours\nThe processing time may be extended due to\nvarious reasons",
        ),
        _buildRow(
          context: context,
          icon: AssetUtils.infoIcon,
          title: "Additional info.",
        ),
      ],
    ],
  );
}

Widget primaryButton({
  required BuildContext context,
  double? height,
  double? width,
  required String title,
  Color? titleColor,
  double? fontsize,
  FontWeight? titleFontWeight,
  required VoidCallback onTap,
  Widget? icon,
  double? borderRadius,
  Color? boxColor,
  bool isBorderColor = true,
  bool isAppGradient = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? ch(44),
      width: width,
      padding: EdgeInsets.symmetric(horizontal: cw(12)),
      decoration: BoxDecoration(
        color: boxColor ?? AppColor.fieldBg,
        gradient: isAppGradient ? AppGradients.goldenBtn : null,
        border: isBorderColor ? Border.all(color: AppColor.c787B7F) : null,
        borderRadius: BorderRadius.circular(borderRadius ?? cw(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon],
          SizedBox(width: cw(8)),
          AppText(
            txt: title,
            fontSize: fontsize ?? AppFontSize.f12,

            color: titleColor ?? AppColor.cFFFFFF,
            fontWeight: titleFontWeight ?? FontWeight.w500,
          ),
        ],
      ),
    ),
  );
}

Widget antiMoneyText({required BuildContext context, required model}) {
  return RichText(
    text: TextSpan(
      text:
          "By Clicking the ${model.selectedLabel} button, I agree to the Terms of the ",
      style: TextStyle(
        color: AppColor.c838585,

        fontWeight: FontWeight.w500,
        fontSize: AppFontSize.f14,
      ),

      children: [
        TextSpan(
          text: "Customer Agreement ",

          style: TextStyle(
            color: AppColor.cFFFFFF,

            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
        TextSpan(
          text: "and the ",

          style: TextStyle(
            color: AppColor.c838585,

            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
        TextSpan(
          text: "Anti-Money Laundering Policy ",

          style: TextStyle(
            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
        TextSpan(
          text: "and confirm that the ",

          style: TextStyle(
            color: AppColor.c838585,

            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
        TextSpan(
          text: "payment will not be made from a third-party account.",

          style: TextStyle(
            color: AppColor.cFFFFFF,

            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.f14,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRow({
  required BuildContext context,
  required String icon,
  required String title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          if (icon.isNotEmpty) ...[SvgPicture.asset(icon)],
          SizedBox(width: cw(10)),
          Expanded(
            child: AppText(
              txt: title,
              fontSize: AppFontSize.f14,

              color: AppColor.cFFFFFF,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),

      SizedBox(height: ch(16)),

      DottedDivider(
        color: AppColor.fieldBg,
        dashWidth: cw(6),
        dashSpace: cw(5),
        thickness: 1,
      ),
      SizedBox(height: ch(16)),
    ],
  );
}

void _showDepositFundsBottomSheet({
  required BuildContext context,
  String title = "Deposit Funds",
  required AccountScreenController controller,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xff1E2026),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Consumer<AccountScreenController>(
        builder: (context, controller, child) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ch(20)),
                AppText(
                  txt: title,
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 24),
                _buildLabel("Currency"),
                const SizedBox(height: 8),
                DropdownBottomSheet(
                  title: "Select Currency",
                  selectedValue: controller.selectedCurrency,
                  items: controller.currencyList,
                  onSelect: (value) {
                    controller.selectedCurrency = value;
                  },
                ),
                const SizedBox(height: 16),
                _buildLabel("Amount (USD)"),
                const SizedBox(height: 8),
                _buildReadOnlyField(
                  controller.selectedCurrency == "€ (EUR)"
                      ? "€"
                      : controller.selectedCurrency == "£ (GBP)"
                      ? "£"
                      : "\$",
                ),
                SizedBox(height: ch(32)),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColor.textGrey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: AppText(
                          txt: "Cancel",
                          color: AppColor.textGrey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        height: ch(40),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BankTransferView(),
                            ),
                          );
                        },
                        text: "OK",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildLabel(String text) {
  return AppText(
    txt: text,
    color: AppColor.textGrey,
    fontSize: AppFontSize.f13,
  );
}

Widget _buildReadOnlyField(String text) {
  return primaryTextField(
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    textFieldHeight: ch(46),
    fillColor: AppColor.c0C1010,
    hintText: text,
  );
}
