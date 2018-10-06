library env_vars;

import 'dart:async';
import 'package:package_info/package_info.dart';

/// Container for usefull env vars
class EnvVars {
  /// `true` if in dev mode, `false` otherwise
  static bool get isDev {
    bool isDev = false;

    assert(() {
      isDev = true;
      return true;
    }());

    return isDev;
  }

  static Future<PackageInfo> _packageInfo = PackageInfo.fromPlatform();

  /// Returns [appName]
  static Future<String> get appName async {
    final info = await _packageInfo;
    return info.appName;
  }

  /// Returns app [buildNumber]
  static Future<String> get buildNumber async {
    final info = await _packageInfo;
    return info.buildNumber;
  }

  /// Returns [packageName]
  static Future<String> get packageName async {
    final info = await _packageInfo;
    return info.packageName;
  }

  /// Returns app [version]
  static Future<String> get version async {
    final info = await _packageInfo;
    return info.version;
  }

  static Map<String, dynamic> _vars = {};

  /// Sets some user-defined env var
  static set(String key, dynamic value) {
    _vars[key] = value;
  }

  /// Returns user-defined env var
  static get(String key) {
    return _vars[key];
  }
}
