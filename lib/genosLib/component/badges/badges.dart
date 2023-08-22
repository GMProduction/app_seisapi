import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../genText.dart';

class Badgesred extends StatelessWidget {
  final String text;


  const Badgesred(
      {Key? key,
        this.text = "",
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(child: GenText(text, style: TextStyle(color: Colors.white),));
  }
}



