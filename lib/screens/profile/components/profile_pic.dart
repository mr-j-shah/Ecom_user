import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    required this.image,
    Key? key,
  }) : super(key: key);
  String image;
  String im2 = 'assets/images/imagex.png';

  @override
  Widget build(BuildContext context) {
    print(image);
    im2 = image;
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          ClipOval(
              child: SizedBox.fromSize(
            size: Size.fromRadius(20),
            child: Image.network(
              image,
            ),
          )),
          /*StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc('+918000086931')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong.');
                }
                var data = snapshot.data;
                String s = data['image'];
                return CircleAvatar(
                  backgroundImage: ,
                );
              }),*/
          //,
          Positioned(
            right: -10,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  },
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg")),
            ),
          )
        ],
      ),
    );
  }
}

Widget bottomSheet() {
  return Container(
    height: 100,
    width: 300,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: [
        Text(
          "Choose Profile Photo",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.settings),
              label: Text("Gallery"),
            ),
          ],
        )
      ],
    ),
  );
}
