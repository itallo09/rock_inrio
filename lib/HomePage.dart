import 'package:flutter/material.dart';
import 'package:rock_inrio/atracao_page.dart';
import 'package:rock_inrio/lista_atracoes.dart';
import 'package:rock_inrio/LoginPage.dart';
import 'package:rock_inrio/AboutPage.dart';
import 'package:rock_inrio/ChatPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Atracao> _listaFavoritos = [];
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    LoginPage(), // Página de Login
    ChatPage(), // Página de Chat
    AboutPage(), // Página "Sobre"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navegar para a página correspondente ao índice clicado
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atrações',
          style: TextStyle(
            color: Color.fromARGB(255, 250, 250, 250),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(219, 0, 0, 0),
        actions: [
          Image.asset(
            'assets/image1.png',
            height: 50,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listaAtracoes.length,
        itemBuilder: (context, index) {
          final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
          return ListTile(
            title: Text(listaAtracoes[index].nome),
            subtitle: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: listaAtracoes[index]
                  .tags
                  .map((tag) => Chip(label: Text('#$tag')))
                  .toList(),
            ),
            leading: CircleAvatar(
              child: Text('${listaAtracoes[index].nome[0]}'),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorito) {
                    _listaFavoritos.remove(listaAtracoes[index]);
                  } else {
                    _listaFavoritos.add(listaAtracoes[index]);
                  }
                });
              },
              icon: Icon(
                isFavorito ? Icons.favorite : Icons.favorite_border,
                color: isFavorito ? Colors.red : null,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AtracaoPage(atracao: listaAtracoes[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(219, 0, 0, 0),
        unselectedItemColor:
            Colors.white, // Define a cor dos ícones não selecionados
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
