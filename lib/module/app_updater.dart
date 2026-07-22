import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

/// Handles Google Play in-app updates.
///
/// Behaviour:
///  * A high-priority release (Play "in-app update priority" >= [forcedPriority])
///    is treated as MANDATORY — the user must update to continue. They are shown
///    Play's immediate (full-screen) update flow, re-prompted with a blocking
///    dialog if they back out, so the app can't be used on the old version.
///  * Any other available update is OPTIONAL — a themed dialog offers "Later"
///    (skip) or "Update". Optional updates download in the background (flexible
///    flow) and install on the next idle moment.
///
/// Set the priority per release when you roll it out via the Google Play
/// Developer API (`inAppUpdatePriority`, 0–5). Default is 0 (optional).
///
/// Note: in-app updates only work on Android, on a build installed from Google
/// Play (Internal testing track or production). They do nothing in debug,
/// sideloaded, web or iOS builds.
class AppUpdater {
  /// Releases at or above this Play update priority are forced.
  static const int forcedPriority = 4;

  static bool _checked = false;

  /// Call once after the first frame (e.g. from the home screen's initState).
  static Future<void> checkForUpdate(BuildContext context) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    if (_checked) return;
    _checked = true;

    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return;
      }

      final bool forced = info.updatePriority >= forcedPriority;

      if (forced) {
        await _runForced(context, info);
        return;
      }

      // Optional update — ask first.
      if (!context.mounted) return;
      final proceed = await _showUpdateDialog(context, forced: false);
      if (proceed != true) return;

      if (info.flexibleUpdateAllowed) {
        final result = await InAppUpdate.startFlexibleUpdate();
        if (result == AppUpdateResult.success) {
          await InAppUpdate.completeFlexibleUpdate();
        }
      } else if (info.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e, s) {
      debugPrint('AppUpdater error: $e\n$s');
    }
  }

  /// Mandatory update — keep the user on the update path until it is done.
  static Future<void> _runForced(
      BuildContext context, AppUpdateInfo info) async {
    while (true) {
      try {
        if (info.immediateUpdateAllowed) {
          final res = await InAppUpdate.performImmediateUpdate();
          if (res == AppUpdateResult.success) return; // app restarts
        }
      } catch (e) {
        debugPrint('AppUpdater immediate failed: $e');
      }

      // User backed out (or immediate not available). Block with a
      // non-dismissible dialog and let them retry or exit.
      if (!context.mounted) return;
      final retry = await _showUpdateDialog(context, forced: true);
      if (retry != true) {
        // "Exit" chosen — close the app rather than run the old version.
        await SystemNavigator.pop();
        return;
      }
    }
  }

  static Future<bool?> _showUpdateDialog(
    BuildContext context, {
    required bool forced,
  }) {
    const green = Color(0xFF074425);
    const greenLight = Color(0xFF096637);
    const amber = Color(0xFFFFC107);

    return showDialog<bool>(
      context: context,
      barrierDismissible: !forced,
      builder: (ctx) => PopScope(
        canPop: !forced,
        child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [greenLight, green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.system_update_rounded,
                      color: Colors.white, size: 34),
                ),
                const SizedBox(height: 16),
                Text(
                  forced ? 'Update Required' : 'Update Available',
                  style: const TextStyle(
                    color: green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  forced
                      ? 'A new version of Ervadi Mawlid is required to continue. Please update to keep using the app.'
                      : 'A new version of Ervadi Mawlid is available with improvements and new features.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          foregroundColor:
                              forced ? Colors.red.shade400 : green,
                        ),
                        child: Text(
                          forced ? 'Exit' : 'Later',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: forced ? 2 : 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [greenLight, green],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Update Now',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: amber),
                          ),
                        ),
                      ),
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
