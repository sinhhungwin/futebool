class User {
  String city;
  double latitude;
  double longitude;
  List<String> imageUrls;
  String name;
  String bio;
  String email;

  User(
      {required this.city,
      required this.latitude,
      required this.longitude,
      required this.imageUrls,
      required this.name,
      required this.bio,
      required this.email});

  User.blank()
      : city = '',
        latitude = 0,
        longitude = 0,
        imageUrls = [''],
        name = '',
        bio = 'bio',
        email = '';

  User.fromJSON(data)
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

  static List<User> users = [
    User(
      email: 'foo3@gmail.com',
      name: 'Alex',
      bio: 'Lorem Ipsum',
      imageUrls: [
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
      ],
      latitude: 0,
      longitude: 0,
      city: "Hanoi",
    ),
    User(
      email: 'foo3@gmail.com',
      name: 'Alex',
      bio: 'Lorem Ipsum',
      imageUrls: [
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
      ],
      latitude: 0,
      longitude: 0,
      city: "Hanoi",
    ),
    User(
      email: 'foo3@gmail.com',
      name: 'Alex',
      bio: 'Lorem Ipsum',
      imageUrls: [
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
      ],
      latitude: 0,
      longitude: 0,
      city: "Hanoi",
    ),
    User(
      email: 'foo3@gmail.com',
      name: 'Alex',
      bio: 'Lorem Ipsum',
      imageUrls: [
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
        'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
      ],
      latitude: 0,
      longitude: 0,
      city: "Hanoi",
    ),
  ];
}
