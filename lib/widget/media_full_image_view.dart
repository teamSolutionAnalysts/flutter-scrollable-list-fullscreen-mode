import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../model/arguments_model.dart';

/// Using this widget you can click on image which will open fullscreen with
/// horizontal scrollable images and close icon.
/// To zoom in & zoom out you should integrate photo_view plugin
/// mediaItems : List of media Images
/// showImageIndex : Index of tapped image

class MediaFullImageView extends StatefulWidget {
  const MediaFullImageView({Key? key}) : super(key: key);

  @override
  _MediaFullImageViewState createState() => _MediaFullImageViewState();
}

class _MediaFullImageViewState extends State<MediaFullImageView> {
  PageController? _pageController;
  final ValueNotifier<int?> _currentPage = ValueNotifier<int?>(null);
  ArgumentsModel? args;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)!.settings.arguments as ArgumentsModel;
      _pageController = PageController(initialPage: args!.imageIndex);
      _currentPage.value = args?.imageIndex;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, page, _) {
            return args != null
                ? Stack(
                    children: [
                      _photoView(context),
                      if (page != 0) _previousButton(context),
                      if (!(page == args!.mediaItems.length - 1))
                        _nextButton(context),
                      _closeButton(context)
                    ],
                  )
                : const SizedBox();
          }),
    );
  }

  Widget _photoView(BuildContext context) => _pageController != null
      ? PhotoViewGallery.builder(
          pageController: _pageController,
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: (page) {
            _currentPage.value = page;
          },
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(args!.mediaItems[index]),
            );
          },
          itemCount: args!.mediaItems.length,
        )
      : const CircularProgressIndicator();

  Widget _previousButton(BuildContext context) => Positioned(
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () async {
            _pageController?.previousPage(
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
            _pageController?.nextPage(
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
