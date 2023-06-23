import 'package:flutter/material.dart';

class FancyCard extends StatelessWidget {
  final String title;
  final String gameType;
  final String location;
  final String gameDateTime;

  const FancyCard({
    Key? key,
    required this.title,
    required this.gameType,
    required this.location,
    required this.gameDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.grey[200]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Game Type: $gameType',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              Text(
                'Location: $location',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              Text(
                'Game DateTime: $gameDateTime',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
