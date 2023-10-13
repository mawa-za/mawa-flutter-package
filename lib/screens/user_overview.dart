part of 'package:mawa_package/mawa_package.dart';

class UserOverview extends StatefulWidget {
  static const String id = 'User overview';
  const UserOverview({Key? key, this.onWillPop, required this.widget, required this.user}) : super(key: key);
  final dynamic onWillPop;
  final Widget widget;
  final String user;

  @override
  State<UserOverview> createState() => _UserOverviewState();
}

class _UserOverviewState extends State<UserOverview> {
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  TextEditingController _confirmPasswordController = TextEditingController();

  // QFR5Q3Y1ERG

  confirmOldPasswordPopup() {
    return AwesomeDialog(
        context: context,
        title: 'Confirm Password',
        body: Form(
          key: _confirmPasswordFormKey,
          child: TextFormField(
            controller: _confirmPasswordController,
            validator: (value) {
              if (_confirmPasswordController.text.toString() !=
                  User.password) {
                return 'Password Does Not Match User';
              }
              return null;
            },
          ),
        ),
        btnOk:
          DialogButton(
            onPressed: () {
              if(_confirmPasswordFormKey.currentState!.validate()) {
                Navigator.of(context).pop();
                loadPasswordChange();
              }
            },
            color: Colors.green,
            child: const Text('Confirm'),
          )
        ).show();
  }

  loadPasswordChange() async {
    await Tools().passwordResetPopup(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
          onWillPop: widget.onWillPop,
          child: Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  future: future(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Widget child;
                    if (snapshot.connectionState == ConnectionState.done) {
                      Widget children;
                      if (Persons.person.isNotEmpty && User.user.isNotEmpty) {
                        Persons.personId = Persons.person[JsonResponses.id] ??
                            Persons.person[JsonResponses.id];

                        children = Expanded(
                          child: ListView(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                                child: DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text(' '),
                                    ),
                                    DataColumn(label: Text(' ')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'User ',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          User.loggedInUser[JsonResponses.id] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(
                                        Text(
                                          Persons.person[JsonResponses.personIdType] ??
                                              '',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          Persons.person[
                                          JsonResponses.personIdNumber] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Partner',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          Persons.personNameFromJson(Persons.person)
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Title',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          Persons.person[JsonResponses.personTitle] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Gender',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                         Persons.person[JsonResponses.personGender] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Marital Status',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          Persons.person[
                                          JsonResponses.personMaritalStatus] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Date Of Birth',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          '${Persons.person[JsonResponses.personBirthDate] ?? ''}',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Person Status',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          Persons.person[JsonResponses.personStatus] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text('Email'),

                                      ),
                                      DataCell(
                                        Text(User.loggedInUser[JsonResponses.email] ?? ''),

                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text('Cell Phone'),

                                      ),
                                      DataCell(
                                        Text(User.loggedInUser[JsonResponses.cellphone] ?? ''),

                                      ),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                        Text(
                                          'Password Status',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          User.loggedInUser[JsonResponses.passwordStatus] ??
                                              '',
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        children = SnapShortStaticWidgets.futureNoData(displayMessage: 'User information could not be retrieved');
                      }
                      child = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          children,
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    confirmOldPasswordPopup();
                                  },
                                  child: const Text('Change Password')),
                              // SizedBox(height: 10.0),

                            ],
                          ),
                          widget.widget,
                        ],
                      );
                    }
                    else if (snapshot.hasError) {
                      child = SnapShortStaticWidgets.snapshotError();
                    }
                    else {
                      child = SnapShortStaticWidgets.snapshotWaitingIndicator();
                    }
                    return Center(
                      child: child,
                    );
                  }),
            ),

          ),
    ));
  }

  future() async {
    String username;
    if(widget.user.toUpperCase() == 'ME'){
      final SharedPreferences prefs = await preferences;

      username = prefs.getString(SharedPrefs.username) ?? '';
    }
    else{
      username = widget.user;
    }
    await User(username).get();
  }
}
