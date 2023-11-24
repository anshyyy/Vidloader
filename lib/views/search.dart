import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 20),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 0,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: const SizedBox(
                height: 50,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Paste Your URL....",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {},
                    color: const Color(0xff014bf4),
                    child: const Center(
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
