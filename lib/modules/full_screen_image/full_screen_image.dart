import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenImage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImage({required this.images, required this.initialIndex});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late PageController _pageController;
  late int _currentIndex;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Ensure the selected thumbnail is visible in the scrollable list
    double position = (index * 60.0) - 30.0; // 90.0 is the width of each thumbnail + padding
    if (position < 0) position = 0;
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onThumbnailTap(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          // Image Number Display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "${_currentIndex + 1} of ${widget.images.length}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Main Image Viewer
          Expanded(
            child: PhotoViewGallery.builder(
              itemCount: widget.images.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(widget.images[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              pageController: _pageController,
              onPageChanged: _onPageChanged,
              enableRotation: true, // Allow image rotation
            ),
          ),

          // Thumbnail Gallery - Centered in a Row
          Container(
            height: 80,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Center( // Use Center to center the thumbnails
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController, // Add the controller for smooth scroll
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center thumbnails horizontally
                  children: List.generate(widget.images.length, (index) {
                    return GestureDetector(
                      onTap: () => _onThumbnailTap(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          padding:  EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.images[index],
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class FullScreenImage extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   FullScreenImage({required this.images, required this.initialIndex});
//
//   @override
//   _FullScreenImageState createState() => _FullScreenImageState();
// }
//
// class _FullScreenImageState extends State<FullScreenImage> {
//   late PageController _pageController;
//   late int _currentIndex;
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: widget.initialIndex);
//     _scrollController = ScrollController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     // Ensure the selected thumbnail is visible in the scrollable list
//     double position =
//         (index * 60.0) - 30.0; // 90.0 is the width of each thumbnail + padding
//     if (position < 0) position = 0;
//     _scrollController.animateTo(
//       position,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _onThumbnailTap(int index) {
//     _pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white),
//       body: Column(
//         children: [
//           // Image Number Display
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Text(
//                 "${_currentIndex + 1} of ${widget.images.length}",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//
//           // Main Image Viewer
//           Expanded(
//             child: PhotoViewGallery.builder(
//               itemCount: widget.images.length,
//               builder: (context, index) {
//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: CachedNetworkImageProvider(
//                     widget.images[index],
//                   ),
//                   minScale: PhotoViewComputedScale.contained,
//                   maxScale: PhotoViewComputedScale.covered,
//                 );
//               },
//               scrollPhysics: BouncingScrollPhysics(),
//               backgroundDecoration: BoxDecoration(color: Colors.white),
//               pageController: _pageController,
//               onPageChanged: _onPageChanged,
//               enableRotation: true, // Allow image rotation
//             ),
//           ),
//
//           // Thumbnail Gallery
//           Container(
//             height: 80,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             child: Center(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _onThumbnailTap(index),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color:
//                                 _currentIndex == index
//                                     ? Colors.blue
//                                     : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl: widget.images[index],
//                           width: 80,
//                           height: 80,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class FullScreenImage extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   FullScreenImage({required this.images, required this.initialIndex});
//
//   @override
//   _FullScreenImageState createState() => _FullScreenImageState();
// }
//
// class _FullScreenImageState extends State<FullScreenImage> {
//   late PageController _pageController;
//   late int _currentIndex;
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: widget.initialIndex);
//     _scrollController = ScrollController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     // Ensure the selected thumbnail is visible in the scrollable list
//     double position = (index * 90.0) - 45.0; // 90.0 is the width of each thumbnail + padding
//     if (position < 0) position = 0;
//     _scrollController.animateTo(
//       position,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _onThumbnailTap(int index) {
//     _pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white),
//       body: Column(
//         children: [
//           // Image Number Display
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Text(
//                 "${_currentIndex + 1} of ${widget.images.length}",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//
//           // Main Image Viewer
//           Expanded(
//             child: PhotoViewGallery.builder(
//               itemCount: widget.images.length,
//               builder: (context, index) {
//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: CachedNetworkImageProvider(widget.images[index]),
//                   minScale: PhotoViewComputedScale.contained,
//                   maxScale: PhotoViewComputedScale.covered,
//                 );
//               },
//               scrollPhysics: BouncingScrollPhysics(),
//               backgroundDecoration: BoxDecoration(color: Colors.white),
//               pageController: _pageController,
//               onPageChanged: _onPageChanged,
//             ),
//           ),
//
//           // Thumbnail Gallery
//           Container(
//             height: 80,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             child: Center(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _onThumbnailTap(index),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: _currentIndex == index
//                                 ? Colors.blue
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl: widget.images[index],
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class FullScreenImage extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   FullScreenImage({required this.images, required this.initialIndex});
//
//   @override
//   _FullScreenImageState createState() => _FullScreenImageState();
// }
//
// class _FullScreenImageState extends State<FullScreenImage> {
//   late PageController _pageController;
//   late int _currentIndex;
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: widget.initialIndex);
//     _scrollController = ScrollController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     // Ensure the selected thumbnail is visible in the scrollable list
//     double position = (index * 60.0) - 30.0; // 90.0 is the width of each thumbnail + padding
//     if (position < 0) position = 0;
//     _scrollController.animateTo(
//       position,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _onThumbnailTap(int index) {
//     _pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white),
//       body: Column(
//         children: [
//           // Main Image Viewer
//           Expanded(
//             child: PhotoViewGallery.builder(
//               itemCount: widget.images.length,
//               builder: (context, index) {
//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: CachedNetworkImageProvider(widget.images[index]),
//                   minScale: PhotoViewComputedScale.contained,
//                   maxScale: PhotoViewComputedScale.covered,
//                 );
//               },
//               scrollPhysics: BouncingScrollPhysics(),
//               backgroundDecoration: BoxDecoration(color: Colors.white),
//               pageController: _pageController,
//               onPageChanged: _onPageChanged,
//             ),
//           ),
//
//           // Thumbnail Gallery
//           Container(
//             height: 80,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             child: Center(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _onThumbnailTap(index),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: _currentIndex == index
//                                 ? Colors.blue
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl: widget.images[index],
//                           width: 80,
//                           height: 80,
//                          ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class FullScreenImage extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;
//
//   FullScreenImage({required this.images, required this.initialIndex});
//
//   @override
//   _FullScreenImageState createState() => _FullScreenImageState();
// }
//
// class _FullScreenImageState extends State<FullScreenImage> {
//   late PageController _pageController;
//   late int _currentIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _onThumbnailTap(int index) {
//     _pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white),
//       body: Column(
//         children: [
//           // Main Image Viewer
//           Expanded(
//             child: PhotoViewGallery.builder(
//               itemCount: widget.images.length,
//               builder: (context, index) {
//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: CachedNetworkImageProvider(widget.images[index]),
//                   minScale: PhotoViewComputedScale.contained,
//                   maxScale: PhotoViewComputedScale.covered,
//                 );
//               },
//               scrollPhysics: BouncingScrollPhysics(),
//               backgroundDecoration: BoxDecoration(color: Colors.white),
//               pageController: _pageController,
//               onPageChanged: _onPageChanged,
//             ),
//           ),
//
//           // Thumbnail Gallery
//           Container(
//             height: 80,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.images.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () => _onThumbnailTap(index),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: _currentIndex == index
//                               ? Colors.blue
//                               : Colors.transparent,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: widget.images[index],
//                         width: 80,
//                         height: 80,
//                        ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
