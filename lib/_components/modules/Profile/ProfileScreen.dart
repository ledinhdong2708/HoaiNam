import 'dart:io';

import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/User/UserService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../_services/Notification/NotificationService.dart';
import '../../shared/UrlAPI/API_General.dart';
import '../../shared/utils/snackbar_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum SampleItem { itemOne, itemTwo }

class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  User(
      {required this.imagePath,
      required this.name,
      required this.email,
      required this.about,
      required this.isDarkMode});
}

class UserPreferences {}

class _ProfileScreenState extends State<ProfileScreen> {
  NotificationService _notificationService = NotificationService();
  var user = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );

  List items = [];
  TextEditingController emailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  String TitleUserName = "";

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  bool changePassword = false;

  var avatarImage;
  SampleItem? selectedMenu;
  final _auth = AuthService();

  File? imageFile;
  void initState() {
    super.initState();
    FetchUser();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
          // leading: BackButton(),
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          // actions: [
          //   // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.moon_stars))
          //   IconButton(onPressed: updateData, icon: Icon(CupertinoIcons.pen))
          // ],
          ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: imageFile == null
                        ? (avatarImage != null
                            ? Ink.image(
                                image:
                                    NetworkImage("${SERVER_IP}${avatarImage}"),
                                fit: BoxFit.cover,
                                width: 128,
                                height: 128,
                                child: InkWell(onTap: () {}),
                              )
                            : Ink.image(
                                image: AssetImage("images/15.png"),
                                fit: BoxFit.cover,
                                width: 128,
                                height: 128,
                                child: InkWell(onTap: () {}),
                              ))
                        : Ink.image(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                            child: InkWell(onTap: () {})),
                  ),
                ),
                // Center(
                //   child: Container(
                //     height: 150,
                //     width: 200,
                //     // Image.asset("images/logo_upload.jpg")
                //     child: imageFile == null
                //         ? (avatarImage != null
                //             ? Image.network("${SERVER_IP}/${avatarImage}")
                //             : Image.asset("images/15.png"))
                //         : Image.file(imageFile!),
                //     //child: Image.asset("images/logo_upload.jpg"),
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildEditIcon(color),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              TitleUserName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          const SizedBox(height: 24),
          // Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // First name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Họ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: firstController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Last Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: lastController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Điện thoại',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // City
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thành phố',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Address
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Địa chỉ 1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 5,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Address2
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Địa chỉ 2',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: address2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 5,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đổi mật khẩu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: changePassword,
                    onChanged: (newValue) {
                      setState(() {
                        changePassword = newValue!;
                      });
                    },
                  ),
                  Text('Đổi mật khẩu'),
                ],
              ),
            ],
          ),
          // Password fields
          if (changePassword) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password hiện tại',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password mới',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordNewController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập lại Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: ConfirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          // Button
          Container(
            child: FloatingActionButton.extended(
              onPressed: () {
                updateData();
              },
              icon: Icon(Icons.save),
              label: Text(
                'Cập Nhập',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
            color: color,
            all: 0,
            child: PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                onSelected: (SampleItem item) {
                  setState(() {
                    selectedMenu = item;
                    if (item == SampleItem.itemOne) {
                      imageFromGallery();
                    } else if (item == SampleItem.itemTwo) {
                      imageFromCamera();
                    }
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.itemOne,
                        child: Text('Thư viện'),
                      ),
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.itemTwo,
                        child: Text('Máy ảnh'),
                      ),
                    ])
            // Icon(
            //   // isEdit ? Icons.add_a_photo : Icons.edit,
            //   Icons.edit,
            //   color: Colors.white,
            //   size: 20,
            // ),
            ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Future<void> FetchUser() async {
    // List<String> items = [];
    final response = await UserService.FetchUserById();
    if (response != null) {
      // items = response;
      emailController.text = response["email"];
      firstController.text = response["firstName"];
      lastController.text = response["lastName"];
      phoneController.text = response["phone"];
      cityController.text = response["city"];
      addressController.text = response["address"];
      address2Controller.text = response["address2"];
      setState(() {
        TitleUserName = response["username"];
        print(response["avatar"]);
        avatarImage = response["avatar"] == null || response["avatar"] == ""
            ? null
            : response["avatar"];
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

  Future<void> updateData() async {
    final isSuccess = await UserService.updateData(body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
      _auth.changePassword(passwordNewController.text);
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    return {
      "email": emailController.text,
      "firstName": firstController.text,
      "lastName": lastController.text,
      "phone": phoneController.text,
      "city": cityController.text,
      "address": addressController.text,
      "address2": address2Controller.text,
      "createDate": "",
      "password": passwordController.text,
      "passwordNew": passwordNewController.text,
      "ConfirmPassword": ConfirmPasswordController.text
    };
  }

  imageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        updateImage();
      });
    }
  }

  imageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        updateImage();
      });
    }
  }

  Future<void> updateImage() async {
    ;
    // final isCompleted = todo['is_completed'];
    final isSuccess = await UserService.updateImage(imageFile!);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }
}
