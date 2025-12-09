import 'package:flutter/material.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';

Widget appBody({required List<Widget> body, List<Widget>? footer}) {
  return Flexible(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: cw(24)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: body,
              ),
            ),
          ),
          // SizedBox(height: ch(16)),
          if (footer != null) ...[
            SizedBox(height: ch(16)),
            ...footer,
            SizedBox(height: ch(32)),
          ],
        ],
      ),
    ),
  );
}
