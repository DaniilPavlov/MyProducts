import 'package:flutter/material.dart';
import 'package:products_control/models/checkListData.dart';
import 'package:share/share.dart';

class ShareIcon extends StatelessWidget {
  final CheckList checkList;

  const ShareIcon({Key key, @required this.checkList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.share,
        color: Colors.deepPurple,
      ),
      onTap: () {
        print("tap");
        final RenderBox box = context.findRenderObject();
        final String text = "${checkList.title} - ${checkList.description}";
        Share.share(text,
            subject: checkList.description,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      },
    );
  }
}
