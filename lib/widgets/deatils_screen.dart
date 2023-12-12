// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeatilScreen extends StatefulWidget {
  final String newsImages;
  final String newsTitle;
  final String newsDate;
  final String newsAuthor;
  final String newsConten;
  final String newsSoorce;

  const DeatilScreen({
    super.key,
    required this.newsImages,
    required this.newsTitle,
    required this.newsDate,
    required this.newsAuthor,
    required this.newsConten,
    required this.newsSoorce,
  });

  @override
  State<DeatilScreen> createState() => _DeatilScreenState();
}

class _DeatilScreenState extends State<DeatilScreen> {
  @override
  Widget build(BuildContext context) {
    final time = DateFormat('MMMM dd, yyyy');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);

    if (widget.newsImages.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[600],
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget
                      .newsImages, // Replace with your placeholder image URL
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    if (kDebugMode) {
                      print(
                          'Error loading image. URL: ${widget.newsImages}, Error: $error');
                    }
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              height: height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    widget.newsTitle,
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.newsSoorce,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time.format(dateTime),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    widget.newsAuthor,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // Text('${widget.newsContent}',
                  //     maxLines: 20,
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 15,
                  //         color: Colors.black87,
                  //         fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: Image.asset('assets/images/404.webp'),
      );
    }
  }
}

// class DetailScren extends ConsumerStatefulWidget {
//   const DetailScren({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DetailScrenState();
// }

// class _DetailScrenState extends ConsumerState<DetailScren> {
//   @override
//   Widget build(BuildContext context) {
//     final time = DateFormat('MMMM dd, yyyy');
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     DateTime dateTime = DateTime.parse(widget.newsDate);

//     if (widget.newsImages.isNotEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.grey[600],
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             SizedBox(
//               height: height * 0.45,
//               width: width,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//                 child: CachedNetworkImage(
//                   imageUrl: widget
//                       .newsImages, // Replace with your placeholder image URL
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) =>
//                       const CircularProgressIndicator(),
//                   errorWidget: (context, url, error) {
//                     if (kDebugMode) {
//                       print(
//                           'Error loading image. URL: ${widget.newsImages}, Error: $error');
//                     }
//                     return const Icon(Icons.error);
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: height * 0.4),
//               padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
//               height: height * 0.6,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: ListView(
//                 children: [
//                   Text(
//                     widget.newsTitle,
//                   ),
//                   SizedBox(height: height * 0.02),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.newsSoorce,
//                           softWrap: true,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text(
//                         time.format(dateTime),
//                         softWrap: true,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                   Text(
//                     widget.newsAuthor,
//                   ),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                   // Text('${widget.newsContent}',
//                   //     maxLines: 20,
//                   //     style: GoogleFonts.poppins(
//                   //         fontSize: 15,
//                   //         color: Colors.black87,
//                   //         fontWeight: FontWeight.w500)),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     } else {
//       return SizedBox(
//         height: height,
//         width: width,
//         child: Image.asset('assets/images/404.webp'),
//       );
//     }
//   }
// }
