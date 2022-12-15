import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:supply_chain/blocs/user/bloc/user_bloc.dart';
import 'package:supply_chain/blocs/user/bloc/user_state.dart';

import '../../../enum.dart';
import '../../../widgets/dialog_app.dart';
import '../bloc/user_event.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserPageBloc()..add(const UserPageInit()),
        child: const UserView());
  }
}

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  String? linkImage;
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus ||
          previous.name != current.name ||
          previous.email != current.email ||
          previous.address != current.address ||
          previous.addressCompany != current.addressCompany ||
          previous.linkImage != current.linkImage ||
          previous.balance != current.balance,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Tài khoản"),
            centerTitle: true,
            elevation: 1,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<UserPageBloc>().add(const UserPageInit());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ImageCompany(url: state.linkImage),
                        _NameCompany(name: state.name),
                        _EmailCompany(email: state.email),
                        const _TitleMenu(title: "Thông tin"),
                        _Balance(balance: state.balance),
                        _Address(address: state.address),
                        _AddressCompany(address: state.addressCompany),
                        const _CompanyInBlockchain(),
                        const _TitleMenu(title: "Cài đặt"),
                        const _MenuChangeInformation(),
                        const _GetPrivateKey(),
                        const _Logout(),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TitleMenu extends StatelessWidget {
  final String title;
  const _TitleMenu({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}

// class _TitleUserPage extends StatelessWidget {
//   const _TitleUserPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Tài Khoản",
//               style: TextStyle(fontSize: 26, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _ImageCompany extends StatelessWidget {
  final String? url;
  const _ImageCompany({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
          child: url != null && url!.isNotEmpty
              ? Image.network(
                  url!,
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/icon_bussiness.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  "assets/images/icon_bussiness.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )),
    );
  }
}

class _NameCompany extends StatelessWidget {
  final String? name;
  const _NameCompany({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Center(
              child: state.userPageStatus == UserPageStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      name ?? "(Tên công ty)",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
        );
      },
    );
  }
}

class _EmailCompany extends StatelessWidget {
  final String? email;
  const _EmailCompany({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Center(
              child: state.userPageStatus == UserPageStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      email ?? "(address@emailexample.com)",
                      style: const TextStyle(fontSize: 16),
                    )),
        );
      },
    );
  }
}

class _Balance extends StatelessWidget {
  final String? balance;
  const _Balance({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 30,
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Số dư: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Center(
                      child: state.userPageStatus == UserPageStatus.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              balance ?? "0",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Address extends StatelessWidget {
  final String? address;
  const _Address({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Địa chỉ số dư: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Center(
                        child: state.userPageStatus == UserPageStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                address ?? "(Địa chỉ số dư)",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        context
                            .read<UserPageBloc>()
                            .add(const UserPageCopyAddressEvent());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.copy,
                            size: 18,
                          ))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddressCompany extends StatelessWidget {
  final String? address;
  const _AddressCompany({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Địa chỉ công ty: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: state.userPageStatus == UserPageStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                address ?? "(Địa chỉ công ty)",
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CompanyInBlockchain extends StatefulWidget {
  const _CompanyInBlockchain({Key? key}) : super(key: key);

  @override
  State<_CompanyInBlockchain> createState() => _CompanyInBlockchainState();
}

class _CompanyInBlockchainState extends State<_CompanyInBlockchain> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      buildWhen: (previous, current) =>
          previous.userInBlockchain != current.userInBlockchain ||
          previous.userJoinBlockchainStatus !=
              current.userJoinBlockchainStatus ||
          previous.userPageStatus != current.userPageStatus,
      builder: (context, state) {
        bool userInBlockchain = state.userInBlockchain ?? false;
        return Container(
          margin: const EdgeInsets.only(top: 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Tham gia hệ thống\nblockchain: ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),

                  /// Show load
                  state.userJoinBlockchainStatus ==
                          UserJoinBlockchainStatus.loading
                      ? const Expanded(
                          child: Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              )),
                        ))

                      /// Show Error
                      : state.userJoinBlockchainStatus ==
                              UserJoinBlockchainStatus.failure
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  state.messageUserBlockchainStatus ?? "Lỗi",
                                  style: TextStyle(color: Colors.red[600]),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: state.userPageStatus ==
                                          UserPageStatus.loading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          userInBlockchain
                                              ? "Đã tham gia"
                                              : "Chưa tham gia",
                                          style: TextStyle(
                                              color: userInBlockchain
                                                  ? Colors.green
                                                  : Colors.orange,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            ),
                  userInBlockchain
                      ? Container()
                      : InkWell(
                          onTap: () {
                            openDialog(
                              context,
                              message: "Tham gia Blockchain",
                              yes: "Tham gia",
                              no: "Không",
                              onPressed: () {
                                context
                                    .read<UserPageBloc>()
                                    .add(const UserPageJoinBlockchainEvent());
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                              ))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuChangeInformation extends StatefulWidget {
  const _MenuChangeInformation({Key? key}) : super(key: key);

  @override
  State<_MenuChangeInformation> createState() => _MenuChangeInformationState();
}

class _MenuChangeInformationState extends State<_MenuChangeInformation> {
  _startChangeInfoWidget() async {
    String? results =
        await Navigator.of(context).pushNamed<dynamic>('/change_info_user');
    if (results != null) {
      if (results == "RELOAD") {
        if (mounted) {
          context.read<UserPageBloc>().add(const UserPageInit());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPageBloc, UserPageState>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.only(top: 0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Thay đổi thông tin",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Container(),
                ),
                InkWell(
                    onTap: () {
                      _startChangeInfoWidget();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GetPrivateKey extends StatefulWidget {
  const _GetPrivateKey({Key? key}) : super(key: key);

  @override
  State<_GetPrivateKey> createState() => _GetPrivateKeyState();
}

class _GetPrivateKeyState extends State<_GetPrivateKey> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Truy xuất Private Key",
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/receive_private_key');
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logout extends StatefulWidget {
  const _Logout({Key? key}) : super(key: key);

  @override
  State<_Logout> createState() => _LogoutState();
}

class _LogoutState extends State<_Logout> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  void _onPressed() {
    context.read<UserPageBloc>().add(const UserPageLogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPageBloc, UserPageState>(
      listener: (context, state) {
        switch (state.userPageStatus) {
          case UserPageStatus.initialize:
            break;
          case UserPageStatus.loading:
            break;
          case UserPageStatus.success:
            break;
          case UserPageStatus.failure:
            break;
          case UserPageStatus.logout:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
            break;
          default:
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: RoundedLoadingButton(
          height: 40,
          width: 150,
          color: Colors.red.shade400,
          successColor: Colors.green.shade700,
          borderRadius: 10,
          controller: _buttonController,
          onPressed: () {
            _onPressed();
          },
          child: const Text("Đăng xuất",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}
