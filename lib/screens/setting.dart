// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:booking_haven/theme/color.dart';
// import 'package:booking_haven/utils/data.dart';
// import 'package:booking_haven/widgets/custom_image.dart';
// import 'package:booking_haven/widgets/icon_box.dart';
// import 'package:booking_haven/widgets/setting_item.dart';
// import 'package:booking_haven/services/auth_service.dart';

// class SettingPage extends ConsumerStatefulWidget {
//   const SettingPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<SettingPage> createState() => _SettingPageState();
// }

// class _SettingPageState extends ConsumerState<SettingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.appBgColor,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: AppColor.appBarColor,
//             pinned: true,
//             snap: true,
//             floating: true,
//             title: _buildAppBar(),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) => _buildBody(),
//               childCount: 1,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             "Setting",
//             style: TextStyle(
//               color: AppColor.textColor,
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         IconBox(
//           child: SvgPicture.asset(
//             "assets/icons/edit.svg",
//             width: 18,
//             height: 18,
//           ),
//           bgColor: AppColor.appBgColor,
//         ),
//       ],
//     );
//   }

//   Widget _buildBody() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(right: 20, top: 10),
//       child: Column(
//         children: [
//           _buildProfile(),
//           const SizedBox(height: 40),
//           SettingItem(
//             title: "General Setting",
//             leadingIcon: Icons.settings,
//             leadingIconColor: AppColor.orange,
//           ),
//           const SizedBox(height: 10),
//           SettingItem(
//             title: "Bookings",
//             leadingIcon: Icons.bookmark_border,
//             leadingIconColor: AppColor.blue,
//           ),
//           const SizedBox(height: 10),
//           SettingItem(
//             title: "Favorites",
//             leadingIcon: Icons.favorite,
//             leadingIconColor: AppColor.red,
//           ),
//           const SizedBox(height: 10),
//           SettingItem(
//             title: "Privacy",
//             leadingIcon: Icons.privacy_tip_outlined,
//             leadingIconColor: AppColor.green,
//           ),
//           const SizedBox(height: 10),
//           SettingItem(
//             title: "Log Out",
//             leadingIcon: Icons.logout_outlined,
//             leadingIconColor: Colors.grey.shade400,
//             onTap: _showConfirmLogout,
//           ),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfile() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: Column(
//         children: <Widget>[
//           CustomImage(
//             profile["image"]!,
//             width: 80,
//             height: 80,
//             radius: 50,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             "Sangvaleap",
//             style: TextStyle(
//               color: AppColor.textColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             "+12 345 6789",
//             style: TextStyle(
//               color: AppColor.labelColor,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // void _showConfirmLogout() {
//   //   showCupertinoModalPopup(
//   //     context: context,
//   //     builder: (context) => CupertinoActionSheet(
//   //       message: const Text("Would you like to log out?"),
//   //       actions: [
//   //         CupertinoActionSheetAction(
//   //           onPressed: () async {
//   //             Navigator.of(context).pop(); // Close the action sheet

//   //             // Show a loading spinner while logging out
//   //             showDialog(
//   //               context: context,
//   //               barrierDismissible: false,
//   //               builder: (context) =>
//   //                   const Center(child: CircularProgressIndicator()),
//   //             );

//   //             final authService = ref.read(authServiceProvider);
//   //             await authService.logout();

//   //             if (!mounted) return;

//   //             Navigator.of(context).pop(); // Close the loading spinner
//   //             Navigator.of(context).pushNamedAndRemoveUntil(
//   //               '/login',
//   //               (route) => false,
//   //             );
//   //           },
//   //           child: Text(
//   //             "Log Out",
//   //             style: TextStyle(color: AppColor.actionColor),
//   //           ),
//   //         )
//   //       ],
//   //       cancelButton: CupertinoActionSheetAction(
//   //         child: const Text("Cancel"),
//   //         onPressed: () => Navigator.of(context).pop(),
//   //       ),
//   //     ),
//   //   );
//   // }
//   void _showConfirmLogout() {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         message: const Text("Would you like to log out?"),
//         actions: [
//           CupertinoActionSheetAction(
//             onPressed: () async {
//               Navigator.of(context).pop(); // Close the action sheet

//               // Capture the current context
//               final currentContext = context;

//               // Show a loading spinner while logging out
//               showDialog(
//                 context: currentContext,
//                 barrierDismissible: false,
//                 builder: (context) =>
//                     const Center(child: CircularProgressIndicator()),
//               );

//               final authService = ref.read(authServiceProvider);
//               await authService.logout();

//               if (!mounted) return;

//               Navigator.of(currentContext).pop(); // Close the loading spinner

//               // Navigate to the login screen, replacing the current route
//               Navigator.of(currentContext).pushReplacementNamed('/login');
//             },
//             child: Text(
//               "Log Out",
//               style: TextStyle(color: AppColor.actionColor),
//             ),
//           )
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: const Text("Cancel"),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_haven/theme/color.dart';
import 'package:booking_haven/widgets/custom_image.dart';
import 'package:booking_haven/widgets/icon_box.dart';
import 'package:booking_haven/widgets/setting_item.dart';
import 'package:booking_haven/services/auth_service.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  late Future<Map<String, dynamic>> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = ref.read(authServiceProvider).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: _buildAppBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Settings",
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconBox(
          child: SvgPicture.asset(
            "assets/icons/edit.svg",
            width: 18,
            height: 18,
          ),
          bgColor: AppColor.appBgColor,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 40),
          // ... keep other setting items the same ...
          SettingItem(
            title: "Log Out",
            leadingIcon: Icons.logout_outlined,
            leadingIconColor: Colors.grey.shade400,
            onTap: _showConfirmLogout,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(left: 20),
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Error loading profile",
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        final user = snapshot.data?['user'] ?? {};
        final profilePhotoUrl = user['profile_photo_url'] ?? 
          'https://ui-avatars.com/api/?name=${user['name']?[0] ?? 'U'}&color=7F9CF5&background=EBF4FF';

        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: <Widget>[
              CustomImage(
                profilePhotoUrl,
                width: 80,
                height: 80,
                radius: 50,
              ),
              const SizedBox(height: 12),
              Text(
                user['name'] ?? "Guest User",
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user['email'] ?? "No email provided",
                style: TextStyle(
                  color: AppColor.labelColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("Would you like to log out?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.of(context).pop();
              final currentContext = context;

              showDialog(
                context: currentContext,
                barrierDismissible: false,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );

              try {
                final authService = ref.read(authServiceProvider);
                await authService.logout();
                
                if (!mounted) return;
                
                Navigator.of(currentContext).pushReplacementNamed('/login');
              } catch (e) {
                Navigator.of(currentContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: ${e.toString()}')),
                );
              }
            },
            child: Text(
              "Log Out",
              style: TextStyle(color: AppColor.actionColor),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
