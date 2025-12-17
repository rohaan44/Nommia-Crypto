import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/utils/color_utils.dart';

enum TradeStatus { success, failed }

class TradeStatusDialog extends StatelessWidget {
  final TradeStatus status;
  final String orderId;
  final String mainText;
  final String subText;
  final String symbol;
  final String price;
  final Color mainColor;

  const TradeStatusDialog({
    super.key,
    required this.status,
    required this.orderId,
    required this.mainText,
    required this.subText,
    required this.symbol,
    required this.price,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors and icon based on status
    final isSuccess = status == TradeStatus.success;
    final iconColor = isSuccess ? AppColor.buyGreen : AppColor.sellRed;
    final iconData = isSuccess ? Icons.check : Icons.close;
    final titleText = isSuccess ? "Done" : "FAILED";
    final titleColor = isSuccess ? AppColor.buyGreen : AppColor.sellRed;

    return Dialog(
      backgroundColor: const Color(0xff1E2026), // Dark dialog background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: cw(300),
        height: ch(280),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon Circle
                    Container(
                      width: cw(50),
                      height: ch(50),
                      padding: isSuccess
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(
                              10,
                            ), // Adjust padding for image if needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: iconColor, width: 2),
                      ),
                      child: isSuccess
                          ? Icon(iconData, color: iconColor, size: 30)
                          : Icon(iconData, color: iconColor, size: 30),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    AppText(
                      txt: titleText,
                      color: titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 30),

                    // Order Details Line 1 (ID + ACTION + LOTS)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(
                            text: "#",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: "$orderId ",
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: "$mainText ",
                            style: TextStyle(color: mainColor),
                          ),
                          TextSpan(
                            text: subText,
                            style: TextStyle(color: mainColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Order Details Line 2 (SYMBOL + PRICE)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            text: symbol,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: " at ",
                            style: TextStyle(color: AppColor.textGrey),
                          ),
                          TextSpan(
                            text: price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Close Button
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColor.textGrey,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
