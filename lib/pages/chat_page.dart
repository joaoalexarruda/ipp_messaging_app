import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/components/chat_bubble.dart';
import 'package:ipp_messaging_app/services/auth/auth_service.dart';
import 'package:ipp_messaging_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(
      () {
        if (myFocusNode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => scrollDown(),
          );
        }
      },
    );

    // scroll down
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // dispose focus node
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // send message
  void sendMessage() async {
    // if there is something to send
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      // clear text field
      _messageController.clear();
    }

    // scroll down
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(1),
        title: Text(
          widget.receiverEmail,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // all messages
          Expanded(
            child: _buildMessagesList(),
          ),

          // message input
          _buildUserInput(context),
        ],
      ),
    );
  }

  // build messages list
  Widget _buildMessagesList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverID,
        senderID,
      ),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          );
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        // return list view
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> messageData = doc.data() as Map<String, dynamic>;

    // if message is from current user > align right
    bool isCurrentUser =
        messageData["senderID"] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: messageData['message'],
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  // message input
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onTap: scrollDown,
                controller: _messageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(1),
                    ),
                  ),
                  hintText: "Start typing...",
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.2),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary.withOpacity(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
