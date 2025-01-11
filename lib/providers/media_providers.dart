import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final photoProvider = StateProvider<File?>((ref) => null);
final webPhotoProvider = StateProvider<Uint8List?>((ref) => null);
final resumeProvider = StateProvider<File?>((ref) => null);
final webResumePathProvider = StateProvider<String?>((ref) => null);
final tempFilePreviewProvider = StateProvider<Widget?>((ref) => null);
