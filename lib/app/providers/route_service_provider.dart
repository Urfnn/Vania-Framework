import 'package:vania/vania.dart';
import 'package:project/route/api_route.dart';
import 'package:project/route/web.dart';
import 'package:project/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
