import 'package:flutter/material.dart';
import 'package:pretium/utils/color_constants.dart';

import '../../../../utils/text_styling.dart';

class FinancialServicesCard extends StatefulWidget {
  const FinancialServicesCard({super.key});

  @override
  State<FinancialServicesCard> createState() => _FinancialServicesCardState();
}

class _FinancialServicesCardState extends State<FinancialServicesCard> {
  String _selectedCountry = 'Kenya';

  final List<String> _countries = [
    'Kenya',
    'Uganda',
    'Nigeria',
    'Ghana',
    'Malawi',
    'Zambia',
    'Rwanda',
  ];

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Update Country',
                  style: kTitleStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: _countries.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    return ListTile(
                      title: Text(country),
                      trailing: _selectedCountry == country
                          ? Icon(Icons.check, color: kPrimaryColor)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCountry = country;
                        });
                        Navigator.pop(context);
                      },
                    );

                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Financial Services',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () => _showCountryPicker(context),
                  child: Row(
                    children: [
                      Text(
                        _selectedCountry,
                        style: TextStyle(
                          color: Colors.teal[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.teal[800]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 60,
              runSpacing: 20,
              children: [
                _serviceIcon(Icons.send, 'Send Money'),
                _serviceIcon(Icons.shopping_bag, 'Buy Goods'),
                _serviceIcon(Icons.receipt, 'Paybill'),
                _serviceIcon(Icons.phone_android, 'Airtime'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceIcon(IconData iconData, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: Icon(iconData, color: Colors.teal),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
