import 'package:bloc_tdd/src/authentication/presentation/blocs/cubit/authentication/authentication_cubit.dart';
import 'package:bloc_tdd/src/authentication/presentation/views/widgets/add_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is GettingUsersState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is AuthenticationErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              ),
            );
          }

          if (state is LoadedUsersState) {
            state.users.sort((uA, uB) => uA.createdAt.compareTo(uB.createdAt));
            final reversed = state.users.reversed.toList();
            return ListView.builder(
              itemCount: reversed.length,
              itemBuilder: (BuildContext ctx, int idx) {
                final user = reversed[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      radius: 40,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.createdAt),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AddUserDialog(cubit: context.read<AuthenticationCubit>());
            },
          );
          getUsers();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
