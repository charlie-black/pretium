import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pretium/utils/color_constants.dart';
import 'package:pretium/utils/text_styling.dart';

class UnlockWithPinScreen extends StatefulWidget {
  const UnlockWithPinScreen({super.key});

  @override
  _UnlockWithPinScreenState createState() => _UnlockWithPinScreenState();
}

class _UnlockWithPinScreenState extends State<UnlockWithPinScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final TextEditingController _pinController = TextEditingController();

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Unlock to use Pretium',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        _onVerified();
      }
    } catch (e) {
      print('Auth error: $e');
    }
  }

  void _onVerified() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Welcome back!'), backgroundColor: Colors.teal),
    );
    context.go("/landing_page");
  }

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_onPinChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticate();
    });
  }

  void _onPinChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Hello, Charles 👋",
                  style: kTitleStyle.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Verify your PIN to unlock",
                  style: kNormalTextStyle.copyWith(color: Colors.white70),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: renderPinCircles(),
            ),
            renderKeyboard(),
            GestureDetector(
              onTap: () => context.go("/forgot_password"),
              child: Text(
                "Forgot PIN?",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderPinCircles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool filled = index < _pinController.text.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? Colors.white : Colors.transparent,
            border: Border.all(color: Colors.white, width: 2),
          ),
        );
      }),
    );
  }

  Widget renderKeyboard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var row in [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
            ['fingerprint', '0', 'back'],
          ])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  row.map((value) {
                    if (value == 'fingerprint') {
                      return IconButton(
                        icon: Icon(Icons.fingerprint, color: Colors.white),
                        onPressed: _authenticate,
                      );
                    } else if (value == 'back') {
                      return IconButton(
                        icon: Icon(Icons.backspace, color: Colors.white),
                        onPressed: () {
                          if (_pinController.text.isNotEmpty) {
                            setState(() {
                              _pinController.text = _pinController.text
                                  .substring(0, _pinController.text.length - 1);
                            });
                          }
                        },
                      );
                    } else {
                      return TextButton(
                        onPressed: () {
                          if (_pinController.text.length < 4) {
                            setState(() {
                              _pinController.text += value;
                            });

                            if (_pinController.text.length == 4) {
                              _onVerified();
                            }
                          }
                        },
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      );
                    }
                  }).toList(),
            ),
        ],
      ),
    );
  }
}
