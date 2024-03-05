import 'package:flutter/material.dart';

class AddAndSwipeList extends StatefulWidget {
  const AddAndSwipeList({super.key});

  @override
  _AddAndSwipeListState createState() => _AddAndSwipeListState();
}

class _AddAndSwipeListState extends State<AddAndSwipeList> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = [];
  bool _showTextInput = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_controller.text.isNotEmpty) {
        _addItem(_controller.text);
      }
      if (!_focusNode.hasFocus && _controller.text.isEmpty) {
        setState(() {
          _showTextInput = false;
        });
      }
    });
  }

  void _addItem(String description) {
    if (description.isNotEmpty) {
      setState(() {
        _items.add(description);
        _controller.clear();
        _showTextInput = false;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _items.length + (_showTextInput ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (_showTextInput && index == _items.length) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter item description',
                          ),
                          focusNode: _focusNode,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _addItem(_controller.text);
                        },
                      ),
                    ],
                  ),
                );
              }
              return Dismissible(
                key: Key(_items[index]),
                onDismissed: (direction) {
                  _removeItem(index);
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(_items[index]),
                ),
              );
            },
          ),
        ),
        if (!_showTextInput)
          ElevatedButton(
            child: Text('Add Item'),
            onPressed: () {
              setState(() {
                _showTextInput = true;
              });
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
