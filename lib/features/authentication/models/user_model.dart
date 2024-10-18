import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  // String firstName;
  // String lastName;
  String userName;
  final String email;
  String phoneNumber;
  String address;
  String storeName;
  String profilePicture;
  final String status;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    // required this.firstName,
    // required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.storeName,
    required this.profilePicture,
    required this.status,
  });
  // String get fullName => '$firstName $lastName';

  static List<String> nameParts(fullname) => fullname.split(' ');

  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(' ');
    String firstName = nameParts[0];
    String lastName = nameParts.length > 1 ? nameParts[1] : '';

    return '$firstName$lastName';
  }

  static UserModel empty() => UserModel(
        id: '',
        userName: '',
        email: '',
        // firstName: '',
        // lastName: '',
        phoneNumber: '',
        profilePicture: '',
        storeName: '',
        address: '',
        status: '',
      );

  Map<String, dynamic> toJson() {
    return {
      // 'FirstName': firstName,
      // 'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'StoreName': storeName,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Address': address,
      'Status': status,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        // firstName: data['FirstName'] ?? '',
        // lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        address: data['Address'] ?? '',
        storeName: data['StoreName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        status: data['Status'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
