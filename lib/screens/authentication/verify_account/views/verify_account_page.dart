import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretium/utils/color_constants.dart';
import '../../../../components/custom_bottom_sheet.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../utils/text_styling.dart';

class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({super.key});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  TextEditingController verificationCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCountry;

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
                    "Verify Account",
                    style: kTitleStyle.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter the verification code sent to your email",
                    style: kNormalTextStyle.copyWith(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),
                CustomBottomSheetField<String>(
                  textLabel: 'Select a country',
                  items: const [
                    'Kenya',
                    'Uganda',
                    'Nigeria',
                    'Ghana',
                    'Malawi',
                    'Zambia',
                    'Rwanda',
                  ],
                  selectedItem: selectedCountry,
                  onChanged: (String? value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                  formHeight: 40.0,
                  isEnabled: true,
                  validatorText: 'Country is required',
                  borderRadius: 10.0,
                  borderColor: Colors.grey,
                  fillColor: Colors.white,
                  prefixIcon: Icons.person,
                ),
                CustomTextField(
                  formController: verificationCode,
                  borderRadius: 14,
                  textLabel: 'Verification code',
                  isObscured: false,
                  hasSuffixIcon: true,
                  formHeight: 60,
                  textType: TextInputType.number,
                  formWidth: double.infinity,
                  isEnabled: true,
                  isExpandable: false,
                  borderColor: Colors.grey.withOpacity(0.5),
                  maxLines: 1,
                  validatorText: 'Verification code is required',
                ),

                CustomButton(
                  width: double.infinity,
                  borderRadius: 10.0,
                  height: 60,
                  colors: [kPrimaryColor, kPrimaryColor],
                  text: "Verify",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/login');
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
                          "Didn't receive the code?",
                          style: kNormalTextStyle.copyWith(color: Colors.black54),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Resend Code',
                        style: kNormalTextStyle.copyWith(color: kPrimaryColor),
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
