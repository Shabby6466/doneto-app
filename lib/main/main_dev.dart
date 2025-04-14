// coverage: false
// coverage:ignore-file

// ENTRY POINT OF PROD APP
import 'package:doneto/main/main_core.dart';

void main() async {
  initMainCore(enviormentPath: 'env/.env_dev');
}
