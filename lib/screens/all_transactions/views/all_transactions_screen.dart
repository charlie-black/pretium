import 'package:flutter/material.dart';
import 'package:pretium/utils/color_constants.dart';
import 'package:pretium/utils/text_styling.dart';
import 'package:shimmer/shimmer.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildSkeleton() : _buildTransactionList(),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.white, radius: 24),
            title: Container(
              height: 14,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 6),
            ),
            subtitle: Container(
              height: 10,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionList() {
    final dummyTransactions = List.generate(10, (index) {
      return {
        "title": "Mobile",
        "amount": "KES ${(index + 1) * 100}.00",
        "date": "2025-05-${10 + index}"
      };
    });

    return ListView.builder(
      itemCount: dummyTransactions.length,
      itemBuilder: (context, index) {
        final txn = dummyTransactions[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: kPrimaryColor,
                child: const Icon(Icons.arrow_outward, color: Colors.white),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txn['title']!,
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
                    txn['amount']!,
                    style: kTitleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                        color: Colors.black

                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    txn['date']!,
                    style: kTitleStyle.copyWith(
                      fontSize: 12,
                      color: Colors.grey,

                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      },
    );
  }
}
