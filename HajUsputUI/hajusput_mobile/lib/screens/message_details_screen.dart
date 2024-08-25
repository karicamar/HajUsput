import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/messages.dart';
import 'package:hajusput_mobile/providers/message_provider.dart';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:provider/provider.dart';

class MessageDetailsScreen extends StatefulWidget {
  final int userId;
  final String name;

  MessageDetailsScreen({required this.userId, required this.name});

  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Messages>>(
              future: Provider.of<MessageProvider>(context, listen: false)
                  .getMessagesForUser(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final message = snapshot.data![index];
                      final isSentByUser =
                          message.senderId == UserSession.userId;
                      return Align(
                        alignment: isSentByUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSentByUser
                                ? Colors.green.shade300
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.messageContent,
                            style: TextStyle(
                              color: isSentByUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      final newMessage = Messages(
                        0,
                        UserSession.userId!,
                        widget.userId,
                        _messageController.text,
                        DateTime.now(),
                      );
                      Provider.of<MessageProvider>(context, listen: false)
                          .sendMessage(newMessage)
                          .then((_) {
                        setState(() {
                          _messageController.clear();
                        });
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to send message')),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
