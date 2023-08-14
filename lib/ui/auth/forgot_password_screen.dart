import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_app_olx/widgets/custom_textField.dart';

import '../../utils/colors_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_toasts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  void _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      CustomToast.successToast(msg: 'Email Send to you Account Change Password Form Email');
      Navigator.pop(context);
    } catch (e) {
      // Handle errors, such as invalid email or user not found
      print('Error sending reset email: $e');
      // You can show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(text: 'Email',length: 50,keyboardType: TextInputType.emailAddress,icon:const Icon(Icons.email),controller: emailController,)
            ,const SizedBox(height: 16.0),
            CustomButton(
              title: 'Reset Password',
              function: (){
                _resetPassword(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
