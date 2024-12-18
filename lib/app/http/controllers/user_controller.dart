import 'package:project/app/models/user.dart';
import 'package:vania/vania.dart';

class UserController extends Controller {
  Future<Response> index() async {
    Map? user = Auth().user();
    if (user != null) {
      user.remove('password');
      return Response.json({
        'status': 'suksesssss',
        'message': 'Data user berhasil diambil',
        'data': user,
      });
    } else {
      return Response.json({
        'status': 'error',
        'message': 'user tidak terautentikasi',
      }, 401);
    }
  }

  Future<Response> update_password(Request request) async {
    request.validate({
      'current_password': 'required',
      'new_password': 'required|min_length:8|confirmed'
    }, {
      'current_password.required': 'password sekarang wajib diisi',
      'new_password.required': 'password baru wajib diisi',
      'new_password.min_length': 'password harus berisi minimal 8 karakter',
      'new_password.confirmed': 'konfirmasi password tidak cocok',
    });

    String currentPassword = request.string('current_password');

    Map? user = Auth().user();

    if (user != null) {
      if (Hash().verify(currentPassword, user['new_password'])) {
        await User().query().where('id', '=', Auth().id()).update({
          'new_password': Hash().make(request.string('new_password')),
        });
        return Response.json({
          'status': 'suksess',
          'message': 'Password berhasil diupdate',
        });
      } else {
        return Response.json({
          'status': 'error',
          'message': 'password saat ini tidak cocok',
        }, 401);
      }
    } else {
      return Response.json({
        'status': 'error',
        'message': 'user tidak ditemukan',
      }, 404);
    }
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final UserController userController = UserController();
