import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_app_olx/ui/auth/register_screen.dart';
import 'package:get/get.dart';
import '../../data/controllers/auth_controller.dart';
import '../../data/validators.dart';
import '../../utils/colors_utils.dart';
import '../../utils/images_utils.dart';
import '../../utils/size_config.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_toasts.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (authController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child:Form(
                key: authController.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getHeight(50),
                    ),
                    Image.asset(MyImgs.logo),
                    SizedBox(height: getHeight(20),),
                    Center(
                      child: Text(
                        "Sign In to Your Account",
                        style: kSize20BlackW700Text,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(28),
                    ),
                    Text(
                      "Email",
                      style: kSize16BlackW400Text,
                    ),
                    SizedBox(
                      height: getHeight(12),
                    ),
                    CustomTextField(
                      controller: authController.emailController,
                      validator: (value) =>
                          Validators.emailValidator(value!),
                      text: "Email",
                      icon: const Icon(Icons.email,color: primaryColor),
                      length: 40,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: FilteringTextInputFormatter
                          .singleLineFormatter,
                    ),
                    SizedBox(
                      height: getHeight(16),
                    ),
                    Text(
                      "Password",
                      style: kSize16BlackW400Text,
                    ),
                    SizedBox(
                      height: getHeight(12),
                    ),
                    CustomTextField(
                      controller: authController.passwordController,
                      validator: (value) =>
                          Validators.passwordValidator(value!),
                      text: "Password",
                      obscureText: true,
                      icon: const Icon(Icons.password,color: primaryColor),
                      suffixIcon: Icons.visibility,
                      autovalidateMode: authController
                          .passwordController.text.isNotEmpty
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChanged: (value) {
                        authController.update();
                      },
                      length: 40,
                      keyboardType: TextInputType.text,
                      inputFormatters:
                      FilteringTextInputFormatter.deny(
                          RegExp('[ ]')),
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    GestureDetector(
                      onTap: () {
                        // controller.image = null;
                        Get.to(() => ForgotPasswordScreen());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Your Password ?",
                          style: kSize16BlackW400Text.copyWith(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Center(
                        child: CustomButton(
                          title: 'Sign in',
                          function: () {
                            if(authController.emailController.text.isEmpty){
                              CustomToast.failToast(msg: 'Please Enter Email Address');
                            }
                            else if(authController.passwordController.text.isEmpty){
                              CustomToast.failToast(msg: 'Please Enter Enter');
                            }
                            else {
                              authController.signInWithEmailAndPassword();
                            }},
                        )),
                    SizedBox(height: getHeight(22),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.image = null;
                            Get.off(() => RegisterScreen());
                          },
                          child: Text(
                            " Sign up",
                            style: kSize16BlackW400Text.copyWith(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(32),),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
