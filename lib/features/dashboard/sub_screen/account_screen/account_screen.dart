import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nommia_crypto/features/dashboard/sub_screen/account_screen/account_screen_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/bottom_sheets/create_account_bottomsheet.dart';
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
              selectedValue: model.selectedCountry,
              items: model.accountList,
              onSelect: (value) {
                model.selectedCountry = value;
              },
            ),
          ),
          SizedBox(width: cw(23)),

          InkWell(
            onTap: () {
              mainBottomsheet(
                context: context,
                modalContent: createAccountBottomesheet(
                  context: context,
                  heading: "Create New Account",
                  title1: "Name",
                  hint1: "Account Name",
                  title2: "Currency",
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

      if (model.selectedLabel == "Deposit" ||
          model.selectedLabel == "Withdraw" ||
          model.selectedLabel == "Transfer") ...[
        if (model.isFiat == true) ...[
          // Fiat Methods
          AppText(
            txt: "Fiat ${model.selectedLabel ?? "Deposit"} Methods",
            fontSize: AppFontSize.f14,

            color: AppColor.cFFFFFF,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),

          SizedBox(height: ch(16)),

          InkWell(
            onTap: () {
              // Handle Card selection
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
              // Handle Bank selection
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
          DropdownBottomSheet(
            title: "Select Wallet",
            selectedValue: model.selectedWallet,
            items: model.accountList,
            onSelect: (value) {
              model.selectedWallet = value;
            },
          ),

          SizedBox(height: ch(16)),
          DropdownBottomSheet(
            title: "Select Network",
            selectedValue: model.selectedNetwork,
            items: model.accountList,
            onSelect: (value) {
              model.selectedNetwork = value;
            },
          ),

          SizedBox(height: ch(16)),

          primaryTextField(
            textFieldHeight: ch(100),
            hintText: "hintText",
            border: InputBorder.none,
          ),
          SizedBox(height: ch(16)),

          primaryTextField(hintText: "Amount", border: InputBorder.none),
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
