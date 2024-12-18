import 'package:project/app/models/todo.dart';
import 'package:vania/vania.dart';

class TodoController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'title': 'required',
      'description': 'required',
    }, {
      'title.required': 'judul todo wajib diisi',
      'description.required': 'deskripsi wajib diisi',
    });

    Map<String, dynamic> data = request.all();
    Map<String, dynamic>? user = Auth().user();

    if (user != null) {
      var todo = await Todo().query().create({
        'user_id': Auth().id(),
        'title': data['title'],
        'description': data['desription'],
      });
      return Response.json({
        'status': 'suksess',
        'message': 'todo berhasil',
        'data': todo,
      }, 201);
    } else {
      return Response.json({
        'status': 'error',
        'message': 'user tidak terautentikasi',
      }, 401);
    }
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

final TodoController todoController = TodoController();
