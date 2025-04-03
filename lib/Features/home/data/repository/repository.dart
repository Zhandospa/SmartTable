import 'package:onay/Features/home/data/models/menu_category.dart';
import 'package:onay/Features/home/data/service/service.dart';

class MenuRepository {
  final MenuService menuService;

  MenuRepository(this.menuService);

  Future<List<MenuCategory>> getMenu() {
    return menuService.fetchMenu();
  }
}
