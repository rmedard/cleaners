import 'package:cleaners/models/professional.dart';

class ProfessionalMapper {
  Professional map(Map<String, dynamic> professionalData) {
    return Professional(
        id: professionalData['id'],
        firstName: professionalData['first_name'],
        lastName: professionalData['last_name'],
        price: professionalData['price']);
  }
}
