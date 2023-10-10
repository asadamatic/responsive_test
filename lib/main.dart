import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_test/builder.dart';
import 'package:responsive_test/framework.dart';

void main() {

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 800, tablet: 450, watch: 200),
  );
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const ResponsiveBuilderApp();
      }));
}
