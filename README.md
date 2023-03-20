This is a flutter package for Mawa back end REST API calls.
It has classes and methods for most(if not  all) of mawa REST calls.
This package is specific to Mawa flutter applications, it is tailor made only for that and as such it is not advisable to use this package for anything other than the mentioned use.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

To ensure correct functioning and usage of this package, packages included on this package should be included of the project this package is being used on

## Usage

When using this package your main function should look like this:
[
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawa_package/mawa_package.dart' as mawa;
import 'home.dart';


void main() {
    HttpOverrides.global = new mawa.MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    mawa.ApkVersion();  // Optional
    mawa.DeviceInfo();  // Optional
    runApp(MawaPay(server: 'dev',));
}
]

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
