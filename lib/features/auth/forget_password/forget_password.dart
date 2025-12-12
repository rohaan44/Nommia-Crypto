import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/auth/forget_password/forget_password_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/routes/route_paths.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordController>(
      builder: (context, model, child) {
        return Scaffold(
          body: appBackgroundContainer(
            isScroll: true,
            children: [
              _buildAppbar(context: context),

              _buildBody(context: context, model: model),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildAppbar({required BuildContext context}) {
  return SizedBox(
    height: ch(116),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: cw(24)),
      child: Row(children: [ GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColor.white))]),
    ),
  );
}

Widget _buildBody({
  required BuildContext context,
  required ForgetPasswordController model,
}) {
  final isNext =
      model.emailController.text.isNotEmpty &&
      model.passwordController.text.isNotEmpty;
  return appBody(
    body: [
      AppText(
        txt: "Forget Password",
        fontSize: AppFontSize.f20,
        fontWeight: FontWeight.w400,
        color: AppColor.cFFFFFF,
      ),
      SizedBox(height: ch(32)),
      AppText(
        txt: "New Password",
        fontSize: AppFontSize.f12,
        fontWeight: FontWeight.w400,
        color: AppColor.cFFFFFF,
      ),
      SizedBox(height: ch(9)),
      primaryTextField(
        hintText: "Password",
        controller: model.emailController,
        border: InputBorder.none,
      ),
      SizedBox(height: ch(32)),
      AppText(
        txt: "Re-Enter New Password",
        fontSize: AppFontSize.f12,
        fontWeight: FontWeight.w400,
        color: AppColor.cFFFFFF,
      ),
      SizedBox(height: ch(9)),
      primaryTextField(
        obscureText: model.isPassHide,
        controller: model.passwordController,
        hintText: "Password",
        border: InputBorder.none,
        suffixIcon: InkWell(
          onTap: () {
            model.isPassHide = !model.isPassHide;
          },
          child: Icon(
            model.isPassHide
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            size: 30,
          ),
        ),
      ),
      SizedBox(height: ch(32)),

      SizedBox(height: ch(38)),

      AppButton(
        onPressed: () {},
        height: ch(44),
        isButtonEnable: isNext,
        text: "Continue",
      ),
      SizedBox(height: ch(74)),

      Row(
        children: [
          AppText(
            txt: "Do you have an account? ",
            fontSize: AppFontSize.f14,
            fontWeight: FontWeight.w400,
            color: AppColor.c787B7F,
          ),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.signIn);
            },
            child: AppText(
              txt: "Sign in here",
              fontSize: AppFontSize.f14,
              fontWeight: FontWeight.w400,
              color: AppColor.cFFFFFF,
              height: 1,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    ],
  );
}
