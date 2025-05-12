import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pretium/utils/color_constants.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../utils/text_styling.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.wallet,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Welcome Back!",
                    style: kTitleStyle.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Sign in to continue",
                    style: kNormalTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      formController: email,
                      borderRadius: 14,
                      textLabel: 'Email',
                      isObscured: false,
                      prefixIcon: Icons.email_outlined,
                      formHeight: 50,
                      textType: TextInputType.emailAddress,
                      formWidth: double.infinity,
                      isEnabled: true,
                      isExpandable: false,
                      borderColor: Colors.grey.withOpacity(0.5),
                      maxLines: 1,
                      validatorText: 'Email is required',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      borderRadius: 14,
                      formController: password,
                      textLabel: 'Password',
                      isObscured: true,
                      textType: TextInputType.text,
                      formWidth: double.infinity,
                      formHeight: 50,
                      prefixIcon: Icons.lock,
                      isEnabled: true,
                      isExpandable: false,
                      borderColor: Colors.grey.withOpacity(0.5),
                      maxLines: 1,
                      validatorText: 'Password is required',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Text(
                              'Remember me',
                              style: kNormalTextStyle.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => context.go('/forgot_password'),

                          child: Text(
                            'Forgot Password?',
                            style: kNormalTextStyle.copyWith(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  CustomButton(
                    width: double.infinity,
                    borderRadius: 10.0,
                    height: 60,
                    colors: [kPrimaryColor, kPrimaryColor],
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.go("/pin_unlock");
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
                          onTap: () => context.go('/signup'),
                          child: Text(
                            'Sign up',
                            style: kNormalTextStyle.copyWith(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
