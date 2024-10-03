import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List<Map<String, String>> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Mesajları yükleme işlemleri burada yapılabilir
  }

  void _saveMessages() {
    // Mesajları kaydetme işlemleri burada yapılabilir
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _selectedMusteri != null) {
      setState(() {
        _messages
            .add({'sender': _selectedMusteri!, 'message': _controller.text});
        _controller.clear();
      });
      _saveMessages();
    }
  }

  void _deleteMessage(int index) {
    setState(() {
      _messages.removeAt(index);
    });
    _saveMessages();
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

  void _searchMessages(String query) {
    setState(() {
      _filteredMessages = _messages
          .where((message) =>
              message['message']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: GoogleFonts.quicksand(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MessageSearchDelegate(
                  messages: _messages,
                  onSearch: _searchMessages,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMessages.isNotEmpty
                  ? _filteredMessages.length
                  : _messages.length,
              itemBuilder: (context, index) {
                final message = _filteredMessages.isNotEmpty
                    ? _filteredMessages[index]
                    : _messages[index];
                bool isMe = message['sender'] == _selectedMusteri;
                return Dismissible(
                  key: Key(message['message']!),
                  onDismissed: (direction) {
                    _deleteMessage(index);
                  },
                  background: Container(color: Colors.red),
                  child: Align(
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
                      child: Text(message['message']!),
                    ),
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

class MessageSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> messages;
  final Function(String) onSearch;

  MessageSearchDelegate({required this.messages, required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    final results = messages
        .where((message) =>
            message['message']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final message = results[index];
        return ListTile(
          title: Text(message['message']!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = messages
        .where((message) =>
            message['message']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final message = suggestions[index];
        return ListTile(
          title: Text(message['message']!),
        );
      },
    );
  }
}
