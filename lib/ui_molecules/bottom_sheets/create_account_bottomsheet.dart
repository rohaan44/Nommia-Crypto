import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:sizer/sizer.dart';

Widget createAccountBottomesheet({
  required BuildContext context,
  double? sheetHeight,
  required String heading,
  required String title1,
  required String title2,
  String title3 = "",
  required String hint1,
  required String hint2,
  String? hint3,
  String description = "",
  String? primarybtnText,
  VoidCallback? primarybtnHandler,
  String? secondarybtnText,
  VoidCallback? secondarybtnHandler,
  bool isDivider = true,
  bool isDropDown = false,
}) {
  return CreateAccountBottomSheet(
    sheetHeight: sheetHeight,
    heading: heading,
    title1: title1,
    title2: title2,
    title3: title3,
    hint1: hint1,
    hint2: hint2,
    hint3: hint3,
    description: description,
    primarybtnText: primarybtnText,
    primarybtnHandler: primarybtnHandler,
    secondarybtnText: secondarybtnText,
    secondarybtnHandler: secondarybtnHandler,
    isDivider: isDivider,
    isDropDown: isDropDown,
  );
}

class CreateAccountBottomSheet extends StatefulWidget {
  final double? sheetHeight;
  final String heading;
  final String title1;
  final String title2;
  final String title3;
  final String hint1;
  final String hint2;
  final String? hint3;
  final String description;
  final String? primarybtnText;
  final VoidCallback? primarybtnHandler;
  final String? secondarybtnText;
  final VoidCallback? secondarybtnHandler;
  final bool isDivider;
  final bool isDropDown;

  const CreateAccountBottomSheet({
    super.key,
    this.sheetHeight,
    required this.heading,
    required this.title1,
    required this.title2,
    this.title3 = "",
    required this.hint1,
    required this.hint2,
    this.hint3,
    this.description = "",
    this.primarybtnText,
    this.primarybtnHandler,
    this.secondarybtnText,
    this.secondarybtnHandler,
    this.isDivider = true,
    this.isDropDown = false,
  });

  @override
  State<CreateAccountBottomSheet> createState() =>
      _CreateAccountBottomSheetState();
}

