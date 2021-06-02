import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rtm_system/model/notice/model_all_notice.dart';
import 'package:rtm_system/ultils/commonWidget.dart';

/// List item representing a single Character with its photo and name.
class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
     this.character,
    Key key,
  }) : super(key: key);

  final NoticeList character;

  @override
  Widget build(BuildContext context) =>  containerButton(context, character.id, character.title, character.content, "${character.createDate}");
}
