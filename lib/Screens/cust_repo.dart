import 'package:bloc_user_app/Screens/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/repositories.dart';

class CustRepo extends StatelessWidget {
  const CustRepo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: UserPage(),
    );
  }
}