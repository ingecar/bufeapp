import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'dart:ui';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  Future<void> _launched;
  String _phone = '3012377791';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No es posible abrir $url';
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildMenuBtn() {
    return Column(
      children: [
        _buildroundedBtn(Colors.white, Icons.restaurant, 'Nuestro Menú',
            'https://bufe.com.co/nuestro-menu'),
        _buildroundedBtn(Colors.white, Icons.restaurant_menu, 'Arma tu Plato',
            'https://bufe.com.co/personalizado'),
      ],
    );
  }

  Widget _buildroundedBtn(
      Color color, IconData icono, String texto, String url) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: InkWell(
          onTap: () => _launchInBrowser(url), // handle your onTap here
          child: Container(
            height: 180.0,
            width: 180.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 60.0,
                  child: Icon(icono, color: Colors.lightGreen, size: 60.0),
                ),
                Text(texto,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.lightGreen,
      centerTitle: true,
      title: Text('Bufé'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.account_circle,
          ),
          onPressed: () {
            _launchInBrowser('https://bufe.com.co/customer/login');
          },
        ),
      ],
    );
  }

  Widget _buildrawer() {
    return Drawer(
      elevation: 1.5,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: AssetImage('assets/logos/BufeDrawer.png'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.green[300],
                ),
                title: Text('Regístrate'),
                onTap: () {
                  _launchInBrowser('https://bufe.com.co/customer/registration');
                },
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.lightGreen,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone_in_talk,
                  color: Colors.green[300],
                ),
                title: Text('Llámanos'),
                onTap: () {
                  _launched = _makePhoneCall('tel:$_phone');
                },
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.lightGreen,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.mail,
                  color: Colors.green[300],
                ),
                title: Text('Escríbenos'),
                onTap: () {
                  _launchInBrowser('https://bufe.com.co/contact');
                },
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.lightGreen,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.black54,
                ),
                title: Text('Preguntas frecuentes'),
                onTap: () {
                  _launchInBrowser('https://bufe.com.co/preguntas-frecuentes');
                },
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.lightGreen,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.black54,
                ),
                title: Text('Política de privacidad'),
                onTap: () {
                  _launchInBrowser(
                      'https://bufe.com.co/politica-de-privacidad');
                },
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.lightGreen,
                ),
              ),
            ],
          )),
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 0.1,
          ),
          _buildSocialBtnRow(),
          Container(
              padding: EdgeInsets.all(10),
              height: 45,
              child: Text(
                "Versión 1.0.2",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () =>
                _launchInBrowser('https://www.instagram.com/buferestaurante/'),
            AssetImage(
              'assets/logos/instagram.png',
            ),
          ),
          _buildSocialBtn(
            () =>
                FlutterOpenWhatsapp.sendSingleMessage("+573012377791", "Hola"),
            AssetImage(
              'assets/logos/whatsApp.png',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen[400],
      backgroundColor: Colors.white,
      appBar: _buildAppbar(),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                _buildMenuBtn(),
              ],
            ),
          ),
        ],
      ),
      drawer: _buildrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('PAGAR'),
        backgroundColor: Colors.lightGreen,
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          _launchInBrowser('https://bufe.com.co/cart');
        },
      ),
    );
  }
}
