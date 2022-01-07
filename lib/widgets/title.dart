import 'package:flutter/material.dart';
import 'package:todo/screens/profile_screen.dart';

class PrimaryTitle extends StatelessWidget {
  final String title;
  const PrimaryTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              radius: 40,
              onTap: () => Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  // transitionsBuilder:
                  //     (context, animation, secondaryAnimation, child) {
                  //   const begin = Offset(0.0, 1.0);
                  //   const end = Offset.zero;
                  //   const curve = Curves.easeIn;

                  //   final tween = Tween(begin: begin, end: end);
                  //   final curvedAnimation = CurvedAnimation(
                  //     parent: animation,
                  //     curve: curve,
                  //   );

                  //   return SlideTransition(
                  //     position: tween.animate(curvedAnimation),
                  //     child: child,
                  //   );
                  // },
                  pageBuilder: (ctx, _, __) => const ProfileScreen())),
              child: const CircleAvatar(
                child: Text("A"),
              ),
            )
          ]),
    );
  }
}
