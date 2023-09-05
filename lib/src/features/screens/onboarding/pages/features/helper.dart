import 'package:erisiti/src/features/screens/onboarding/pages/features/modal.dart';
import 'package:flutter/material.dart';

class OnboardHelper {
  static final List<Widget> list = <Widget>[
    const OnboardPage(
        imageUrl: "assets/images/undraw_receipt_re_fre3.svg",
        title: "Issue your receipt easily",
        description:
            "We're excited to announce a new way to simplify your shopping experience, digital receipts! Say goodbye to paper clutter and hello to instant access. Starting now,"
            "we're offering digital receipts for all your purchases. "
            "Easy Access, Reduced Waste",
        label: "issue"),
    const OnboardPage(
        imageUrl: "assets/images/undraw_memory_storage_reh0.svg",
        title: "Analyze your receipts",
        description:
            "Turn your mobile phone into a powerful financial tool. Our app lets you effortlessly analyze your digital receipts, giving you these advantages:"
            "🔍 Spending Patterns: Gain clarity on where your money goes. "
            "Identify areas to save and allocate funds more effectively.",
        label: "discover"),
    const OnboardPage(
        imageUrl: "assets/images/undraw_pie_graph_re_fvol.svg",
        title: "Store All receipts",
        description:
            "🌟 Discover the Convenience of Digital Receipts for Storage! Experience a clutter-free world with our digital receipts! Ditch the paper hassle and embrace the benefits"
            " 🔒 Secure & Private: Your digital receipts are protected, ensuring your information remains confidential.",
        label: "store"),
  ];
}
