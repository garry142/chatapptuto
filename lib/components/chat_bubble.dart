import 'package:chatapptuto/services/chat/chat_services.dart';
import 'package:chatapptuto/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.messageId,
      required this.userId});
//show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              //report message  button
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  _reportContent(context, messageId, userId);
                },
              ),

              //blocked user button
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Block user'),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),
              //cancel  button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

//reports mesaage
  void _reportContent(BuildContext context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Report Messega"),
              content:
                  const Text("Are you sure you want to report this message?"),
              actions: [
                //cancel  button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                //report button
                TextButton(
                  onPressed: () {
                    ChatServices().reportUser(messageId, userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Messege Reported")));
                  },
                  child: const Text("Report"),
                ),
              ],
            ));
  }

  //block users
  void _blockUser(
    BuildContext context,
    String messageId,
  ) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Block User"),
              content:
                  const Text("Are you sure you want to block  this message?"),
              actions: [
                //cancel  button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                //block  button
                TextButton(
                  onPressed: () {
                    ChatServices().blockUser(userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User Blocked!")));
                  },
                  child: const Text("Report"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // ligh vs dark  mode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemesProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          //show options
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
              color: isCurrentUser
                  ? Colors.white
                  : (isDarkMode ? Colors.white : Colors.black)),
        ),
      ),
    );
  }
}
