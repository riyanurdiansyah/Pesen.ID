import 'package:pesen_id/models/category_m.dart';
import 'package:pesen_id/models/side_menu_m.dart';
import 'package:intl/intl.dart';

final currencyFormatter = NumberFormat.currency(
  locale: "id_ID",
  symbol: "Rp. ",
  decimalDigits: 0,
);

List<SideMenuM> listSideMenu = [
  SideMenuM(title: "Obrolan", img: "chat.png", route: "/chat"),
  SideMenuM(title: "Keranjang", img: "cart.png", route: "/cart"),
  SideMenuM(title: "Notifikasi", img: "notif.png", route: "/notif"),
  SideMenuM(title: "Pengaturan", img: "settings.png", route: "/setting"),
  SideMenuM(title: "Kebijakan Pengguna", img: "terms.png", route: "/terms"),
  SideMenuM(title: "Keluar", img: "power.png", route: "signout"),
];

const tokenMap =
    "sk.eyJ1Ijoicml5YW51cmRpYW5zeWFoIiwiYSI6ImNrenR4bGk4OTF0N3QycHBlbDN6aDVrMTcifQ.Ln5MQsnl9nfIqNIB3e9NdQ";
const urlMap = "https://www.mapbox.com";

List<CategoryM> listCategory = [
  CategoryM(
    category: 1,
    categoryName: "Futsal",
  ),
  CategoryM(
    category: 2,
    categoryName: "Badminton",
  ),
  CategoryM(
    category: 3,
    categoryName: "Sepak Bola",
  ),
  CategoryM(
    category: 4,
    categoryName: "Volley",
  ),
  CategoryM(
    category: 5,
    categoryName: "Basket",
  ),
  CategoryM(
    category: 6,
    categoryName: "Others",
  ),
];

const mapBoxUrl =
    'https://api.mapbox.com/styles/v1/riyanurdiansyah/ckzuyk2fw000t14rxqq0ihk05/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}';
const mapBoxToken =
    "pk.eyJ1Ijoicml5YW51cmRpYW5zeWFoIiwiYSI6ImNrenR4bHI1ZjF0N3cycHBlZ3BqZWVnbDYifQ.jXKBY_ELaTu1NhkRAk-J-Q";
const mapBoxStyle = "mapbox://styles/mapbox/navigation-day-v1";
