import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/widgets/primary_bottom_button.dart';
import '../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import '../../data/models/payment_method_model.dart';
import '../widgets/add_payment_form.dart';

class AddPaymentView extends StatefulWidget {
  final Function(PaymentMethod) onPaymentAdded;

  const AddPaymentView({super.key, required this.onPaymentAdded});

  @override
  State<AddPaymentView> createState() => _AddPaymentViewState();
}

class _AddPaymentViewState extends State<AddPaymentView> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedMonth = '06';
  String _selectedYear = '28';

  @override
  void initState() {
    super.initState();
  }

  void _savePayment() {
    if (_cardNumberController.text.isNotEmpty &&
        _holderNameController.text.isNotEmpty &&
        _cvvController.text.isNotEmpty) {
      final String cardType = _getCardType(_cardNumberController.text);
      final String lastFourDigits = _cardNumberController.text
          .replaceAll(' ', '')
          .substring(_cardNumberController.text.replaceAll(' ', '').length - 4);

      final PaymentMethod newPayment = PaymentMethod(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: cardType,
        subtitle: '•••• •••• •••• $lastFourDigits',
        icon: Icons.credit_card,
        isLinked: true,
        iconColor: _getCardColor(cardType),
      );
      ToastHelper.showToast2(
        context: context,
        msg: "Payment Method Added Successfully",
        state: ToastStates.SUCCESS,
        bottomOffset: 110,
      );
      widget.onPaymentAdded(newPayment);
      Navigator.pop(context);
    }
  }

  String _getCardType(String cardNumber) {
    final String cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.startsWith('4')) return 'Visa';
    if (cleanNumber.startsWith('5')) return 'Mastercard';
    if (cleanNumber.startsWith('3')) return 'American Express';
    return 'Credit Card';
  }

  Color _getCardColor(String cardType) {
    switch (cardType) {
      case 'Visa':
        return AppColors.visaColor;
      case 'Mastercard':
        return AppColors.mastercardColor;
      case 'American Express':
        return AppColors.amexColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Add New Payment",
              trailingWidget: IconButton(
                icon: const Icon(
                  Iconsax.scan_outline,
                  color: AppColors.whiteColor,
                ),
                onPressed: _resetFields,
              ),
            ),
            Expanded(
              child: AddPaymentForm(
                cardNumberController: _cardNumberController,
                holderNameController: _holderNameController,
                formKey: _formKey,
                cvvController: _cvvController,
                selectedMonth: _selectedMonth,
                selectedYear: _selectedYear,
                onDateChanged: (month, year) {
                  setState(() {
                    _selectedMonth = month;
                    _selectedYear = year;
                  });
                },
              ),
            ),

            PrimaryBottomButton(
              text: "Save",
              onTap:
                  _cardNumberController.text.isNotEmpty &&
                          _holderNameController.text.isNotEmpty &&
                          _cvvController.text.isNotEmpty
                      ? () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _savePayment();
                        }
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }

  void _resetFields() {
    setState(() {
      _cardNumberController.clear();
      _holderNameController.clear();
      _cvvController.clear();
      _selectedMonth = '06';
      _selectedYear = '28';
    });
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _holderNameController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}
