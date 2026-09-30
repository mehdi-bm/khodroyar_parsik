import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_storage.dart';

enum _PhotoAction { camera, gallery, remove }

/// Tappable circular photo picker shared by every optional-photo form field
/// (vehicle, maintenance, expense, document, ...). Persists the picked file
/// via [ImageStorage] under [folder] and reports the new path — or `null`
/// if the user explicitly removes the photo — through [onChanged]. A
/// cancelled picker call does not invoke [onChanged] at all.
class PhotoPickerAvatar extends StatelessWidget {
  const PhotoPickerAvatar({
    super.key,
    required this.photoPath,
    required this.folder,
    required this.onChanged,
    this.icon = Icons.add_a_photo_outlined,
  });

  final String? photoPath;
  final String folder;
  final ValueChanged<String?> onChanged;
  final IconData icon;

  Future<void> _handleTap(BuildContext context) async {
    final action = await showModalBottomSheet<_PhotoAction>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('گرفتن عکس'),
              onTap: () => Navigator.pop(sheetContext, _PhotoAction.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('انتخاب از گالری'),
              onTap: () => Navigator.pop(sheetContext, _PhotoAction.gallery),
            ),
            if (photoPath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('حذف عکس'),
                onTap: () => Navigator.pop(sheetContext, _PhotoAction.remove),
              ),
          ],
        ),
      ),
    );

    if (action == null || !context.mounted) return;
    if (action == _PhotoAction.remove) {
      onChanged(null);
      return;
    }

    final source = action == _PhotoAction.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (picked == null) return;

      final persistedPath = await ImageStorage.persist(
        picked.path,
        folder: folder,
      );
      if (context.mounted) onChanged(persistedPath);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'انتخاب عکس انجام نشد. دسترسی دوربین یا گالری را بررسی کنید.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: photoPath == null ? 'افزودن عکس' : 'تغییر عکس',
      child: GestureDetector(
        onTap: () => _handleTap(context),
        child: CircleAvatar(
          radius: 48,
          backgroundColor: theme.colorScheme.primaryContainer,
          // Decode at the avatar's own pixel size, not the picked photo's
          // full resolution — see the identical note on VehicleCard.
          backgroundImage: photoPath == null
              ? null
              : ResizeImage(
                  FileImage(File(photoPath!)),
                  width: 288,
                  height: 288,
                ),
          child: photoPath == null
              ? Icon(icon, color: theme.colorScheme.onPrimaryContainer)
              : null,
        ),
      ),
    );
  }
}
