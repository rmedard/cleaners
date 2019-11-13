import 'package:cleaners/models/service.dart';

class ServiceMapper {
  Service map(Map<String, dynamic> service) {
    return Service(
        id: service['id'],
        name: service['name'],
        description: service['description'],
        categoryId: service['category_id']);
  }
}
