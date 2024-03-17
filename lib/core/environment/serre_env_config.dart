import 'base_env_config.dart';

/// SerrE environment-specific configurations.
///
/// Extends [BaseEnvConfig] and provides the environment values specific
/// to the SerrE environment.
class SerrEEnvConfig extends BaseEnvConfig {
  @override
  String get baseUrl => '/';
}
