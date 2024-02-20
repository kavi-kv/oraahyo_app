// import 'package:flutter/material.dart';
// import 'package:oraah_app/src/features/controllers/animations/animation_controller.dart';

// class CustomPageRoute extends PageRouteBuilder{
//    final Widget page;
//    final MyAnimationController myAnimationController;

//   CustomPageRoute({required this.page, required this.myAnimationController})
//       : super(
//           pageBuilder: (context, animation, secondaryAnimation) => page,
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             // Use your controller's animations here
//             return FadeTransition(
//               opacity: myAnimationController.opacityAnimation!,
//               child: SizeTransition(
//                 sizeFactor: myAnimationController.widthAnimation!,
//                 child: child,
//               ),
//             );
//           },
//         );
// }