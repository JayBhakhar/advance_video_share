import 'package:flutter/material.dart';

class MainCategoryTitle extends StatelessWidget {
  final String titleText;
  final Function onPressed;

  MainCategoryTitle({
    @required this.titleText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // title: Text(mainCategoryList[index]),
          title: Stack(
            children: [
              Image.asset('assets/photos/background_of_text.png'),
              Positioned(
                top: 14,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text(
                    titleText,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              )
            ],
          ),
          trailing: TextButton(
            child: Text('See All',style: TextStyle(
              fontSize: 15.0
            ),),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
