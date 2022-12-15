import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supply_chain/blocs/app/views/app_page.dart';
import 'package:supply_chain/blocs/company/views/company_info_page.dart';
import 'package:supply_chain/blocs/generate_PK/views/generate_success_page.dart';
import 'package:supply_chain/blocs/history/views/history_info_page.dart';
import 'package:supply_chain/blocs/history/views/history_page.dart';
import 'package:supply_chain/blocs/main/views/main_page.dart';
import 'package:supply_chain/blocs/product/product.dart';
import 'package:supply_chain/blocs/qr/views/barcode_scan_success_page.dart';
import 'package:supply_chain/blocs/receive_pk/views/recieve_pk_page.dart';
import 'package:supply_chain/blocs/transfer/views/transfer_page.dart';
import 'package:supply_chain/blocs/transfer/views/transfer_product_page.dart';
import 'package:supply_chain/theme.dart';

import 'blocs/change_info/change_info.dart';
import 'blocs/generate_PK/views/generate_page.dart';
import 'blocs/login/views/login_page.dart';
import 'blocs/product/views/list_ingredient.dart';
import 'blocs/qr/views/barcode_page.dart';
import 'blocs/scan/views/scan_page.dart';
import 'blocs/scan/views/scan_success.dart';
import 'blocs/scan/views/supply_chain.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.transparent, // status bar color
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const AppPage());
}

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.themeData(),
      initialRoute: "/",
      routes: {
        '/': (context) => const App(),
        '/login': (context) => const LoginPage(),
        '/generate': (context) => const GeneratePKPage(),
        '/generate_success': (context) => const GenerateSuccessPage(),
        '/home': (context) => const MainPage(),
        '/change_info_user': (context) => const ChangeInformationUserPage(),
        '/receive_private_key': (context) => const ReceivePKPage(),
        '/add_product': (context) => const AddProductPage(),
        '/product_manager': (context) => const ProductManagerPage(),
        '/transfer': (context) => const TransferPage(),
        '/product_transfer': (context) => const TransferProductPage(),
        '/qr': (context) => const BarcodePage(),
        '/transfer_history': (context) => const HistoryPage(),
        '/history_info': (context) => const HistoryInfoPage(),
        '/scan_barcode_success': (context) => const BarcodeScanSuccessPage(),
        '/list_ingredient': (context) => const ListIngredientPage(),
        '/scan': (context) => const ScanPage(),
        '/scan_success': (context) => const ScanSuccess(),
        '/supply_chain': (context) => const SupplyChain(),
        '/info_company': (context) => const CompanyInfoPage(),
      },
    );
  }
}

// return MaterialApp(
//       title: 'Supply Chain',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: firebaseLogin.getCurrentUser() != null
//       //     ? Home(
//       //         user: firebaseLogin.getCurrentUser(),
//       //       )
//       //     : const Login(),
//       initialRoute: '/login',
//       routes: {
//         '/': (context) => Home(
//             response: getIt<SharedPreferencesApp>()
//                 .getSharedPreferences
//                 .getString('responseLogin')),
//         '/login': (context) => const Login(),
//         '/generate': (context) => const GeneratePKPage(),
//         '/create_company': (context) => const CreateCompany(),
//         '/profile_manager': (context) => const ProfileManager(),
//         '/product_manager': (context) => const ProductManager(),
//         '/product_history': (context) => const ProductHistory(),
//         '/list_company': (context) => const ListCompany(),
//         '/change_infor_company': (context) => const ChangeInforCompany(),
//       },
//     );
