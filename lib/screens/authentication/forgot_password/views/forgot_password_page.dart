import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretium/utils/color_constants.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../utils/text_styling.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    "Forgot Password",
                    style: kTitleStyle.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter your email to receive a password reset code",
                    style: kNormalTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
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

                CustomButton(
                  width: double.infinity,
                  borderRadius: 10.0,
                  height: 60,
                  colors: [kPrimaryColor, kPrimaryColor],
                  text: "Send Reset Code",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go("/login");
                    }
                  },
                ),
                SizedBox(height: 13),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
