import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Akun'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Added
                  children: [
                    Image.asset(
                      "assets/avatar.png",
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
              const EditItem(
                title: "Name",
                widget: TextField(),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Gender",
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Added
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Added
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              gender = "man";
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: gender == "man"
                                ? Colors.deepPurple
                                : Colors.grey.shade200,
                            fixedSize: const Size(50, 50),
                          ),
                          icon: const Icon(
                            Ionicons.male,
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Added
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              gender = "woman";
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: gender == "woman"
                                ? Colors.deepPurple
                                : Colors.grey.shade200,
                            fixedSize: const Size(50, 50),
                          ),
                          icon: const Icon(
                            Ionicons.female,
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Perempuan",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Age",
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final String title;
  final Widget widget;

  const EditItem({Key? key, required this.title, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center, // Added
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        widget,
      ],
    );
  }
}
