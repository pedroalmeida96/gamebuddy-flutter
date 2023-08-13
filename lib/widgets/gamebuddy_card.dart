import 'package:flutter/material.dart';

class GamebuddyCard extends StatelessWidget {
  final String title;
  final String gameType;
  final String location;
  final String gameDateTime;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GamebuddyCard({
    Key? key,
    required this.title,
    required this.gameType,
    required this.location,
    required this.gameDateTime,
    required this.onEdit,
    required this.onDelete,
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
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: 'Game Type: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: gameType, // This will not be bold
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: 'Location: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: location, // This will not be bold
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: 'Game DateTime: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: gameDateTime, // This will not be bold
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit),
                tooltip: 'Edit',
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete),
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
