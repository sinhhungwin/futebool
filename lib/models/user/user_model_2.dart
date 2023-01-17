class User2 {
  String city;
  double latitude;
  double longitude;
  List<String> imageUrls;
  String name;
  String bio;
  String email;

  User2(
      {required this.city,
      required this.latitude,
      required this.longitude,
      required this.imageUrls,
      required this.name,
      required this.bio,
      required this.email});

  User2.blank()
      : city = '',
        latitude = 0,
        longitude = 0,
        imageUrls = [''],
        name = '',
        bio = 'bio',
        email = '';

  User2.fromJSON(data)
      : city = data['city'],
        latitude = data['latitude'],
        longitude = data['longitude'],
        imageUrls = List<String>.from(data['imageUrls']),
        name = data['name'],
        bio = data['bio'],
        email = data['email'];

  @override
  String toString() {
    return "User: $email - $name - $bio - $city";
  }
}
