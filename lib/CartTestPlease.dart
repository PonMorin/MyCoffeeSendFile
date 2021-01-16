
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';

class SampleClass {
  
  var message;
  
  /// Creating the instance of flutter cart package.
  var cart = FlutterCart();


  addToCart(dynamic _product) => {
             message = cart.addToCart(
            productId: _product.productId,
            unitPrice: _product.productPrice,
            quantity: _product.quantity,

            uniqueCheck: _product.selectedProductType,

            productDetailsObject: _product),
      };

  removeItemFromCart(int index) => {
        cart.decrementItemFromCart(index),
      };

  addItemToCart(int index) {
    cart.incrementItemToCart(index);
  }
  
}

