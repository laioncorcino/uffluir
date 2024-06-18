import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uffluir/models/singletonUser.dart';
import 'package:uffluir/models/user.dart';

class Chat extends StatefulWidget {
  static const String routeName = "/chat";
  final String? userName;

  const Chat({Key? key, this.userName}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  late UserModel currentUser; // Usuário atual

  @override
  void initState() {
    super.initState();
    // Obter o usuário atual do Singleton
    currentUser = UserModelSingleton().userModel!;
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = {
      'text': _messageController.text,
      'senderId': currentUser.id,
      'senderName': currentUser.nome,
      'receiverName':
          widget.userName, // Nome da pessoa com quem o usuário está conversando
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('messages').add(message);
      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Widget _buildListMessage() {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where('senderName', isEqualTo: currentUser.nome)
            .where('receiverName', isEqualTo: widget.userName)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!.docs;

          return ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return ListTile(
                title: Text(message['text']),
                subtitle: Text('Você'),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Digite uma mensagem...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat com ${widget.userName}",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildListMessage(),
                _buildInput(),
              ],
            ),
            Positioned(
              child:
                  _isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
