import { Component, OnInit } from '@angular/core';
import { CartService } from '../../services/cart.service'; 
import { CommonModule } from '@angular/common'; 
import { RouterModule } from '@angular/router'; 

@Component({
  selector: 'app-cart',
  standalone: true, 
  imports: [CommonModule, RouterModule], 
  templateUrl: './cart.html',
  styleUrls: ['./cart.css']
})
export class CartComponent implements OnInit {
  
  itemsCarrito: any[] = [];

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
   
    this.itemsCarrito = this.cartService.getCartItems();
  }

obtenerTotal(): number {
  return this.itemsCarrito.reduce((acc, item) => acc + item.precioProducto, 0);
}


eliminarDelCarrito(producto: any) {
  this.cartService.removeFromCart(producto); 

}
}