import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common/Photo.dart';
import 'package:flutter_application_1/widgets/u7/product/api/ProductAPI.dart';
import 'package:flutter_application_1/widgets/u7/product/models/Product.dart';

// COMPONENT FORM THỰC THI LOGIC SUBMIT
class ProductForm extends StatefulWidget {
  final Product? product;
  final VoidCallback onSave;

  const ProductForm({super.key, this.product, required this.onSave});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _quantityController.text = widget.product!.quantity.toString();
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newProd = Product(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        imageUrl:
            widget.product?.imageUrl ??
            randomPhotoUrl(), // "https://picsum.photos/200",
      );

      if (widget.product == null) {
        ProductAPI.addProduct(newProd);
      } else {
        ProductAPI.updateProduct(newProd);
      }
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.product == null ? "THÊM SẢN PHẨM" : "SỬA SẢN PHẨM",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên sản phẩm"),
              validator: (v) => v!.isEmpty ? "Nhập tên" : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Số lượng"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("LƯU DỮ LIỆU"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
