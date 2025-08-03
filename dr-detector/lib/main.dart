import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Defect Detection',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.lightBlue[50],
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(title: 'Eye Defect Detection'),
        '/history': (context) => HistoryScreen(),
        '/registration': (context) => RegistrationPage(),
        '/developers': (context) => DevelopersScreen(),
        '/contact': (context) => ContactsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}

class ImageResult {
  final String imagePath;
  final String defectType;
  final double confidenceScore;

  ImageResult({
    required this.imagePath,
    required this.defectType,
    required this.confidenceScore,
  });
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loginError = false;

  void _login() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Replace with actual authentication logic
    if (username == 'admin' && password == 'password') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _loginError = true;
      });
    }
  }

  void _goToRegistration() {
    Navigator.pushNamed(context, '/registration');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/eye_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/eye_logo.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.lightBlue,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          if (_loginError)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Invalid username or password',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          SizedBox(height: 16.0),
                          TextButton(
                            onPressed: _goToRegistration,
                            child: Text('Create New Account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String password;

  User(this.username, this.password);
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _registrationError = false;
  List<User> registeredUsers = [];

  void _register() {
    print('Register button pressed');
    // Replace this with your registration logic
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Mock registration check
    if (password == confirmPassword) {
      // Check if the username is already registered
      if (registeredUsers.any((user) => user.username == username)) {
        setState(() {
          _registrationError = true;
        });
      } else {
        // Register the user
        final newUser = User(username, password);
        registeredUsers.add(newUser);

        // Registration successful
        Navigator.pop(context); // Go back to login page
      }
    } else {
      setState(() {
        _registrationError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/eye_logo.png', // Replace with a relevant image
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue, // Changed color to lightBlue
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      if (_registrationError)
                        Text(
                          'Password and Confirm Password do not match',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  String? _prediction;
  bool _imageError = false;
  bool _isLoading = false;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageError = false;
      } else {
        _imageError = true;
      }
    });
  }

  void _processImage() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    final url =
        Uri.parse('http://10.0.2.2:5000/predict'); // Adjust IP if needed
    final request = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', _image!.path);
    request.files.add(file);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);
        setState(() {
          _prediction = jsonResponse['prediction'];
          _isLoading = false;
        });
      } else {
        print('Error from Flask API: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error sending request: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/eye_logo.png',
                    width: 150,
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Developers'),
              onTap: () {
                Navigator.pushNamed(context, '/developers');
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/eye_background2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'Upload an Image',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 20),
                              _image != null
                                  ? Container(
                                      width: 200,
                                      height: 200,
                                      child: Image.file(_image!),
                                    )
                                  : Placeholder(
                                      fallbackHeight: 200,
                                      fallbackWidth: 200,
                                    ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => _getImage(ImageSource.gallery),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                child: Text(
                                  'Pick from Gallery',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () => _getImage(ImageSource.camera),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                child: Text(
                                  'Take a Photo',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              if (_imageError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Error: Failed to load image',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed:
                                    _image != null ? _processImage : null,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical: 12.0,
                                  ),
                                ),
                                child: Text(
                                  'Process Image',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              if (_prediction != null)
                                Text(
                                  'Prediction: $_prediction',
                                  style: TextStyle(fontSize: 20),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final ImageResult imageResult;

  ResultScreen({required this.imageResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Defect Type: ${imageResult.defectType}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16.0),
            Text(
              'Confidence Score: ${imageResult.confidenceScore.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 200,
              height: 200,
              child: Image(
                image: kIsWeb
                    ? NetworkImage(imageResult.imagePath)
                    : FileImage(File(imageResult.imagePath))
                        as ImageProvider<Object>,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: Text('No history yet.'),
      ),
    );
  }
}

class DevelopersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developers'),
      ),
      body: ListView(
        children: [
          _buildCardWithTitle('Developers', Colors.lightBlue),
          _buildDeveloperCard(
            'Department of Software Engineering',
            'Zahid Muhammad',
          ),
          _buildDeveloperCard(
            'Department of Software Engineering',
            'Idrees Ahmad',
          )
        ],
      ),
    );
  }

  Widget _buildCardWithTitle(String title, Color backgroundColor) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(
    String department,
    String name,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              department,
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildContactItem(
              'Email: zksumr@gmail.com',
              Icons.email,
              onTap: () =>
                  _launchURL('mailto:zksumr@gmail.com'), // Use mailto for email
            ),
            SizedBox(height: 16.0),
            _buildContactItem(
              'Phone: +923105315857',
              Icons.phone,
              onTap: () => _launchURL('tel:+923105315857'),
            ),
            SizedBox(height: 16.0),
            _buildContactItem(
              'Website: example.com',
              Icons.web,
              onTap: () =>
                  _launchURL('https://example.com'), // Add your website URL
            ),
            SizedBox(height: 16.0),
            _buildContactItem(
              'LinkedIn',
              Icons.link,
              onTap: () => _launchURL(
                  'https://www.linkedin.com/your-profile'), // Add your LinkedIn URL
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String text, IconData iconData,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.blue,
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      await launch(url);
    } on PlatformException catch (e) {
      print('Error launching URL: $e');
    }
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              'Main Focus',
              'Identify 5 different diabetic retinopathy classes from retinal images',
              Icons.visibility,
              Colors.lightBlue, // Consistent color
            ),
            _buildCard(
              'Model Training',
              'Trained using TensorFlow and Keras.',
              Icons.code,
              Colors.lightBlue, // Consistent color
            ),
            _buildCard(
              'Software Used',
              'Jupyter notebook,VS Code, Android Studio and Flutter.',
              Icons.computer,
              Colors.lightBlue, // Consistent color
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, String description, IconData iconData, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          iconData,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        tileColor: color,
      ),
    );
  }
}















//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:math';
// import 'package:flutter/services.dart';
// import 'package:flutter/gestures.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Eye Defect Detection',
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//         scaffoldBackgroundColor:
//             Colors.lightBlue[50], // Set the background color of the scaffold
//       ),
//       home: LoginPage(),
//       routes: {
//         '/login': (context) => LoginPage(), // Route for the login page
//         '/home': (context) => MyHomePage(title: 'Eye Defect Detection'),
//         '/history': (context) => HistoryScreen(),
//         '/registration': (context) => RegistrationPage(),
//         '/developers': (context) => DevelopersScreen(),
//         '/Contact': (context) => ContactsScreen(),
//         '/about': (context) => AboutScreen(),
//       },
//     );
//   }
// }

// class ImageResult {
//   final String imagePath;
//   final String defectType;
//   final double confidenceScore;

//   ImageResult({
//     required this.imagePath,
//     required this.defectType,
//     required this.confidenceScore,
//   });
// }

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _loginError = false;

//   void _login() {
//     // Replace this with your authentication logic
//     final String username = _usernameController.text;
//     final String password = _passwordController.text;

//     if (username == 'admin' && password == 'password') {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         _loginError = true;
//       });
//     }
//   }

//   void _goToRegistration() {
//     Navigator.pushNamed(context, '/registration');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/eye.jpeg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset(
//                   'assets/icons/yuy.png',
//                   width: 100,
//                   height: 100,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.lightBlue,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: _login,
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.lightBlue,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 32.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                       if (_loginError)
//                         Text(
//                           'Invalid username or password',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       SizedBox(height: 16.0),
//                       TextButton(
//                         onPressed: _goToRegistration,
//                         child: Text('Create New Account'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final String username;
//   final String password;

//   User(this.username, this.password);
// }

// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   bool _registrationError = false;
//   List<User> registeredUsers = [];

//   void _register() {
//     print('Register button pressed');
//     // Replace this with your registration logic
//     final String username = _usernameController.text;
//     final String password = _passwordController.text;
//     final String confirmPassword = _confirmPasswordController.text;

//     // Mock registration check
//     if (password == confirmPassword) {
//       // Check if the username is already registered
//       if (registeredUsers.any((user) => user.username == username)) {
//         setState(() {
//           _registrationError = true;
//         });
//       } else {
//         // Register the user
//         final newUser = User(username, password);
//         registeredUsers.add(newUser);

//         // Registration successful
//         Navigator.pop(context); // Go back to login page
//       }
//     } else {
//       setState(() {
//         _registrationError = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.lightBlue[50],
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         'assets/icons/yuy.png',
//                         width: 100,
//                         height: 100,
//                       ),
//                       Text(
//                         'Registration',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       TextField(
//                         controller: _confirmPasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: 'Confirm Password',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: _register,
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 32.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         child: Text(
//                           'Register',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                       if (_registrationError)
//                         Text(
//                           'Password and Confirm Password do not match',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? _image;
//   bool _imageError = false;

//   Future<void> _getImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: source);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         _imageError = false;
//       } else {
//         _imageError = true;
//       }
//     });
//   }

//   void _processImage() {
//     if (_image != null) {
//       // Replace this with your image processing logic
//       final random = Random();
//       final defectTypes = [
//         'No Dr',
//         'Mild',
//         'Moderate',
//         'Severe',
//         'Proliferative'
//       ];
//       final defectType = defectTypes[random.nextInt(defectTypes.length)];
//       final confidenceScore = random.nextDouble();

//       final imageResult = ImageResult(
//         imagePath: _image!.path,
//         defectType: defectType,
//         confidenceScore: confidenceScore,
//       );

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ResultScreen(imageResult: imageResult)),
//       );
//     } else {
//       setState(() {
//         _imageError = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/pic.gif', // Replace with the path to your logo image
//                     width: 150,
//                     height: 80,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Menu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.history),
//               title: Text('History'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/history');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info),
//               title: Text('About'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/about');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.developer_mode),
//               title: Text('Developers'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/developers');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.contact_mail),
//               title: Text('Contact'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/Contact');
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () {
//                 Navigator.pushReplacementNamed(
//                     context, '/login'); // Navigate back to the login page
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         // color: Colors.lightBlue[50],
//         color: Colors.indigo,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.8),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Select an image',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () => _getImage(ImageSource.gallery),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 32.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         child: Text(
//                           'Pick from Gallery',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () => _getImage(ImageSource.camera),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 32.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         child: Text(
//                           'Take a Photo',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                       if (_imageError)
//                         Text(
//                           'Error: Failed to load image',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: _processImage,
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 32.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         child: Text(
//                           'Process Image',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   final ImageResult imageResult;

//   ResultScreen({required this.imageResult});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Result'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Defect Type: ${imageResult.defectType}',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Confidence Score: ${imageResult.confidenceScore.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16.0),
//             Container(
//               width: 200, // Specify your desired width
//               height: 200, // Specify your desired height
//               child: Image(
//                 image: kIsWeb
//                     ? NetworkImage(imageResult.imagePath)
//                     : FileImage(File(imageResult.imagePath))
//                         as ImageProvider<Object>,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HistoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('History'),
//       ),
//       body: Center(
//         child: Text('No history yet.'),
//       ),
//     );
//   }
// }

// class DevelopersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Developers'),
//       ),
//       body: ListView(
//         children: [
//           _buildCardWithTitle('Developers', Colors.lightBlue),
//           _buildDeveloperCard(
//             'Department of Software Engineering',
//             'Zahid Muhammad',
//           ),
//           _buildDeveloperCard(
//             'Department of Software Engineering',
//             'Idrees Ahmad',
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildCardWithTitle(String title, Color backgroundColor) {
//     return Card(
//       color: backgroundColor,
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: ListTile(
//         title: Text(
//           title,
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildDeveloperCard(
//     String department,
//     String name,
//   ) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: ListTile(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: TextStyle(fontSize: 18.0),
//             ),
//             Text(
//               department,
//               style: TextStyle(fontSize: 14.0),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ContactsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildContactItem(
//               'Email: zksumr@gmail.com',
//               Icons.email,
//               onTap: () => _launchURL('#'),
//             ),
//             SizedBox(height: 16.0),
//             _buildContactItem(
//               'Phone: +923105315857',
//               Icons.phone,
//               onTap: () => _launchURL('tel:++923105315857'),
//             ),
//             SizedBox(height: 16.0),
//             _buildContactItem(
//               'Website: example.com',
//               Icons.web,
//               onTap: () => _launchURL('#'),
//             ),
//             SizedBox(height: 16.0),
//             _buildContactItem(
//               'LinkedIn',
//               Icons.link,
//               onTap: () => _launchURL('#'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContactItem(String text, IconData iconData,
//       {VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             iconData,
//             color: Colors.blue,
//           ),
//           SizedBox(width: 8.0),
//           Text(
//             text,
//             style: TextStyle(fontSize: 18.0, color: Colors.blue),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _launchURL(String url) async {
//     try {
//       await launch(url);
//     } on PlatformException catch (e) {
//       print('Error launching URL: $e');
//     }
//   }
// }

// class AboutScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             _buildCard(
//               'Main Focus',
//               'Identify 5 different diabetic retinopathy classes from retinal images',
//               Icons.visibility,
//               Colors.white,
//             ),
//             _buildCard(
//               'Model Training',
//               'Trained using TensorFlow and Keras.',
//               Icons.code,
//               Colors.white,
//             ),
//             _buildCard(
//               'Software Used',
//               'Jupyter notebook,VS Code, Android Studio and Flutter.',
//               Icons.computer,
//               Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCard(
//       String title, String description, IconData iconData, Color color) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Icon(
//           iconData,
//           color: Colors.white,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//         subtitle: Padding(
//           padding: EdgeInsets.only(top: 8.0),
//           child: Text(
//             description,
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ),
//         tileColor: color,
//       ),
//     );
//   }
// }
