/*
 * Last Updated: February 2024
 * User model definition
 * Defines the structure for user data
 */

class myUser {
  final String name;
  final String username;
  final String phone;
  final String imageUrl;
  final String Role;
  final String uid;

  myUser(
      {required this.name,
      required this.username,
      required this.phone,
      this.imageUrl = "",
      this.Role = "",
      this.uid = " "});
}
