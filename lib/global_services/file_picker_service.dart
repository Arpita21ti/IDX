import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/providers/media_providers.dart';

class FilePickerService {
  // Pick a file and update the corresponding provider
  Future<dynamic> pickFile({
    required bool isPhoto,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isPhoto
          ? ['jpg', 'jpeg', 'png']
          : ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      if (kIsWeb) {
        // Return file bytes for web
        if (isPhoto) {
          // Update web photo bytes provider
          return result.files.single.bytes;
        } else {
          // Update web resume name provider
          return result.files.single.name;
        }
      } else {
        // Return File for other platforms
        return File(result.files.single.path!);
      }
    }
    return null; // Return null if no file is picked
  }

  // Remove the selected file by type
  void removeFile({
    required WidgetRef ref,
    required bool isPhoto,
  }) {
    if (isPhoto) {
      ref.read(photoProvider.notifier).state = null;
      ref.read(webPhotoProvider.notifier).state = null;
    } else {
      ref.read(resumeProvider.notifier).state = null;
      ref.read(webResumePathProvider.notifier).state = null;
    }
  }

  Widget displayFile({
    required WidgetRef ref,
    required bool isPhoto,
    required double height,
    required double width,
    required Uint8List? webPhotoBytes,
    required File? photo,
    required String? webNotPhotoPath,
    required File? notPhoto,
  }) {
    if (isPhoto) {
      if (kIsWeb) {
        if (webPhotoBytes != null) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  webPhotoBytes,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                icon:
                    const Icon(Icons.remove_circle_rounded, color: Colors.red),
                onPressed: () => removeFile(ref: ref, isPhoto: true),
              ),
            ],
          );
        } else {
          return const Text('No photo selected');
        }
      } else {
        if (photo != null) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  photo,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                icon:
                    const Icon(Icons.remove_circle_rounded, color: Colors.red),
                onPressed: () => removeFile(ref: ref, isPhoto: true),
              ),
            ],
          );
        } else {
          return const Text('No photo selected');
        }
      }
    } else {
      if (kIsWeb) {
        if (webNotPhotoPath != null) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.insert_drive_file, color: Colors.blue),
              const SizedBox(width: 8),
              Text(webNotPhotoPath),
              const SizedBox(width: 8),
              IconButton(
                icon:
                    const Icon(Icons.remove_circle_rounded, color: Colors.red),
                onPressed: () => removeFile(ref: ref, isPhoto: false),
              ),
            ],
          );
        } else {
          return const Text('No file selected');
        }
      } else {
        if (notPhoto != null) {
          String fileName = notPhoto.path.split('/').last;
          String extension = fileName.split('.').last.toLowerCase();
          IconData icon;

          switch (extension) {
            case 'pdf':
              icon = Icons.picture_as_pdf;
              break;
            case 'doc':
            case 'docx':
              icon = Icons.document_scanner;
              break;
            default:
              icon = Icons.insert_drive_file;
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(fileName),
              const SizedBox(width: 8),
              IconButton(
                icon:
                    const Icon(Icons.remove_circle_rounded, color: Colors.red),
                onPressed: () => removeFile(ref: ref, isPhoto: false),
              ),
            ],
          );
        } else {
          return const Text('No resume selected');
        }
      }
    }
  }
}
