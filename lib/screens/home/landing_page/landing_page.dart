import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretium/screens/all_transactions/views/all_transactions_screen.dart';
import 'package:pretium/screens/home/landing_page/widgets/balance_card_widget.dart';
import 'package:pretium/utils/color_constants.dart';
import 'package:pretium/utils/text_styling.dart';

class LandingPage extends StatefulWidget {
  final int initialIndex;
  const LandingPage({super.key, required this.initialIndex});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showQRBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading:  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowDown,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text("Deposit",style: kTitleStyle.copyWith(color: Colors.black),),
                  subtitle: Text("Send crypto to your Pretium wallet",style: kNormalTextStyle.copyWith(color: Colors.black),),
                ),
                ListTile(
                  leading:  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.add,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text("Fund account",style: kTitleStyle.copyWith(color: Colors.black),),
                  subtitle: Text("Buy crypto with mobile money",style: kNormalTextStyle.copyWith(color: Colors.black),),
                ),
                ListTile(
                  leading:  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowUp,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text("Withdraw",style: kTitleStyle.copyWith(color: Colors.black),),
                  subtitle: Text("Transfer crypto from your Pretium wallet",style: kNormalTextStyle.copyWith(color: Colors.black),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          )

        ],
        backgroundColor: kPrimaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "C",
                  style: kTitleStyle.copyWith(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          _currentIndex == 0
              ? "Hello, Charles 👋"
              : _currentIndex == 1
              ? "Transactions"
              : "",
          style: kTitleStyle.copyWith(color: kTextColor, fontSize: 15),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: SizedBox.expand(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: const [
                  BalanceCardWidget(),
                  AllTransactionsScreen(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.wallet,
                          size: 30,
                          color: _currentIndex == 0 ? kPrimaryColor : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _currentIndex = 0);
                          _pageController.jumpToPage(0);
                        },
                      ),
                      CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        radius: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_2_outlined,
                            size: 28,
                            color: kTextColor,
                          ),
                          onPressed: () {
                            _showQRBottomSheet(context);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.list,
                          size: 20,
                          color: _currentIndex == 1 ? kPrimaryColor : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _currentIndex = 1);
                          _pageController.jumpToPage(1);

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


