import 'package:flutter/material.dart';

class NewSearchBar extends StatelessWidget {
  final List<String> suggestions;
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const NewSearchBar({
    Key? key,
    required this.suggestions,
    required this.controller,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Color.fromARGB(255, 205, 203, 203),
              suffixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF558190)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF558190)),
              ),
            ),
          ),
        ),
        suggestions.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]),
                    onTap: () {
                      controller.text = suggestions[index];
                      // Pode adicionar mais lógica aqui conforme necessário
                    },
                  );
                },
              ),
      ],
    );
  }
}
