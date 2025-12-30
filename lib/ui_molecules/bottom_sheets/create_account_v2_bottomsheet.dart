import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:sizer/sizer.dart';

Widget createAccountBottomesheetV2({
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
  return CreateAccountBottomSheetV2(
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

class CreateAccountBottomSheetV2 extends StatefulWidget {
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

  const CreateAccountBottomSheetV2({
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
  State<CreateAccountBottomSheetV2> createState() =>
      _CreateAccountBottomSheetV2State();
}

class _CreateAccountBottomSheetV2State extends State<CreateAccountBottomSheetV2>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _nameController;

  String? _selectedCurrency;
  String? _selectedAccountType;

  final List<String> _currencyOptions = ["\$ (USD)", "€ (Euro)", "£ (GBP)"];

  final List<String> _accountTypeOptions = [
    "Trader Spread",
    "Trader Raw",
    "Connect Spread",
    "Connect Raw",
    "Pro Spread",
    "Pro Raw",
    "Elite Spread",
    "Elite Raw",
    "Demo Account (\$100)",
    "Demo Account (\$1000)",
    "Demo Account (\$10,000)",
    "Demo Account (\$100,000)",
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // Default selections
    _selectedCurrency = _currencyOptions.first;
    // Default to a common option or first
    _selectedAccountType = _accountTypeOptions.firstWhere(
      (e) => e.contains("Demo Account (\$100)"),
      orElse: () => _accountTypeOptions.first,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Height calculation
    final calculatedHeight =
        widget.sheetHeight ??
        ch(500); // Increased default height for better fit

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ch(24)),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    txt: widget.heading,
                    fontSize: AppFontSize.f16,
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
                  color: AppColor.c454F5C.withOpacity(0.2), // Subtle divider
                  borderRadius: BorderRadius.circular(cw(50)),
                ),
              ),
            SizedBox(height: ch(24)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: cw(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Name Input
                  AppText(
                    txt: widget.title1, // "Name"
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cFFFFFF.withOpacity(0.5),
                    height: 1.3,
                  ),
                  SizedBox(height: ch(8)),
                  primaryTextField(
                    controller: _nameController,
                    hintText: widget.hint1, // "Account Name"
                    border: InputBorder.none,
                    fillColor: AppColor.c0C1010,
                  ),

                  SizedBox(height: ch(18)),

                  // 2. Currency Selector
                  AppText(
                    txt: widget.title2, // "Currency"
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.cFFFFFF.withOpacity(0.5),
                    height: 1.3,
                  ),
                  SizedBox(height: ch(8)),
                  GestureDetector(
                    onTap: () => _openSelectionSheet(
                      context,
                      "Select Currency",
                      _currencyOptions,
                      (val) => setState(() => _selectedCurrency = val),
                    ),
                    child: Container(
                      height: ch(48),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: cw(14)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cw(14)),
                        color: AppColor.c0C1010,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            txt: _selectedCurrency ?? widget.hint2,
                            color: AppColor.white,
                            fontSize: AppFontSize.f14,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColor.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: ch(18)),

                  // 3. Account Type Selector
                  if (widget.title3.isNotEmpty) ...[
                    AppText(
                      txt: widget.title3, // "Account Type"
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.cFFFFFF.withOpacity(0.5),
                      height: 1.3,
                    ),
                    SizedBox(height: ch(8)),
                    GestureDetector(
                      onTap: () => _openSelectionSheet(
                        context,
                        "Select Account Type",
                        _accountTypeOptions,
                        (val) => setState(() => _selectedAccountType = val),
                      ),
                      child: Container(
                        height: ch(48),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: cw(14)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cw(14)),
                          color: AppColor.c0C1010,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              txt:
                                  _selectedAccountType ??
                                  widget.hint3 ??
                                  "Select",
                              color: AppColor.white,
                              fontSize: AppFontSize.f14,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColor.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: ch(40)),

            // Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cw(20)),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      height: ch(48),
                      borderColor: AppColor.c575B60,
                      isButtonEnable: true,
                      onPressed:
                          widget.primarybtnHandler ??
                          () => Navigator.pop(context),
                      text: widget.primarybtnText ?? "Cancel",
                      buttonColor: AppColor.transparent,
                      textColor: AppColor.c575B60,
                    ),
                  ),
                  SizedBox(width: cw(16)),
                  Expanded(
                    child: AppButton(
                      isButtonEnable: true,
                      isBorder: false,
                      height: ch(48),
                      onPressed: widget.secondarybtnHandler ?? () {},
                      text: widget.secondarybtnText ?? "OK",
                      buttonColor: AppColor.primary,
                      textColor: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSelectionSheet(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(cw(20))),
        side: BorderSide(
          color: AppColor.c2C2C32,
          width: 1,
        ), // Thin border like visual
      ),
      builder: (context) {
        return Container(
          height: ch(450),
          padding: EdgeInsets.only(
            top: ch(16),
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                ch(20), // Bottom padding
          ),
          constraints: BoxConstraints(
            maxHeight: 70.h, // Don't take full screen
          ),
          child: ListView.separated(
            shrinkWrap: true, // Wrap content height
            padding: EdgeInsets.symmetric(horizontal: cw(24)),
            itemCount: options.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: ch(24)), // Spacing between items
            itemBuilder: (_, index) {
              final item = options[index];
              return GestureDetector(
                onTap: () {
                  onSelect(item);
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        txt: item,
                        fontSize: AppFontSize.f16,
                        color: AppColor.white,
                        fontWeight: FontWeight.w400,
                      ),
                      // Expand icon for sub-menus? No, just selection.
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColor.transparent,
                        size: 20,
                      ), // Placeholder
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
