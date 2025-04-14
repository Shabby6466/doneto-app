import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:doneto/core/services/permissions/permission_service.dart';

enum CustomPermission { camera, mediaLibrary, storage, location, contact, photos, notification, microphone }

abstract class PermissionEngineGetter {
  /// this is method is used to check permission
  Future<bool> hasPermission(CustomPermission permission);
}

abstract class PermissionEngineResolver {
  /// this is method is used to resolve permission
  Future<bool> resolvePermission(CustomPermission permission);
}

abstract class PermissionEngine implements PermissionEngineGetter, PermissionEngineResolver {}

@LazySingleton(as: PermissionEngine)
class PermissionEngineImp implements PermissionEngine {
  PermissionService permissionsService;

  PermissionEngineImp(this.permissionsService);

  @override
  Future<bool> resolvePermission(CustomPermission permission) async {
    switch (permission) {
      case CustomPermission.notification:
        var permissionStatus = await permissionsService.status(Permission.notification);
        await handlerPermissionStatus(
            customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.notification);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }

        if (afterPermissionStatus.isLimited) {
          return true;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.photos:
        var permissionStatus = await permissionsService.status(Permission.photos);
        await handlerPermissionStatus(
            customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.photos);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }

        if (afterPermissionStatus.isLimited) {
          return true;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.contact:
        var permissionStatus = await permissionsService.status(Permission.contacts);
        await handlerPermissionStatus(customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.contacts);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.camera:
        var permissionStatus = await permissionsService.status(Permission.camera);
        await handlerPermissionStatus(customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.camera);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.mediaLibrary:
        var permissionStatus = await permissionsService.status(Permission.mediaLibrary);
        await handlerPermissionStatus(customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.mediaLibrary);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.storage:
        var permissionStatus = await permissionsService.status(Permission.storage);
        await handlerPermissionStatus(customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.storage);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.location:
        var permissionStatus = await permissionsService.status(Permission.location);
        await handlerPermissionStatus(customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.location);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
      case CustomPermission.microphone:
        var permissionStatus = await permissionsService.status(Permission.microphone);
        await handlerPermissionStatus(
            customPermission: permission, permissionStatus: permissionStatus);
        var afterPermissionStatus = await permissionsService.status(Permission.microphone);
        if (afterPermissionStatus.isPermanentlyDenied || afterPermissionStatus.isDenied) {
          return false;
        }
        return afterPermissionStatus.isGranted;
    }
  }

  @override
  Future<bool> hasPermission(CustomPermission permission) async {
    switch (permission) {
      case CustomPermission.notification:
        var permissionStatus = await permissionsService.status(Permission.notification);
        return permissionStatus.isGranted;
      case CustomPermission.photos:
        var permissionStatus = await permissionsService.status(Permission.photos);
        return permissionStatus.isGranted;
      case CustomPermission.contact:
        var permissionStatus = await permissionsService.status(Permission.contacts);
        return permissionStatus.isGranted;
      case CustomPermission.camera:
        var permissionStatus = await permissionsService.status(Permission.camera);
        return permissionStatus.isGranted;
      case CustomPermission.storage:
        var permissionStatus = await permissionsService.status(Permission.storage);
        return permissionStatus.isGranted;
      case CustomPermission.mediaLibrary:
        var permissionStatus = await permissionsService.status(Permission.mediaLibrary);
        return permissionStatus.isGranted;
      case CustomPermission.location:
        var permissionStatus = await permissionsService.status(Permission.location);
        return permissionStatus.isGranted;
      case CustomPermission.microphone:
        var permissionStatus = await permissionsService.status(Permission.microphone);
        return permissionStatus.isGranted;
    }
  }

  Future<bool> handlerPermissionStatus({required CustomPermission customPermission, required PermissionStatus permissionStatus}) async {
    if (permissionStatus.isGranted) {
      return true;
    }

    if (permissionStatus.isDenied) {
      // You can only get permanently denied on android after calling
      var permissionStatus = await requestPermission(customPermission);
      if (permissionStatus == PermissionStatus.permanentlyDenied && Platform.isAndroid) {
        await permissionsService.openAppSettings();
      }
      return false;
    }

    if (permissionStatus.isLimited) {
      await permissionsService.openAppSettings();
      return false;
    }

    if (permissionStatus.isPermanentlyDenied) {
      await permissionsService.openAppSettings();
      return false;
    }

    return false;
  }

  Future<PermissionStatus> requestPermission(CustomPermission permission) async {
    switch (permission) {
      case CustomPermission.notification:
        return await Permission.notification.request();
      case CustomPermission.contact:
        return await Permission.contacts.request();
      case CustomPermission.photos:
        return await Permission.photos.request();
      case CustomPermission.camera:
        return await Permission.camera.request();

      case CustomPermission.mediaLibrary:
        return await Permission.photos.request();
      case CustomPermission.location:
        return await Permission.location.request();
      case CustomPermission.storage:
        return await Permission.storage.request();
      case CustomPermission.microphone:
        return await Permission.microphone.request();
    }
  }
}
