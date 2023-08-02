
class User {
  late String name;
  late String imageUrl;
  late bool isOnline;

  User({required this.name, required this.imageUrl, required this.isOnline});
}

final User currentUser = User(
  name: "Moses gideon", imageUrl: "asset", isOnline: true,);
final User user = User(
  name: " gideon", imageUrl: "asset",  isOnline: true,);
final User user1 = User(
  name: "Moses ", imageUrl: "asset",  isOnline: true,);
final User user2 = User(
  name: "Mosesgideon", imageUrl: "asset", isOnline: true,);
final User user3 = User(
  name: "kane", imageUrl: "asset",isOnline: true,);
final User user4 = User(
  name: "kante", imageUrl: "asset", isOnline: true,);