class _CreateAccountBottomSheetState extends State<CreateAccountBottomSheet>
    with AutomaticKeepAliveClientMixin {
  String selectedValue = "Equity";
  String selectedPercent = "Select Allocation";
  String selectedMultiplier = "Select Allocation";

  // Controllers to persist input text
  late final TextEditingController _amountController;
  late final TextEditingController _multiplierAmountController;
  late final TextEditingController _otherController;
  late final TextEditingController
  _input1Controller; // For title1 input if not dropdown

  late final TextEditingController _equityController; // For Equity input

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _multiplierAmountController = TextEditingController();
    _otherController = TextEditingController();
    _input1Controller = TextEditingController();
    _equityController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _multiplierAmountController.dispose();
    _otherController.dispose();
    _input1Controller.dispose();
    _equityController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  static const List<String> percentOptions = [
    "10% of leader volume",
    "20% of leader volume",
    "30% of leader volume",
    "40% of leader volume",
    "50% of leader volume",
    "60% of leader volume",
    "70% of leader volume",
    "80% of leader volume",
    "90% of leader volume",
    "100% of leader volume",
    "130% of leader volume",
    "150% of leader volume",
    "200% of leader volume",
    "250% of leader volume",
    "300% of leader volume",
    "400% of leader volume",
    "500% of leader volume",
    "1000% of leader volume",
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Calculate height dynamically
    double calculatedHeight = selectedValue == 'Percent'
        ? ch(605)
        : widget.sheetHeight ?? ch(450);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ), // keyboard safe padding
      child: Container(
        height: calculatedHeight,
        width: 100.w,
        decoration: BoxDecoration(
          color: AppColor.fieldBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cw(20)),
            topRight: Radius.circular(cw(20)),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: ch(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ch(24)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: cw(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      txt: widget.heading,
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                      height: 1.3,
                      textAlign: TextAlign.center,
                    ),
                    if (widget.description.isNotEmpty) ...[
                      SizedBox(height: ch(5)),
                      AppText(
                        txt: widget.description,
                        fontSize: AppFontSize.f13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grey,
                        height: 1.3,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: ch(16)),
              if (widget.isDivider)
                Container(
                  height: ch(1),
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColor.c454F5C,
                    borderRadius: BorderRadius.circular(cw(50)),
                  ),
                ),
              SizedBox(height: ch(10)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: cw(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      txt: widget.title1,
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cFFFFFF,
                      height: 1.3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ch(10)),
                    if (widget.isDropDown) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cw(14)),
                          border: Border.all(color: AppColor.fieldBg),
                          color: AppColor.c0C1010,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedValue,
                              dropdownColor: AppColor.c0C1010,
                              icon: SizedBox.shrink(),
                              items: <String>['Equity', 'Percent', 'Lot Ratio']
                                  .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: AppText(
                                        txt: value,
                                        color: AppColor.white,
                                      ),
                                    );
                                  })
                                  .toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ] else
                      primaryTextField(
                        controller: _input1Controller,
                        hintText: widget.hint1,
                        border: InputBorder.none,
                        fillColor: AppColor.c0C1010,
                      ),
                    SizedBox(height: ch(18)),
                    AppText(
                      txt: selectedValue == 'Percent'
                          ? 'Percent'
                          : selectedValue == 'Lot Ratio'
                          ? 'Lot Ratio'
                          : widget.title2,
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cFFFFFF,
                      height: 1.3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ch(10)),

                    // Percent Section
                    if (selectedValue == 'Percent') ...[
                      GestureDetector(
                        onTap: () => _openPercentSelector(
                          context,
                          (value) => setState(() => selectedPercent = value),
                          percentOptions,
                        ),
                        child: Container(
                          height: ch(48),
                          padding: EdgeInsets.symmetric(horizontal: cw(14)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(cw(14)),
                            border: Border.all(color: AppColor.fieldBg),
                            color: AppColor.c0C1010,
                          ),
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            txt: selectedPercent,
                            color: AppColor.textGrey,
                          ),
                        ),
                      ),
                      SizedBox(height: ch(18)),
                      AppText(
                        txt: "Amount (USD)",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.cFFFFFF,
                        height: 1.3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ch(10)),
                      primaryTextField(
                        controller: _amountController,
                        hintText: "\$",
                        border: InputBorder.none,
                        fillColor: AppColor.c0C1010,
                      ),
                    ]
                    // Lot Ratio Section
                    else if (selectedValue == 'Lot Ratio') ...[
                      GestureDetector(
                        onTap: () => _openPercentSelector(
                          context,
                          (value) => setState(() => selectedMultiplier = value),
                          percentOptions,
                        ),
                        child: Container(
                          height: ch(48),
                          padding: EdgeInsets.symmetric(horizontal: cw(14)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(cw(14)),
                            border: Border.all(color: AppColor.fieldBg),
                            color: AppColor.c0C1010,
                          ),
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            txt: selectedMultiplier,
                            color: AppColor.textGrey,
                          ),
                        ),
                      ),
                      SizedBox(height: ch(18)),
                      AppText(
                        txt: "Amount (USD)",
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.cFFFFFF,
                        height: 1.3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ch(10)),
                      primaryTextField(
                        controller: _multiplierAmountController,
                        hintText: "\$",
                        border: InputBorder.none,
                        fillColor: AppColor.c0C1010,
                      ),
                    ]
                    // Equity Section
                    else
                      primaryTextField(
                        controller: _equityController,
                        hintText: widget.hint2,
                        border: InputBorder.none,
                        fillColor: AppColor.c0C1010,
                      ),

                    SizedBox(height: ch(18)),

                    // Title3 Section
                    if (widget.title3.isNotEmpty) ...[
                      AppText(
                        txt: widget.title3,
                        fontSize: AppFontSize.f14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.cFFFFFF,
                        height: 1.3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ch(10)),
                      primaryTextField(
                        controller: _otherController,
                        hintText: widget.hint3 ?? "",
                        border: InputBorder.none,
                        fillColor: AppColor.c0C1010,
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: ch(24)),

              // Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: cw(30)),
                child: Row(
                  children: [
                    if (widget.primarybtnHandler != null)
                      Expanded(
                        child: AppButton(
                          height: ch(40),
                          borderColor: AppColor.c575B60,
                          isButtonEnable: true,
                          onPressed: widget.primarybtnHandler ?? () {},
                          text: widget.primarybtnText ?? "Cancel",
                          buttonColor: AppColor.transparent,
                          textColor: AppColor.c575B60,
                        ),
                      ),
                    if (widget.secondarybtnHandler != null) ...[
                      SizedBox(width: ch(16)),
                      Expanded(
                        child: AppButton(
                          isButtonEnable: true,
                          height: ch(40),
                          onPressed: widget.secondarybtnHandler ?? () {},
                          text: widget.secondarybtnText ?? "OK",
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPercentSelector(
    BuildContext context,
    void Function(String) onSelect,
    List<String> percentOptions,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.fieldBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(cw(20))),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 60.h,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: ch(16)),
              children: [
                for (final value in percentOptions)
                  ListTile(
                    title: AppText(
                      txt: value,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textGrey,
                    ),
                    onTap: () {
                      onSelect(value);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
