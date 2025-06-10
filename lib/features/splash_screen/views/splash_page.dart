import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/core/common/constants/app_image_constants.dart';
import 'package:notes_app/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  @override
  void initState() {
    startSplashTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  startSplashTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      navigation.go('/notes');
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppImage.logo,
                  height: deviceHeight / 4,
                  width: deviceWidth / 2,
                ),
                SizedBox(height: deviceHeight / 3.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        cacheHeight: 40,
                        cacheWidth: 40,
                        AppImage.developer,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("from", style: theme.textTheme.bodyMedium),
                        Text("Rohan Stha", style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
