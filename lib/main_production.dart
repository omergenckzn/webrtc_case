
import 'package:dating_app/flavors.dart';
import 'package:dating_app/main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.production;
  await runner.main();

}
