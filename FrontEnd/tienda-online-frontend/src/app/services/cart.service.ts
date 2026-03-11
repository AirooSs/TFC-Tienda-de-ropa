import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CartService {
  
  private cartItems: any[] = [];

  private _cart = new BehaviorSubject<any[]>([]);
  cart$ = this._cart.asObservable();

  constructor() {}

  addToCart(product: any) {
    
    this.cartItems.push(product);
    this._cart.next([...this.cartItems]);
    
    console.log('Producto en el carrito:', this.cartItems);
  }

  getCartItems() {
    return this.cartItems;
  }
  removeFromCart(product: any) {
  const index = this.cartItems.findIndex(item => item.idProducto === product.idProducto);
  if (index > -1) {
    this.cartItems.splice(index, 1);
    this._cart.next([...this.cartItems]);
  }
}
}