import 'package:flutter/material.dart';

import '../model/arguments_model.dart';
import '../widget/custom_listing_view.dart';

///Home Page for Custom Listing View

/// _listOfPictures : List of picture to render in listview or gridview as per requirement of Ui/Ux

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> _listOfPictures = [
    "https://cdn.ebaumsworld.com/mediaFiles/picture/1961176/81660963.jpg",
    "https://thumbs.dreamstime.com/b/summer-sunny-forest-trees-green-grass-nature-wood-sunlight-background-instant-toned-image-53353502.jpg",
    "https://i.pinimg.com/736x/69/19/59/691959b187b2b253eb2a8aaff72200b5.jpg",
    "https://i.pinimg.com/originals/34/8b/06/348b06df7318f5d334deec9cf46a889c.jpg",
    "https://www.a2zphoto.photo/img/s/v-10/p1872766193-3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomListingView(
            crossAxisCount: 1,
            listOfImages: _listOfPictures,
            cancelColor: Colors.white,
            direction: Axis.horizontal,
            onImageTap: (pos) {
              _onTapRedirection(context, pos);
            },
          ),
        ],
      ),
    );
  }

  void _onTapRedirection(BuildContext context, int pos) {
    Navigator.pushNamed(
      context,
      '/routeFullImage',
      arguments: ArgumentsModel(pos, _listOfPictures),
    );
  }
}
