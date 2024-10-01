import 'package:flutter/material.dart';
import 'package:yeni_projem/loginkullanici/musteriler.dart';
import 'package:yeni_projem/pages/musteri_listesi.dart';

class ChatPage extends StatefulWidget {
  final MusteriYonetimi musteriYonetimi;

  const ChatPage({super.key, required this.musteriYonetimi});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  String? _selectedMusteri;

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _selectedMusteri != null) {
      setState(() {
        _messages
            .add({'sender': _selectedMusteri!, 'message': _controller.text});
        _controller.clear();
      });
    }
  }

  void _selectMusteri(BuildContext context) async {
    final selectedMusteri = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MusteriListesiPage(musteriYonetimi: widget.musteriYonetimi),
      ),
    );

    if (selectedMusteri != null) {
      setState(() {
        _selectedMusteri = selectedMusteri;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          if (_selectedMusteri != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sohbet: $_selectedMusteri',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isMe = _messages[index]['sender'] == _selectedMusteri;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.teal[200] : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: isMe
                            ? const Radius.circular(10.0)
                            : const Radius.circular(0),
                        bottomRight: isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(10.0),
                      ),
                    ),
                    child: Text(_messages[index]['message']!),
                  ),
                );
              },
            ),
          ),
          if (_selectedMusteri != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectMusteri(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.person_search),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
