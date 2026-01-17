import 'package:flutter/material.dart';
import 'package:nommia_crypto/features/auth/sign_in/sign_in_controller.dart';
import 'package:nommia_crypto/helpers/app_layout.dart';
import 'package:nommia_crypto/routes/route_paths.dart';
import 'package:nommia_crypto/ui_molecules/app_background_conatiner/app_background_conatiner.dart';
import 'package:nommia_crypto/ui_molecules/app_body/app_body.dart';
import 'package:nommia_crypto/ui_molecules/app_dismis_keyboard.dart';
import 'package:nommia_crypto/ui_molecules/app_primary_button.dart';
import 'package:nommia_crypto/ui_molecules/app_text.dart';
import 'package:nommia_crypto/ui_molecules/primary_textfield.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:nommia_crypto/utils/font_size.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInController>(
      builder: (context, model, child) {
        return Scaffold(
          body: AppDismissKeyboard(
            child: appBackgroundContainer(
              isScroll: true,
              children: [
                // _buildAppbar(context: context),
                _buildBody(context: context, model: model),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildBody({
  required BuildContext context,
  required SignInController model,
}) {
  bool isNext =
      model.emailController.text.isNotEmpty &&
      model.passwordController.text.isNotEmpty;
  return appBody(
    body: [
      SizedBox(height: 116),
      AppText(
        txt: "Sign in to Nommia",
        fontSize: AppFontSize.f20,
        fontWeight: FontWeight.w400,
        color: AppColor.cFFFFFF,
      ),
      SizedBox(height: ch(32)),
      AppText(
        txt: "Email/Phone Number",
        fontSize: AppFontSize.f12,
        fontWeight: FontWeight.w400,
        color: AppColor.cFFFFFF,
      ),
      SizedBox(height: ch(9)),
      primaryTextField(
        hintText: "name@email.com",
        controller: model.emailController,
        border: InputBorder.none,
      ),
      SizedBox(height: ch(32)),
      AppText(
        txt: "Password",
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
      SizedBox(height: ch(12)),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.forgetPassword);
        },
        child: AppText(
          txt: "Forget Password?",
          fontSize: AppFontSize.f14,
          fontWeight: FontWeight.w400,
          color: AppColor.cFFFFFF,
          height: 1,
          decoration: TextDecoration.underline,
        ),
      ),
      SizedBox(height: ch(38)),

      AppButton(
        isButtonEnable: isNext,
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.dashboardScreem);
        },
        height: ch(44),
        // isButtonEnable: isNext,
        text: "Sign in",
      ),
      SizedBox(height: ch(74)),

      Row(
        children: [
          AppText(
            txt: "Don’t have an account? ",
            fontSize: AppFontSize.f14,
            fontWeight: FontWeight.w400,
            color: AppColor.c787B7F,
          ),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.signUp);
            },
            child: AppText(
              txt: "Sign up here",
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
