import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// Using this widget you can click on image which will open fullscreen with
/// horizontal scrollable images and close icon.
/// To zoom in & zoom out you should integrate photo_view plugin
/// mediaItems : List of media Images
/// showImageIndex : Index of tapped image

class MediaFullImageView extends StatefulWidget {
  final List<String> mediaItems;
  final int showImageIndex;
  const MediaFullImageView({this.showImageIndex, this.mediaItems});

  @override
  _MediaFullImageViewState createState() => _MediaFullImageViewState();
}

class _MediaFullImageViewState extends State<MediaFullImageView> {
  PageController _pageController;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(null);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.showImageIndex);
    _currentPage.value = widget.showImageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, page, _) {
            return Stack(
              children: [
                _photoView(context),
                if (page != 0) _previousButton(context),
                if (!(page == widget.mediaItems.length - 1))
                  _nextButton(context),
                _closeButton(context)
              ],
            );
          }),
    );
  }

  Widget _photoView(BuildContext context) => PhotoViewGallery.builder(
        pageController: _pageController,
        scrollDirection: Axis.horizontal,
        scrollPhysics: const BouncingScrollPhysics(),
        onPageChanged: (page) {
          _currentPage.value = page;
        },
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.mediaItems[index]),
          );
        },
        itemCount: widget.mediaItems.length,
      );

  Widget _previousButton(BuildContext context) => Positioned(
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () async {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffB8B8B8).withOpacity(0.4),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      );

  Widget _nextButton(BuildContext context) => Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffB8B8B8).withOpacity(0.4),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      );

  Widget _closeButton(BuildContext context) => Positioned(
        top: 10,
        right: 0,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.cancel),
          color: Colors.white,
          iconSize: 30,
        ),
      );
}
