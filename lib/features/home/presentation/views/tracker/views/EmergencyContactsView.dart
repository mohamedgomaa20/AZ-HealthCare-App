import 'package:az_health_care/core/services/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_confirmation_dialog.dart';
import '../../../../../onboarding_profile_setup/manager/emergency_contacts_cubit/emergency_contacts_cubit.dart';
import '../../../../../onboarding_profile_setup/manager/emergency_contacts_cubit/emergency_contacts_states.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  late EmergencyContactsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = EmergencyContactsCubit();
    cubit.getEmergencyContacts();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Emergency Contacts", style: AppTextStyles.bold20),
        ),
        body: BlocConsumer<EmergencyContactsCubit, EmergencyContactsStates>(
          listener: (context, state) {
            if (state is EmergencyGetContactsErrorState) {
              print(state.errorMessage);

              ToastHelper.showToast2(
                context: context,
                msg:
                    "The connection errored: Failed host lookup: 'healthmonitoring.runasp.net'",
                state: ToastStates.ERROR,
              );
            }
          },
          builder: (context, state) {
            if (state is EmergencyGetContactsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is EmergencyGetContactsErrorState) {
              print(state.errorMessage);

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(child: Text("state.errorMessage")),
              );
            }

            final contacts = cubit.contactList ?? [];

            if (contacts.isEmpty) {
              return const Center(child: Text("No emergency contacts found."));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: contacts.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: const Icon(Icons.person, color: Colors.red),
                  title: Text(
                    contact.name ?? "No Name",
                    style: AppTextStyles.medium14,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone: ${contact.phoneNumber ?? ''}"),
                      Text("Email: ${contact.email ?? ''}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.orange),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showCustomConfirmationDialog(
                            context: context,
                            title: 'Confirm Deletion',
                            content:
                                'Are you sure you want to delete this contact?',
                            confirmText: 'Delete',

                            onConfirm: () {
                              Navigator.of(context).pop();
                              cubit.deleteEmergencyContact(contact.contactId!);
                            },
                          );
                          // showDialog(
                          //   context: context,
                          //   builder:
                          //       (ctx) => AlertDialog(
                          //         title: const Text("Confirm Deletion"),
                          //         content: const Text(
                          //           "Are you sure you want to delete this contact?",
                          //         ),
                          //         actions: [
                          //           TextButton(
                          //             onPressed: () => Navigator.of(ctx).pop(),
                          //             child: const Text("Cancel"),
                          //           ),
                          //           TextButton(
                          //             onPressed: () {
                          //               Navigator.of(ctx).pop();
                          //               _cubit.deleteEmergencyContact(
                          //                 contact.contactId!,
                          //               );
                          //             },
                          //             child: const Text("Delete"),
                          //           ),
                          //         ],
                          //       ),
                          // );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// class EmergencyContactsScreen extends StatelessWidget {
//   const EmergencyContactsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EmergencyContactsCubit()..getEmergencyContacts(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Emergency Contacts", style: AppTextStyles.bold20),
//         ),
//         body: BlocBuilder<EmergencyContactsCubit, EmergencyContactsStates>(
//           builder: (context, state) {
//             final manager = EmergencyContactsCubit.get(context);
//             List<EmergencyContactModel> contacts = manager.contactList ?? [];
//             print(manager.contactList);
//             print(manager.contactList?.length);
//             return ListView.separated(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: contacts?.length ?? 2,
//               separatorBuilder: (_, __) => const Divider(),
//               itemBuilder: (context, index) {
//                 final contact = contacts?[index];
//                 return ListTile(
//                   leading: const Icon(Icons.person, color: Colors.red),
//                   title: Text(
//                     contact?.name ?? "No Name",
//                     style: AppTextStyles.medium14,
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Phone: ${contact?.phoneNumber   }"),
//                       Text("Email: ${contact?.email  }"),
//                     ],
//                   ),
//                 );
//               },
//             );
//             if (state is EmergencyGetContactsSuccessState) {
//               final contacts = state.contactList;
//               if (contacts?.isEmpty ?? true) {
//                 return const Center(
//                   child: Text("No emergency contacts found."),
//                 );
//               }
//             } else if (state is EmergencyGetContactsErrorState) {
//               return Center(child: Text(state.errorMessage));
//             } else {
//               return const Center(child: Text("Unexpected state"));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
