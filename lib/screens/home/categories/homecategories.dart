import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../product.dart';
import '../../../size_config.dart';

class editlist extends StatefulWidget {
  editlist({Key? key, required this.value}) : super(key: key);
  String value;
  @override
  State<editlist> createState() => _editlistState();
}

class _editlistState extends State<editlist> {
  List<product> list = [];
  List<product> searchresult = [];
  bool isLoading = true;
  bool isError = false;
  String search = '';
  @override
  void initState() {
    getdata().then((value) {
      setState(() {
        list = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      // ignore: avoid_print
      print(error);
      print(stackTrace);
      setState(() {
        isError = true;
      });
      throw error!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        primary: kPrimaryColor,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/Back ICon.svg",
                        height: 15,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  )
                ],
              ),
            ),
          )),
      body: isLoading
          // ignore: prefer_const_constructors
          ? Center(
              child: const CircularProgressIndicator(color: Color(0xFFFF7643)),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF979797).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      // showCursor: false,

                      onChanged: ((value) {
                        setState(() {
                          print(value);
                          print(searchresult.length);
                          search = value;
                          searchOperation(search);
                        });
                      }),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search product",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: searchresult.isEmpty || search.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                color: Colors.white70,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailsScreen.routeName,
                                        arguments: list[index]);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    150),
                                            width: getProportionateScreenWidth(
                                                150),
                                            child: Image.network(
                                              list[index].imagelink.toString(),
                                              semanticLabel:
                                                  list[index].name.toString(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            width: getProportionateScreenWidth(
                                                150),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  list[index].name.toString(),
                                                  overflow: TextOverflow.clip,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              25)),
                                                ),
                                                Text(
                                                  list[index].price.toString() +
                                                      " INR",
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            20),
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchresult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                color: Colors.white70,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailsScreen.routeName,
                                        arguments: searchresult[index]);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    150),
                                            width: getProportionateScreenWidth(
                                                150),
                                            child: Image.network(
                                              searchresult[index]
                                                  .imagelink
                                                  .toString(),
                                              semanticLabel: searchresult[index]
                                                  .name
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            width: getProportionateScreenWidth(
                                                150),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  searchresult[index]
                                                      .name
                                                      .toString(),
                                                  overflow: TextOverflow.clip,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              25)),
                                                ),
                                                Text(
                                                  searchresult[index]
                                                          .price
                                                          .toString() +
                                                      " INR",
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            20),
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (searchText != null) {
      for (var i = 0; i < list.length; i++) {
        product data = list[i];
        if (data.name!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }

  Future<List<product>> getdata() async {
    List<product> pro = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.value.toString())
        .collection('Products')
        .get();
    for (final doc in snapshot.docs) {
      pro.add(product.fromDocument(doc, widget.value.toString()));
    }
    return pro;
  }
}
