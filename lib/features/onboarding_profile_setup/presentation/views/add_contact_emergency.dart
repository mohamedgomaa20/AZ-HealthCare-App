import 'package:az_health_care/core/widgets/customLoadingButton.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/show_toast.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/emergency_contacts_cubit/emergency_contacts_cubit.dart';
import '../../manager/emergency_contacts_cubit/emergency_contacts_states.dart';

class AddContactEmergency extends StatelessWidget {
  const AddContactEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmergencyContactsCubit, EmergencyContactsStates>(
      listener: (context, state) {
        if (state is EmergencyAddContactsSuccessState) {
          ToastHelper.showToast2(
            context: context,
            msg: 'Contact added successfully',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is EmergencyAddContactsErrorState) {
          ToastHelper.showToast2(
            context: context,
            msg:
                state.errorMessage ??
                "Something went wrong please try to login and try again",
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EmergencyContactsCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "Add Emergency Contact",
                style: AppTextStyles.bold30,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              CustomTextFormField(
                labelText: "Contact Name",
                hintText: "Enter Contact name",
                onChanged: (value) => cubit.updateContactName(value),

                keyboardType: TextInputType.name,
                controller: cubit.contactNameController,
              ),

              SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Relationship",
                hintText: "Enter Relationship",
                keyboardType: TextInputType.text,
                controller: cubit.contactRelationshipController,
                onChanged: (value) => cubit.updateContactRelationship(value),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Phone Number",
                hintText: "Enter contact phone name",
                keyboardType: TextInputType.phone,
                controller: cubit.contactPhoneNumberController,
                onChanged: (value) => cubit.updateContactPhoneNumber(value),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Contact Email",
                hintText: "Enter contact Email",
                keyboardType: TextInputType.emailAddress,
                controller: cubit.contactEmailController,
                onChanged: (value) => cubit.updateContactEmail(value),
              ),

              SizedBox(height: 40),
              state is! EmergencyAddContactsLoadingState
                  ? CustomButton(
                    text: "Save",
                    onPressed: () {
                      if (cubit.contactName != null &&
                          cubit.contactName!.isNotEmpty &&
                          cubit.contactPhoneNumber != null &&
                          cubit.contactPhoneNumber!.isNotEmpty &&
                          cubit.contactRelationship != null &&
                          cubit.contactRelationship!.isNotEmpty &&
                          cubit.contactEmail != null &&
                          cubit.contactEmail!.isNotEmpty) {
                        cubit.addEmergencyContact();
                      } else {
                        null;
                      }
                    },
                  )
                  : CustomLoadingButton(),
              const Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}
