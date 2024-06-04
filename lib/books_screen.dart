
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_books_store/search_model.dart';
import 'package:it_books_store/view_book_deatels.dart';

import 'api_calling.dart';



class SearchbarScreen extends StatefulWidget {
  const SearchbarScreen({Key? key}) : super(key: key);

  @override
  _SearchbarScreenState createState() => _SearchbarScreenState();
}

class _SearchbarScreenState extends State<SearchbarScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<SearchModal> _futuresearch;

  @override
  void initState() {
    super.initState();
    _futuresearch = _searchBooks("MooTools");
  }

  Future<SearchModal> _searchBooks(String query) async {
    return BooksApi().getDatabar(query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _futuresearch = value.isNotEmpty
                      ? BooksApi().getDatabar(value)
                      : Future.value(); // Empty data if search is empty
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: Colors.black12,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<SearchModal>(
                future: _futuresearch,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  else {
                    var data = snapshot.data?.books;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap:() {


                            Navigator.push(context, MaterialPageRoute(builder: (context) =>BookDetails( image: "${data?[index].image}",title: "${data?[index].title}", subtitle: "${data?[index].subtitle}", isbn13: "${data?[index].isbn13}",),));


                          } ,
                          child: Card(
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage("${data?[index].image}"),
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                ),
                                title: Text("${data?[index].title}"),
                                subtitle:Column(
                                  children: [
                                    Text("${data?[index].subtitle}"),
                                    Text("${data?[index].url}"),
                                  ],
                                )





                              // You can add more details here
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}