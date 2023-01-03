import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final String bio;
  final String jobTitle;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.imageUrls,
      required this.bio,
      required this.jobTitle});

  @override
  List<Object?> get props => [id, name, age, imageUrls, bio, jobTitle];

  static List<User> users = [
    const User(
        id: 1,
        name: 'Kendall Jenner',
        age: 22,
        imageUrls: [
          'https://www.instyle.com/thmb/EXD6z0VCBGtywyx-JYYcP48sBLs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/kendall-jenner-lacma-2022-df1fab9845624370a528ccbd6661a204.jpg',
          'https://media.allure.com/photos/621e32e93c1316abf45cb59b/1:1/w_2911,h_2911,c_limit/kendall%20jenner%20.jpg',
          'https://hips.hearstapps.com/hmg-prod/images/kendall-jenner-is-seen-in-tribeca-on-september-19-2022-in-news-photo-1663686616.jpg'
        ],
        bio: 'Instagram Model Bio',
        jobTitle: 'Instagram Model Job Title'),
    const User(
        id: 2,
        name: 'Khả Ngân',
        age: 22,
        imageUrls: [
          'https://spartabeerclub.vn/media/images/article/543/kha-ngan-la-ai-tieu-su-su-nghiep-dien-vien-kha-ngan_1.jpg',
          'https://2sao.vietnamnetjsc.vn/images/2021/11/21/19/49/kha-ngan-2.jpg',
          'https://vnn-imgs-f.vgcloud.vn/2022/02/02/09/kha-ngan-diu-dang-ben-ta-ao-dai-thanh-son-gui-loi-chuc-voi-xung-ho-dac-biet-8.jpg'
        ],
        bio: 'Actress Bio',
        jobTitle: 'Actress Job Title'),
    const User(
        id: 3,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 4,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 5,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 6,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 7,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 8,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
    const User(
        id: 9,
        name: 'Ceri',
        age: 20,
        imageUrls: [
          'https://kenh14cdn.com/thumb_w/600/203336854389633024/2022/5/28/photo1653721216403-1653721216623132573170.jpg',
          'https://nguoinoitieng.tv/images/nnt/104/0/bhh9.jpg',
          'https://danviet.mediacdn.vn/296231569849192448/2022/5/27/hot-girl-nguoi-tay-ceri-3-1653617750291627713801.jpg'
        ],
        bio: 'Hot Girl Bio',
        jobTitle: 'Hot Girl Job Title'),
  ];
}
