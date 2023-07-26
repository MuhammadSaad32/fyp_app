import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_app_olx/widgets/custom_toasts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/controllers/auth_controller.dart';
import '../../data/validators.dart';
import '../../utils/colors_utils.dart';
import '../../utils/size_config.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: bodyBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
              onPressed: () => Get.off(LoginScreen()),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: GetBuilder<AuthController>(builder: (authController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: authController.signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(0),
                        ),
                        Center(
                          child: Text(
                            "Create Account",
                            style: kSize24blackW400Text.copyWith(
                                color: primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(28),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "First Name",
                                  style: kSize16BlackW400Text,
                                ),
                                SizedBox(
                                  height: getHeight(12),
                                ),
                                CustomTextField(
                                  controller:
                                      authController.firstNameController,
                                  validator: (value) =>
                                      Validators.firstNameValidation(value!),
                                  width: getWidth(180),
                                  text: "First Name",
                                  length: 40,
                                  keyboardType: TextInputType.name,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: getWidth(12),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Name",
                                  style: kSize16BlackW400Text,
                                ),
                                SizedBox(
                                  height: getHeight(12),
                                ),
                                CustomTextField(
                                  controller: authController.lastNameController,
                                  validator: (value) =>
                                      Validators.lastNameValidation(value!),
                                  width: getWidth(180),
                                  text: "Last Name",
                                  length: 40,
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Email",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          // errorText: 'Please enter some text',
                          controller: authController.emailController,
                          text: "example@gmail.com",
                          // errorText: "",
                          length: 40,
                          validator: (value) =>
                              Validators.emailValidator(value!),
                          onChanged: (value) {
                            authController.update();
                          },
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Phone",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          controller: authController.phoneController,
                          text: "123456789",
                          length: 11,
                          validator: (value) =>
                              Validators.phoneNumber(value!),
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),
                        SizedBox(
                          height: getHeight(12),
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
                          text: "********",
                          obscureText: true,
                          suffixIcon: Icons.visibility,
                          autovalidateMode:
                              authController.passwordController.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            authController.update();
                          },
                          length: 40,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        ),
                        SizedBox(
                          height: getHeight(16),
                        ),
                        Text(
                          "Confirm Password",
                          style: kSize16BlackW400Text,
                        ),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        CustomTextField(
                          controller: authController.confirmPassword,
                          validator: (value) =>
                              Validators.passwordValidator(value!),
                          text: "********",
                          length: 40,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        ),

                        SizedBox(
                          height: getHeight(22),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => authController.pickImage(ImageSource.gallery),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: primaryColor,
                              backgroundImage: authController.image != null ? FileImage(authController.image!) : null,
                              child: authController.image == null ? const Icon(Icons.camera,color: whiteColor,) : null,
                            ),
                          ),
                        ),
                        SizedBox(height: getHeight(12),),
                        Center(
                            child: CustomButton(
                          title: 'Sign up',
                          function: () async {
                            if (authController.signUpFormKey.currentState!
                                .validate()) {
                              if(authController.image==null){
                                CustomToast.failToast(msg: 'Please Upload Image');
                              }
                             else{
                               await authController.uploadImage();
                                authController.createAccountWithEmailAndPassword();
                             }
                            }
                          },
                        )),
                        SizedBox(
                          height: getHeight(12),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => LoginScreen());
                              },
                              child: Text(
                                " Sign in",
                                style: kSize16BlackW400Text.copyWith(
                                    color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(32),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )),
    );
  }
}
