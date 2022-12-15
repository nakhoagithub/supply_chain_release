// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:supply_chain/config_application.dart';
// import 'package:supply_chain/constrain.dart';
// import 'package:supply_chain/models/company.dart';

// class CreateCompany extends StatefulWidget {
//   const CreateCompany({Key? key}) : super(key: key);

//   @override
//   State<CreateCompany> createState() => _CreateCompanyState();
// }

// class _CreateCompanyState extends State<CreateCompany> {
//   GlobalKey<FormState>? formKey;
//   String nameCompany = "";
//   String emailCompany = "";
//   int? selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     formKey = GlobalKey<FormState>();
//   }

//   bool validateAndSave() {
//     FormState? form = formKey!.currentState;
//     if (form!.validate()) {
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text(
//         "Tham gia chuỗi cung ứng",
//         style: TextStyle(fontSize: 18),
//       )),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.only(top: 5),
//           child: Form(
//             key: formKey,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         "Thông tin nhà cung cấp sản phẩm",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         labelText: 'Nhập tên nhà cung cấp',
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           nameCompany = value;
//                         });
//                         validateAndSave();
//                       },
//                       validator: (value) {
//                         return nameCompany == ""
//                             ? "Tên không được bỏ trống."
//                             : null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         labelText: 'Địa chỉ email nhà cung cấp',
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           emailCompany = value;
//                         });
//                         validateAndSave();
//                       },
//                       validator: (value) {
//                         return emailCompany == ""
//                             ? "Email không được bỏ trống."
//                             : checkEmail(value.toString())
//                                 ? "Email không hợp lệ!"
//                                 : null;
//                       },
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 8, right: 8, top: 8),
//                     child: Text(
//                       "Chọn kiểu nhà cung cấp:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: DropdownButtonFormField2(
//                       items: roleCompany
//                           .map((item) => DropdownMenuItem<RoleCompany>(
//                                 value: item,
//                                 child: Text(
//                                   item.name,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                       value: roleCompany[0],
//                       isExpanded: true,
//                       buttonHeight: 50,
//                       buttonPadding: const EdgeInsets.only(left: 10, right: 10),
//                       decoration: InputDecoration(
//                         isDense: true,
//                         contentPadding: EdgeInsets.zero,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       dropdownDecoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       onChanged: (value) {
//                         RoleCompany roleCompany = value as RoleCompany;
//                         setState(() {
//                           selectedValue = roleCompany.id;
//                         });
//                         validateAndSave();
//                       },
//                       validator: (value) {
//                         return value == null
//                             ? 'Vui lòng chọn kiểu nhà cung cấp'
//                             : null;
//                       },
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "Một số lưu ý khi tạo nhà cung cấp:",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
//                     child: Text(noteCreateCompany,
//                         style: TextStyle(fontStyle: FontStyle.italic)),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.resolveWith((states) {
//                             // if (states.contains(MaterialState.pressed)) {
//                             //   return Colors.indigo[900];
//                             // }
//                             return Colors.blue[800];
//                           }),
//                           textStyle:
//                               MaterialStateProperty.resolveWith((states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return const TextStyle(fontSize: 18);
//                             }
//                             return const TextStyle(fontSize: 16);
//                           }),
//                           padding: MaterialStateProperty.resolveWith((states) {
//                             return const EdgeInsets.all(10);
//                           }),
//                         ),
//                         onPressed: () {
//                           if (validateAndSave()) {
//                             // thực hiện
//                             print("thực hiện");
//                           }
//                         },
//                         child: const Text(
//                           "Tham gia",
//                         )),
//                   ),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
