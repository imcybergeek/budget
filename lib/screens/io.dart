import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IO {
  int? io;
  String? text;
  IconData? icon;
  Color? color;
  int? key;

  IO({this.key, this.io, this.text, this.icon, this.color});
}

List<IO> expense = [
  IO(key: 1, text: "XD", icon: FontAwesomeIcons.youtube, color: Colors.green),
  IO(
      key: 2,
      text: "Food",
      icon: FontAwesomeIcons.utensils,
      color: Colors.orange),
  IO(
      key: 3,
      text: "Fruit",
      icon: FontAwesomeIcons.shoppingBasket,
      color: Colors.green),
  IO(
      key: 4,
      text: "Clothing",
      icon: FontAwesomeIcons.tshirt,
      color: Colors.red),
  IO(
      key: 5,
      text: "Shopping",
      icon: FontAwesomeIcons.shoppingCart,
      color: Colors.pink),
  IO(
      key: 6,
      text: "Transportation",
      icon: FontAwesomeIcons.bus,
      color: Colors.green),
  IO(key: 7, text: "Home", icon: FontAwesomeIcons.home, color: Colors.orange),
  IO(key: 8, text: "Travel", icon: FontAwesomeIcons.plane, color: Colors.green),
  IO(
      key: 9,
      text: "Wine",
      icon: FontAwesomeIcons.wineBottle,
      color: Colors.indigo),
  IO(
      key: 10,
      text: "Bills",
      icon: FontAwesomeIcons.receipt,
      color: Colors.blue),
  IO(key: 11, text: "Gifts", icon: FontAwesomeIcons.gifts, color: Colors.red),
  IO(
      key: 12,
      text: "Education",
      icon: FontAwesomeIcons.userGraduate,
      color: Colors.green),
  IO(
      key: 13,
      text: "Vegitables",
      icon: FontAwesomeIcons.carrot,
      color: Colors.green.shade800),
  IO(
      key: 14,
      text: "Snacks",
      icon: FontAwesomeIcons.cookieBite,
      color: Colors.pink),
  IO(
      key: 15,
      text: "Phone",
      icon: FontAwesomeIcons.mobileAlt,
      color: Colors.green.shade800),
  IO(
      key: 16,
      text: "Baby",
      icon: FontAwesomeIcons.babyCarriage,
      color: Colors.green),
  IO(
      key: 17,
      text: "Sport",
      icon: FontAwesomeIcons.volleyballBall,
      color: Colors.blue),
  IO(
      key: 18,
      text: "Tax",
      icon: FontAwesomeIcons.fileInvoiceDollar,
      color: Colors.green),
  IO(
      key: 19,
      text: "Electronics",
      icon: FontAwesomeIcons.laptop,
      color: Colors.blue),
  IO(
      key: 20,
      text: "Health",
      icon: FontAwesomeIcons.heartbeat,
      color: Colors.red),
  IO(
      key: 21,
      text: "Entertainment",
      icon: FontAwesomeIcons.film,
      color: Colors.indigo),
  IO(key: 22, text: "Car", icon: FontAwesomeIcons.car, color: Colors.purple),
  IO(
      key: 23,
      text: "Social",
      icon: FontAwesomeIcons.users,
      color: Colors.purple),
  IO(
      key: 24,
      text: "Insurance",
      icon: FontAwesomeIcons.carCrash,
      color: Colors.purple),
  IO(
      key: 25,
      text: "Office",
      icon: FontAwesomeIcons.building,
      color: Colors.blue),
  IO(key: 26, text: "Book", icon: FontAwesomeIcons.book, color: Colors.indigo),
  IO(
      key: 27,
      text: "Cigarette",
      icon: FontAwesomeIcons.smoking,
      color: Colors.red),
  IO(key: 28, text: "Pet", icon: FontAwesomeIcons.paw, color: Colors.red),
  IO(
      key: 29,
      text: "Beauty",
      icon: FontAwesomeIcons.handSparkles,
      color: Colors.pink),
  IO(
      key: 30,
      text: "Hamburger",
      icon: FontAwesomeIcons.hamburger,
      color: Colors.red),
];

List<IO> income = [
  IO(key: 1, text: "Rental", icon: FontAwesomeIcons.home, color: Colors.blue),
  IO(key: 2, text: "Grants", icon: FontAwesomeIcons.gift, color: Colors.green),
  IO(
      key: 3,
      text: "Dividents",
      icon: FontAwesomeIcons.chartLine,
      color: Colors.green),
  IO(
      key: 4,
      text: "Refunds",
      icon: FontAwesomeIcons.undoAlt,
      color: Colors.purple),
  IO(key: 5, text: "Salary", icon: FontAwesomeIcons.wallet, color: Colors.red),
  IO(key: 6, text: "Sale", icon: FontAwesomeIcons.tags, color: Colors.indigo),
  IO(
      key: 7,
      text: "Awards",
      icon: FontAwesomeIcons.handHoldingUsd,
      color: Colors.orange),
  IO(
      key: 8,
      text: "Coupons",
      icon: FontAwesomeIcons.moneyBillWave,
      color: Colors.pink),
  IO(key: 9, text: "Others", icon: FontAwesomeIcons.shapes, color: Colors.red),
];
