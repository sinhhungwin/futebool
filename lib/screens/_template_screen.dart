// import 'package:flutter/material.dart';
//
// import '../../enums/view_state.dart';
// import '../../scoped_models/models.dart';
// import '../base_screen.dart';
//
// class Template extends StatelessWidget {
//   static const String routeName = '/template';
//
//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (_) => Template(),
//     );
//   }
//
//   const Template({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen<T>(onModelReady: (model) {
//       model.onModelReady();
//     }, builder: (context, child, model) {
//       switch (model.state) {
// TODO: Busy
//         case ViewState.busy:
//
// TODO: Retrieved
//         case ViewState.retrieved:
//
// TODO: Error
//         case ViewState.error:
//
//         default:
//           return const Scaffold();
//       }
//     });
//   }
// }
