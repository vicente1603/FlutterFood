import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PriceCard extends StatelessWidget {
  final VoidCallback buy;

  PriceCard(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Resumo do pedido",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "R\$ ${price.toStringAsFixed(2)}",
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Desconto",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "R\$ ${discount.toStringAsFixed(2)}",
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Divider(thickness: 2.0),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                    Text("R\$ ${(price - discount).toStringAsFixed(2)}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("Finalizar pedido",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        )),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
