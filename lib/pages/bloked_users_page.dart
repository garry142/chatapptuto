import 'dart:developer';
import 'package:chatapptuto/components/user_tile.dart';
import 'package:chatapptuto/main.dart';
import 'package:chatapptuto/services/auth/auth_service.dart';
import 'package:chatapptuto/services/chat/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class BlokedUsersPage extends StatelessWidget {
  BlokedUsersPage({super.key});

  //chat && auth services
  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();

  // show confirm unblocked  box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unblock User"),
        content: const Text("Are you sure you want to unblock this user?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel "),
          ),

          //unblock button
          TextButton(
            onPressed: () {
              chatServices.unblockUser(userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User unblocked!")));
            },
            child: const Text("Unblock"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //get currentu users string
    String userId = authService.getCurrentUser()!.uid;
    log("${userId}");
    // UI
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOKED USERS"),
        actions: [],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: chatServices.getBlokedUsersStream(userId),
          builder: (context, snapshot) {
            // errors
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading.."),
              );
            }
            //loading...
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final blockedUsers = snapshot.data ?? [];

            // not users
            if (blockedUsers.isEmpty) {
              return const Center(
                child: Text("No blockeed users"),
              );
            }
            //load completed
            return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];
                return UserTile(
                  text: user["email"],
                  onTap: () => _showUnblockBox(context, user['uid']),
                );
              },
            );
          }),
    );
  }
}
