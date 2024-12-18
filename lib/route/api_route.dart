import 'package:project/app/http/controllers/auth_controller.dart';
import 'package:vania/vania.dart';
import 'package:project/app/http/controllers/home_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.group(() {
      Router.get("/home", homeController.index);
      Router.get("/get", homeController.show);
      Router.post("/create", homeController.create);
      Router.put("/update/{id}", homeController.update);
      Router.delete("/delete/{id}", homeController.destroy);
    }, prefix: 'crud');

    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
      Router.post('logout', authController.logout);
    }, prefix: 'auth');
  }
}
