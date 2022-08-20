// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum DeviceType { Mobile, Tablet, DeskTop }

DeviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0.0;

  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
  } else {
    width = mediaQueryData.size.width;
  }
  if (width >= 950) {
    return DeviceType.DeskTop;
  }
  if (width >= 600) {
    return DeviceType.Tablet;
  }
  return DeviceType.Mobile;
}

class DeviceInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenHeight;
  final double screenWidth;
  final double localHeight;
  final double localWidth;

  DeviceInfo({
    required this.orientation,
    required this.deviceType,
    required this.screenHeight,
    required this.screenWidth,
    required this.localHeight,
    required this.localWidth,
  });
}

class DeviceInfoWidget extends StatelessWidget {
  const DeviceInfoWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var mediaQueryData = MediaQuery.of(context);
      var deviceInfo = DeviceInfo(
        deviceType: getDeviceType(mediaQueryData),
        orientation: mediaQueryData.orientation,
        screenHeight: mediaQueryData.size.height,
        screenWidth: mediaQueryData.size.width,
        localHeight: constraints.maxHeight,
        localWidth: constraints.maxWidth,
      );
      return builder(context, deviceInfo);
    });
  }
}
