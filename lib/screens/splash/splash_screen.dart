import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretium/utils/color_constants.dart';
import 'package:pretium/utils/text_styling.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
      context.go("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 300),
              Image.asset("assets/logo.png",height: 100,width: 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PRETIUM",
                  style:  GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}