import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CharacterSearchInputSliver extends StatefulWidget {

  final ValueChanged<String> onChanged;
  final Duration debounceTime;
  final String hintText;
  @override
  _CharacterSearchInputSliverState createState() =>
      _CharacterSearchInputSliverState();

  CharacterSearchInputSliver(
      {this.onChanged, this.debounceTime, this.hintText});
}

class _CharacterSearchInputSliverState
    extends State<CharacterSearchInputSliver> {
  final StreamController<String> _textChangeStreamController =
      StreamController();
  StreamSubscription _textChangesSubscription;
  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(seconds: 1),
        )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child:
      Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          cursorColor: Color.fromARGB(255, 11, 183, 145),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 11, 183, 145)),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black54,
            ),
            hintText: widget.hintText == null ? "Tìm kiếm" : widget.hintText,
          ),
          onChanged: _textChangeStreamController.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}
