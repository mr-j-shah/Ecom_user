import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/screens/loginscreen/wait.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../constants.dart';
import '../Authentication/Firestore.dart';
import '../Splashscreen/body.dart/splashbody.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class signup extends StatefulWidget {
  signup({Key? key, required this.num}) : super(key: key);
  String num = "";
  @override
  State<signup> createState() => _signupState();
}

bool isLoading = false;

class _signupState extends State<signup> {
  UploadTask? task;
  File? file;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _addressController =
      TextEditingController(text: "");
  String Name = "";
  String Address = "";
  String downloadlink = "";
  bool validateForm() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState?.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Form(
      key: _formkey,
      autovalidateMode: _autovalidateMode,
      child: isLoading
          // ignore: prefer_const_constructors
          ? Center(
              child: const CircularProgressIndicator(
                color: Colors.black38,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Verification Form',
                      // ignore: unnecessary_const
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            Name = val.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            Address = val.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    // ignore: prefer_const_constructors
                    child: Text(
                      '*You Have to upload \n\t1. Upload Udyog Adhaar 2. Upload ShopAct',
                      style: const TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        selectFile();
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Card(
                          color: Colors.white70,
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(Icons.attach_file),
                              ),
                              const VerticalDivider(
                                thickness: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Upload Files'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      fileName,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await uploadFile();
                    },
                    child: const Text('Upload'),
                  ),
                  const SizedBox(height: 5),
                  task != null ? buildUploadStatus(task!) : Container(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    // ignore: unnecessary_const
                    child: const Text(
                      '*You need to fill this verification form',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: DefaultButton(
                      text: 'Submit',
                      press: () async {
                        if (downloadlink != "") {
                          isLoading = true;
                          final GoogleSignInAccount? googleUser =
                              await GoogleSignIn().signIn();
                          AddUser(widget.num, Name, Address,
                              googleUser!.email.toString(), downloadlink);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => wait(
                                      num: widget.num,
                                      email: googleUser.email.toString(),
                                    )),
                          );
                          GoogleSignIn().signOut();
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'First Upload Image then Submit the Form'),
                              actions: [
                                OutlinedButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  AddUser(String num, String Name, String Address, String email,
      String userFile) async {
    await FirebaseFirestore.instance.collection('requestUser').doc(email).set({
      'Name': Name,
      'address': Address,
      'phone': num,
      'email': email,
      'image': userFile
    });
    isLoading = false;
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    downloadlink = urlDownload.toString();
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
