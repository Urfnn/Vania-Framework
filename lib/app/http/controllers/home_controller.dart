import 'package:project/app/models/customers.dart';
import 'package:vania/vania.dart';

class HomeController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello Home'});
  }

  Future<Response> create(Request request) async {
    request.validate({
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
      'cust_telp': 'required',
    }, {
      'cust_name.required': 'isikan nama',
      'cust_address.required': 'isikan address',
      'cust_city.required': 'isikan city',
      'cust_state.required': 'isikan state',
      'cust_zip.required': 'isikan zip',
      'cust_country.required': 'isikan country',
      'cust_telp.required': 'isikan telp',
    });

    final reqData = request.input();
    reqData['created_at'] = DateTime.now().toIso8601String();

    final existingCust = await Customers()
        .query()
        .where('cust_name', '=', reqData['cust_name'])
        .first();
    if (existingCust != null) {
      return Response.json(
        {
          'message': 'Data Sudah Ada',
        },
        409,
      );
    }
    await Customers().query().insert(reqData);
    return Response.json({
      "message": 'Data Customers Berhasil Ditambahkan',
      "data": reqData,
    }, 201);
  }

  Future<Response> show() async {
    final cust = await Customers().query().get();
    if (cust.isEmpty) {
      return Response.json({
        "message": 'Data Customers Kosong',
        "data": [],
      }, 404);
    }
    return Response.json({
      "message": 'Menampilkan Data Customers',
      "data": cust,
    }, 200);
  }

  Future<Response> update(Request request, dynamic id) async {
    request.validate({
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
      'cust_telp': 'required',
    }, {
      'cust_name.required': 'isikan nama',
      'cust_address.required': 'isikan address',
      'cust_city.required': 'isikan city',
      'cust_state.required': 'isikan state',
      'cust_zip.required': 'isikan zip',
      'cust_country.required': 'isikan country',
      'cust_telp.required': 'isikan telp',
    });

    final reqData = request.input();
    await Customers().query().where('cust_id', id.toString()).update({
      'cust_name': reqData['cust_name'],
      'cust_address': reqData['cust_address'],
      'cust_city': reqData['cust_city'],
      'cust_state': reqData['cust_state'],
      'cust_zip': reqData['cust_zip'],
      'cust_country': reqData['cust_country'],
      'cust_telp': reqData['cust_telp'],
    });
    reqData['updated_at'] = DateTime.now().toIso8601String();

    return Response.json({
      "message": "Data Customer Berhasil Diperbarui !",
      "data": reqData,
    }, 200);
  }

  Future<Response> destroy(dynamic id) async {
    final selectedRow =
        await Customers().query().where('cust_id', '=', id.toString()).first();
    if (selectedRow == null) {
      return Response.json({
        "message": "Data Customers Tidak Ditemukan",
      }, 404);
    }
    await Customers().query().where('cust_id', '=', id.toString()).delete();
    return Response.json({
      "message": "Data Customers Berhasil Dihapus",
    }, 200);
  }
}

final HomeController homeController = HomeController();
