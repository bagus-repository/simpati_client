import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';

Widget pageLoader() => Center(
      child: SpinKitRing(
        color: ConfigColor.backgroundColor,
      ),
    );
