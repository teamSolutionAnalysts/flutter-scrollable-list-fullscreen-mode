import 'package:flutter/material.dart';

/// Using this widget you can render vertical/horizontal list of Images with Close icon as per requirement of Ui/Ux
/// On clicking image should open fullscreen with horizontal scrollable images
/// with close icon.
///
/// crossAxisCount : No of columns
/// direction : Listing direction horizontal or vertical
/// listOfImages : List of network url of images
/// cancelColor : Set color for close icon
/// onImageTap : Tap event for image

class CustomListingView extends StatelessWidget {
  final int crossAxisCount;
  final Axis direction;
  final List<String> listOfImages;
  final Color cancelColor;
  final Function? onImageTap;
  const CustomListingView(
      {Key? key,
      required this.crossAxisCount,
      required this.listOfImages,
      this.direction = Axis.vertical,
      this.cancelColor = Colors.white,
      this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return crossAxisCount >= 2
        ? _gridListing(context)
        : _simpleListing(context);
  }

  Widget _gridListing(BuildContext context) => GridView.builder(
        itemCount: listOfImages.length,
        itemBuilder: (context, index) => _itemView(context, index, null),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
      );

  Widget _simpleListing(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          scrollDirection: direction,
          itemBuilder: (context, index) {
            return _itemView(context, index, BoxFit.fill);
          },
          itemCount: listOfImages.length,
        ),
      );

  Widget _itemView(BuildContext context, int index, BoxFit? boxFit) =>
      GestureDetector(
        onTap: () {
          onImageTap!(index);
        },
        child: Stack(
          children: [
            Image.network(
              listOfImages[index],
              fit: boxFit,
            ),
            Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.cancel),
                  color: cancelColor,
                  iconSize: 30,
                ))
          ],
        ),
      );
}
