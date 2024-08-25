import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/messages.dart';
import 'package:hajusput_mobile/providers/message_provider.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:hajusput_mobile/widgets/master_screen.dart';
import 'package:provider/provider.dart';
import 'message_details_screen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final Map<int, ValueNotifier<String>> userNamesNotifiers = {};
  late Future<List<Messages>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    _messagesFuture = Provider.of<MessageProvider>(context, listen: false)
        .getMessagesForUser(UserSession.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      content: FutureBuilder<List<Messages>>(
        future: _messagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages found.'));
          } else {
            // Group messages by unique user and get the most recent message
            final uniqueUsersMessages = _getLastMessagesPerUser(snapshot.data!);

            return ListView.builder(
              itemCount: uniqueUsersMessages.length,
              itemBuilder: (context, index) {
                final message = uniqueUsersMessages[index];
                final otherUserId = message.senderId == UserSession.userId
                    ? message.receiverId
                    : message.senderId;

                return ValueListenableBuilder<String>(
                  valueListenable: userNamesNotifiers[otherUserId]!,
                  builder: (context, userName, child) {
                    final isSentByUser = message.senderId == UserSession.userId;
                    final messageContent = isSentByUser
                        ? 'You: ${message.messageContent}'
                        : message.messageContent;
                    final messageStyle = isSentByUser
                        ? TextStyle(fontWeight: FontWeight.normal)
                        : TextStyle(fontWeight: FontWeight.bold);

                    return ListTile(
                      title: Text(userName),
                      subtitle: Text(messageContent, style: messageStyle),
                      trailing: Text(
                        formatMessageDate(message.messageDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageDetailsScreen(
                                userId: otherUserId!, name: userName),
                          ),
                        );
                        setState(() {
                          _loadMessages(); // Reload the messages when coming back
                        });
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
      currentIndex: 3, // Adjust this index based on your app's navigation
    );
  }

  List<Messages> _getLastMessagesPerUser(List<Messages> messages) {
    final Map<int, Messages> lastMessagesMap = {};

    // Sort messages by date in descending order
    messages.sort((a, b) => b.messageDate.compareTo(a.messageDate));
    // print('Sorted Messages:');
    // messages.forEach((message) {
    //   print('Message ID: ${message.messageId}, Date: ${message.messageDate}');
    // });

    for (var message in messages) {
      final otherUserId = message.senderId == UserSession.userId
          ? message.receiverId
          : message.senderId;

      if (otherUserId != null) {
        if (!lastMessagesMap.containsKey(otherUserId) ||
            lastMessagesMap[otherUserId]!
                .messageDate
                .isBefore(message.messageDate)) {
          lastMessagesMap[otherUserId] = message;
          _initializeUserNameNotifier(otherUserId);
          // print(
          //     'Updated last message for user $otherUserId: ${message.messageContent}');
        }
      }
    }

    return lastMessagesMap.values.toList();
  }

  void _initializeUserNameNotifier(int userId) {
    if (userNamesNotifiers.containsKey(userId)) return;

    final userNameNotifier = ValueNotifier<String>('Loading...');
    userNamesNotifiers[userId] = userNameNotifier;

    _fetchUserName(userId);
  }

  Future<void> _fetchUserName(int userId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final user = await userProvider.getById(userId);
      userNamesNotifiers[userId]!.value = user.firstName;
    } catch (e) {
      print('Error fetching user name: $e');
      userNamesNotifiers[userId]!.value = 'Unknown User';
    }
  }

  @override
  void dispose() {
    for (var notifier in userNamesNotifiers.values) {
      notifier.dispose();
    }
    super.dispose();
  }
}
