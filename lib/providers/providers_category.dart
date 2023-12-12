import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/category.dart';

// Notifier'ın oluşturulması
class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

  void addCategory(Category category) {
    state = [...state, category];
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
  return CategoriesNotifier();
});

class AddCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read(categoriesProvider.notifier).addCategory(
              Category(
                id: "5",
                name: "Yeni Kategori",
                color: Colors.orange,
              ),
            );
      },
      child: Text("Yeni Kategori Ekle"),
    );
  }
}

class CategoriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final categories = watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index].name),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddCategoryWidget(),
              CategoriesPage(),
            ],
          ),
        ),
      ),
    ),
  );
}
