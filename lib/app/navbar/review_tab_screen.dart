// import 'package:flutter/material.dart';
// import '../app_colors/app_colors.dart';
//
// class ReviewTabScreen extends StatelessWidget {
//   const ReviewTabScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Sample review data
//     final reviews = [
//       {'name': 'John Doe', 'role': 'Software Developer', 'comment': 'Great product! Really enjoyed using it. Highly recommend.', 'rating': 5, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Jane Smith', 'role': 'Designer', 'comment': 'Good experience, will use again.', 'rating': 4, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Alice Johnson', 'role': 'Product Manager', 'comment': 'Not bad, but could be improved.', 'rating': 3, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'John Doe', 'role': 'Software Developer', 'comment': 'Great product! Really enjoyed using it. Highly recommend.', 'rating': 5, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Jane Smith', 'role': 'Designer', 'comment': 'Good experience, will use again.', 'rating': 4, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Alice Johnson', 'role': 'Product Manager', 'comment': 'Not bad, but could be improved.', 'rating': 3, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'John Doe', 'role': 'Software Developer', 'comment': 'Great product! Really enjoyed using it. Highly recommend.', 'rating': 5, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Jane Smith', 'role': 'Designer', 'comment': 'Good experience, will use again.', 'rating': 4, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'Alice Johnson', 'role': 'Product Manager', 'comment': 'Not bad, but could be improved.', 'rating': 3, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//       {'name': 'John Doe', 'role': 'Software Developer', 'comment': 'Great product! Really enjoyed using it. Highly recommend.', 'rating': 5, 'avatar': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'},
//     ];
//
//     // Calculate average rating based on all review ratings
//     double totalRating = reviews.fold(0, (sum, r) => sum + (r['rating'] as int));
//     double averageRating = reviews.isNotEmpty ? totalRating / reviews.length : 0;
//     int totalReviews = reviews.length;
//
//     // Determine number of filled stars for average rating
//     int filledStars = averageRating.round();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         centerTitle: true,
//         title: const Text(
//           'Review',
//           style: TextStyle(color: AppColors.surface, fontSize: 20),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, color: AppColors.surface),
//             onPressed: () {},
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             color: AppColors.background,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Average rating
//                 Center(
//                   child: Text(
//                     averageRating.toStringAsFixed(2),
//                     style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 // Stars + total reviews (Column)
//                 Center(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(5, (index) {
//                           return Icon(
//                             index < filledStars ? Icons.star : Icons.star_border,
//                             color: Colors.amber,
//                             size: 20,
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 5),
//                       Text('Total Reviews ($totalReviews)', style: const TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Review list
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: reviews.length,
//                   itemBuilder: (context, index) {
//                     final review = reviews[index];
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             blurRadius: 5,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatar(
//                             radius: 40,
//                             backgroundColor: Colors.grey[200],
//                             child: ClipOval(
//                               child: Image.network(
//                                 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&h=150',
//                                 height: 75,
//                                 width: 75,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(review['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
//                                     Row(
//                                       children: List.generate(5, (i) {
//                                         return Icon(
//                                           i < (review['rating'] as int) ? Icons.star : Icons.star_border,
//                                           color: Colors.amber,
//                                           size: 16,
//                                         );
//                                       }),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(review['role'] as String, style: const TextStyle(color: Colors.grey)),
//                                 const SizedBox(height: 8),
//                                 Text(review['comment'] as String),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';

/// 🔥 GLOBAL REVIEWS LIST (same app me kahin se bhi update ho sakti hai)
List<Map<String, dynamic>> reviews = [
  {
    'name': 'John Doe',
    'role': 'User', // <-- added role
    'comment': 'Great product! Really enjoyed using it. Highly recommend.',
    'rating': 5,
    'avatar':
    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
  },
  {
    'name': 'Jane Smith',
    'role': 'User', // <-- added role
    'comment': 'Good experience, will use again.',
    'rating': 4,
    'avatar':
    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
  },
];

class ReviewTabScreen extends StatefulWidget {
  const ReviewTabScreen({super.key});

  @override
  State<ReviewTabScreen> createState() => _ReviewTabScreenState();
}

class _ReviewTabScreenState extends State<ReviewTabScreen> {
  VoidCallback? get _showReviewDialog => null;

  @override
  Widget build(BuildContext context) {
    /// ⭐ Average rating
    double totalRating =
    reviews.fold(0, (sum, r) => sum + (r['rating'] as int));
    double averageRating = reviews.isNotEmpty
        ? totalRating / reviews.length
        : 0;
    int filledStars = averageRating.round();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          'Review',
          style: TextStyle(color: AppColors.surface, fontSize: 20),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.background,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ⭐ Average Rating
                Center(
                  child: Text(
                    averageRating.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),

                /// ⭐ Stars + Total Reviews
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < filledStars ? Icons.star : Icons
                                .star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Total Reviews (${reviews.length})',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 📝 Review List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Avatar
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            NetworkImage(review['avatar'] ??
                                ''), // <-- default to empty string
                          ),
                          const SizedBox(width: 10),

                          /// Review Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      review['name'] ?? 'User',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: List.generate(5, (i) {
                                        return Icon(
                                          i < (review['rating'] ?? 0)
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 16,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  review['role'] ?? 'User', // <-- FIXED here
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                Text(review['comment'] ?? ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}