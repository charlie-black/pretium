import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretium/utils/color_constants.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../utils/text_styling.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create Account",
                    style: kTitleStyle.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Simplify your crypto payments with us",
                    style: kNormalTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),

                CustomTextField(
                  formController: firstName,
                  borderRadius: 14,
                  textLabel: 'First Name',
                  isObscured: false,
                  prefixIcon: Icons.person_2_outlined,
                  formHeight: 60,
                  textType: TextInputType.text,
                  formWidth: double.infinity,
                  isEnabled: true,
                  isExpandable: false,
                  borderColor: Colors.grey.withOpacity(0.5),
                  maxLines: 1,
                  validatorText: 'First name is required',
                ),
                CustomTextField(
                  formController: lastName,
                  borderRadius: 14,
                  textLabel: 'Last Name',
                  isObscured: false,
                  prefixIcon: Icons.person_2_outlined,
                  formHeight: 60,
                  textType: TextInputType.text,
                  formWidth: double.infinity,
                  isEnabled: true,
                  isExpandable: false,
                  borderColor: Colors.grey.withOpacity(0.5),
                  maxLines: 1,
                  validatorText: 'Last name is required',
                ),
                CustomTextField(
                  formController: email,
                  borderRadius: 14,
                  textLabel: 'Email',
                  isObscured: false,
                  prefixIcon: Icons.email_outlined,
                  formHeight: 60,
                  textType: TextInputType.emailAddress,
                  formWidth: double.infinity,
                  isEnabled: true,
                  isExpandable: false,
                  borderColor: Colors.grey.withOpacity(0.5),
                  maxLines: 1,
                  validatorText: 'Email is required',
                ),
                CustomTextField(
                  borderRadius: 14,
                  formController: password,
                  textLabel: 'Password',
                  isObscured: true,
                  textType: TextInputType.text,
                  formWidth: double.infinity,
                  formHeight: 60,
                  prefixIcon: Icons.lock,
                  isEnabled: true,
                  isExpandable: false,
                  borderColor: Colors.grey.withOpacity(0.5),
                  maxLines: 1,
                  validatorText: 'Password is required',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                          activeColor: kPrimaryColor,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Accept Terms and Conditions',
                            style: kNormalTextStyle.copyWith(
                              decoration: TextDecoration.underline,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                CustomButton(
                  width: double.infinity,
                  borderRadius: 10.0,
                  height: 60,
                  colors: [kPrimaryColor, kPrimaryColor],
                  text: "Send Reset Code",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/verify_account');
                    }
                  },
                ),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Don't have an account?",
                          style: kNormalTextStyle.copyWith(color: Colors.black54),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => context.go('/login'),
                        child: Text(
                          'Login',
                          style: kNormalTextStyle.copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
