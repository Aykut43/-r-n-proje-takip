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
  final TextEditingController _searchController = TextEditingController();
  Musteri? _selectedMusteri;
  List<Map<String, String>> _filteredMessages = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterMessages);
    _filterMessages(); // Sayfa ilk açıldığında mevcut mesajları göster
  }

  void _filterMessages() {
    setState(() {
      _filteredMessages = _messages
          .where((message) =>
              message['message']!
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              message['sender']!
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _selectedMusteri != null) {
      setState(() {
        _messages.add({
          'sender': _selectedMusteri!.ad,
          'message': _controller.text,
        });
        _controller.clear();
        _filterMessages();
      });
    }
  }

  void _selectMusteri(BuildContext context) async {
    final selectedMusteri = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusterilerPage(
          musteriYonetimi: widget.musteriYonetimi,
        ),
      ),
    );

    if (selectedMusteri != null && selectedMusteri is Musteri) {
      setState(() {
        _selectedMusteri = selectedMusteri;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: const [
            Icon(Icons.message, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'Mesajlar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Ara...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (_selectedMusteri != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sohbet: ${_selectedMusteri!.ad} ${_selectedMusteri!.soyad}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMessages.length,
              itemBuilder: (context, index) {
                bool isMe =
                    _filteredMessages[index]['sender'] == _selectedMusteri!.ad;
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
                    child: Text(_filteredMessages[index]['message']!),
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
