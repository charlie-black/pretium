import 'package:flutter/material.dart';

import '../../../../utils/text_styling.dart';

class RecentTransactions extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'Mobile',
      'amount': 'KES 500',
      'timestamp': 'Jan 03, 07:57',
    },
    {
      'type': 'Mobile',
      'amount': 'KES 1000',
      'timestamp': 'Jan 03, 06:45',
    },
    {
      'type': 'Mobile',
      'amount': 'KES 5500',
      'timestamp': 'Jan 03, 09:30',
    },
  ];

   RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recent transactions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Transaction list
          ...transactions.map((transaction) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.teal[800],
                  child: const Icon(Icons.arrow_outward, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['type'],
                        style: kTitleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      transaction['amount'],
                      style:kTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                          color: Colors.black

                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transaction['timestamp'],
                      style:kTitleStyle.copyWith(
                        fontSize: 12,
                        color: Colors.grey,

                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
