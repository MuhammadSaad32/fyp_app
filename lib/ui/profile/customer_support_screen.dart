import 'package:flutter/material.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildExpansionTile('Important Updates', 'All important details regarding OLX Pakistan App Upgradation'),
            _buildExpansionTile('Safety', 'All safety measures for our valuable customers\' convenience, are to be found here'),
            _buildExpansionTile('Legal & Privacy information', 'There is some Legal & Privacy information for our valued customers\' ease'),
            _buildExpansionTile('Featured Ads & Business Packages', 'Featured Ads and Business Packages for customers\' ease and convenience over here'),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(content),
        ),
      ],
    );
  }

// Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Customer Support'),
  //       backgroundColor: primaryColor,
  //     ),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildSectionHeader('Important Updates'),
  //           _buildSupportItem(
  //             title: 'All important details regarding OLX Pakistan App Upgradation',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Safety'),
  //           _buildSupportItem(
  //             title: 'All safety measures for our valuable customers\' convenience, are to be found here',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Legal & Privacy information'),
  //           _buildSupportItem(
  //             title: 'There is some Legal & Privacy information for our valued customers\' ease',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Featured Ads & Business Packages'),
  //           _buildSupportItem(
  //             title: 'Featured Ads and Business Packages for customers\' ease and convenience over here',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Free Ad Limits'),
  //           _buildSupportItem(
  //             title: 'There is a description for the guidance of customer about free Ad limitations',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Boost to Top'),
  //           _buildSupportItem(
  //             title: 'This will help our precious customers\' take their Ad(s) on the top of the particular category',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('OLX Car Inspections - New!'),
  //           _buildSupportItem(
  //             title: 'Here we find how we can inspect a car at OLX',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('My Account / Profile'),
  //           _buildSupportItem(
  //             title: 'It includes all the important information about Account & Profile creation and modification',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Posting and Managing Ads'),
  //           _buildSupportItem(
  //             title: 'This may help our valued customers as far as posting and managing ads are concerned that lead to manage account & pos...',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Payments & Invoices'),
  //           _buildSupportItem(
  //             title: 'Payment methods, Billing details, & General information',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('Chat'),
  //           _buildSupportItem(
  //             title: 'A convenient way for our valued customers to chat with OLX users',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('How do I buy on OLX?'),
  //           _buildSupportItem(
  //             title: 'Here we will find the procedure to buy and sell on OLX',
  //           ),
  //           const SizedBox(height: 16),
  //           _buildSectionHeader('About Us!'),
  //           _buildSupportItem(
  //             title: 'Here we can see contact details and what\'s new in #NayaOLX and our premium support',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildSectionHeader(String title) {
  //   return Text(
  //     title,
  //     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //   );
  // }
  //
  // Widget _buildSupportItem({required String title}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: Text(title),
  //   );
  // }
}

