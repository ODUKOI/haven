// import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
// import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

// import 'package:booking_haven/theme/color.dart';
// import 'package:booking_haven/utils/data.dart';
// import 'package:booking_haven/widgets/city_item.dart';
// import 'package:booking_haven/widgets/feature_item.dart';
// import 'package:booking_haven/widgets/notification_box.dart';
// import 'package:booking_haven/widgets/recommend_item.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _carouselController = CarouselSliderController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.appBgColor,
//       body: NestedScrollView(
//         // Changed from CustomScrollView
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               backgroundColor: AppColor.appBarColor,
//               pinned: true,
//               floating: true,
//               snap: true,
//               expandedHeight: 100, // Added expanded height
//               flexibleSpace: FlexibleSpaceBar(
//                 background: _buildAppBar(),
//               ),
//             ),
//           ];
//         },
//         body: _buildBody(),
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Container(
//       color: AppColor.primary,
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: const Row(
//         children: [
//           Icon(
//             Icons.place_outlined,
//             color: AppColor.iconColor,
//             size: 20,
//           ),
//           SizedBox(width: 3),
//           Text(
//             "Bookin Haven",
//             style: TextStyle(
//               color: AppColor.textColor,
//               fontSize: 16,
//             ),
//           ),
//           Spacer(),
//           NotificationBox(
//             notifiedNumber: 1,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(),
//           _buildCities(),
//           _buildFeaturedSection(),
//           _buildRecommendedSection(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Padding(
//       padding: EdgeInsets.fromLTRB(15, 10, 10, 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Find and Book",
//             style: TextStyle(
//               color: AppColor.labelColor,
//               fontSize: 14,
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             "The Best Hotel Rooms",
//             style: TextStyle(
//               color: AppColor.textColor,
//               fontWeight: FontWeight.w600,
//               fontSize: 22,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCities() {
//     return SizedBox(
//       height: 50, // Fixed height for cities row
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         scrollDirection: Axis.horizontal,
//         itemCount: cities.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: CityItem(
//               data: cities[index],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFeaturedSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
//           child: Text(
//             "Featured",
//             style: TextStyle(
//               color: AppColor.textColor,
//               fontWeight: FontWeight.w500,
//               fontSize: 22,
//             ),
//           ),
//         ),
//         _buildFeaturedCarousel(),
//       ],
//     );
//   }

//   Widget _buildFeaturedCarousel() {
//     return SizedBox(
//       height: 296, // Fixed height for carousel
//       child: CarouselSlider.builder(
//         controller: _carouselController,
//         slideBuilder: (index) {
//           return FeatureItem(
//             data: features[index],
//             onTapFavorite: () {
//               setState(() {
//                 features[index]["is_favorited"] =
//                     !features[index]["is_favorited"];
//               });
//             },
//           );
//         },
//         itemCount: features.length,
//         slideTransform: const DefaultTransform(),
//         slideIndicator: CircularSlideIndicator(
//           currentIndicatorColor: AppColor.primary,
//           indicatorBackgroundColor: AppColor.darker.withOpacity(0.3),
//           itemSpacing: 12,
//         ),
//         unlimitedMode: true,
//         enableAutoSlider: true,
//       ),
//     );
//   }

//   Widget _buildRecommendedSection() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
//       child: Column(
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Recommended",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.textColor,
//                 ),
//               ),
//               Text(
//                 "See all",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColor.darker,
//                 ),
//               ),
//             ],
//           ),
//           _buildRecommendedList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecommendedList() {
//     return SizedBox(
//       height: 200, // Fixed height for recommended list
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: recommends.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 15),
//             child: RecommendItem(
//               data: recommends[index],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:booking_haven/theme/color.dart';
import 'package:booking_haven/utils/data.dart';
import 'package:booking_haven/widgets/city_item.dart';
import 'package:booking_haven/widgets/feature_item.dart';
import 'package:booking_haven/widgets/notification_box.dart';
import 'package:booking_haven/widgets/recommend_item.dart';

import '../providers/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppColor.appBarColor,
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildAppBar(),
              ),
            ),
          ];
        },
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: AppColor.primary,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Row(
        children: [
          Icon(
            Icons.place_outlined,
            color: AppColor.iconColor,
            size: 20,
          ),
          SizedBox(width: 3),
          Text(
            "Bookin Haven",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 16,
            ),
          ),
          Spacer(),
          NotificationBox(
            notifiedNumber: 1,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildCities(), // Updated method to show cities from API
          _buildFeaturedSection(),
          _buildRecommendedSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Find and Book",
            style: TextStyle(
              color: AppColor.labelColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "The Best Hotel Locations",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  /// This method now uses a Consumer widget to read the citiesProvider.
  Widget _buildCities() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final citiesAsync = ref.watch(citiesProvider);
        return citiesAsync.when(
          data: (cities) => SizedBox(
            height: 50, // Fixed height for cities row
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CityItem(
                    data: cities[index],
                  ),
                );
              },
            ),
          ),
          loading: () => const SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => SizedBox(
            height: 50,
            child: Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Text(
            "Featured",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
        ),
        _buildFeaturedCarousel(),
      ],
    );
  }

  Widget _buildFeaturedCarousel() {
    return SizedBox(
      height: 265,
      child: CarouselSlider.builder(
        controller: _carouselController,
        slideBuilder: (index) {
          return FeatureItem(
            data: features[index],
            onTapFavorite: () {
              setState(() {
                features[index]["is_favorited"] =
                    !features[index]["is_favorited"];
              });
            },
          );
        },
        itemCount: features.length,
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: AppColor.primary,
          indicatorBackgroundColor: AppColor.darker.withOpacity(0.3),
          itemSpacing: 12,
        ),
        unlimitedMode: true,
        enableAutoSlider: true,
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.darker,
                ),
              ),
            ],
          ),
          _buildRecommendedList(),
        ],
      ),
    );
  }

  Widget _buildRecommendedList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommends.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: RecommendItem(
              data: recommends[index],
            ),
          );
        },
      ),
    );
  }
}
