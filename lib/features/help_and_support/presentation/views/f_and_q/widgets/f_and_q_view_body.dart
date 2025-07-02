import 'package:flutter/cupertino.dart';

import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'faq_category_tabs.dart';
import 'faq_question_list.dart';
import 'faq_search_field.dart';

class FAndQViewBody extends StatefulWidget {
  const FAndQViewBody({super.key});

  @override
  State<FAndQViewBody> createState() => _FAndQViewBodyState();
}

class _FAndQViewBodyState extends State<FAndQViewBody> {
  TextEditingController searchController = TextEditingController();
  List<String> categoriesList = [
    "General",
    "Account",
    "Services",
    "Tracking",
    "General2",
    "Account2",
  ];
  String selectedCategory = "General";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'FAQ'),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  FAQSearchField(
                    controller: searchController,
                    hint: "Search",
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 20),
                  FAQCategoryTabs(
                    categories: categoriesList,
                    selectedCategory: selectedCategory,
                    onCategorySelected: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  ),

                  FAQQuestionList(
                    // key: UniqueKey(),
                    category: selectedCategory,
                    searchText: searchController.text,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
