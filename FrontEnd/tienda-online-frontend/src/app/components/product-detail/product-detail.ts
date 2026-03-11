import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ProductsService } from '../../services/products.service'; 
import { CartService } from '../../services/cart.service';
import { FavoritosService } from '../../services/favoritos.service'; 
import { AuthService } from '../../services/auth.service'; 

@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.html',
  styleUrls: ['./product-detail.css']
})
export class ProductDetailComponent implements OnInit {
  producto: any;
  favoritoId: number | undefined; 

  constructor(
    private route: ActivatedRoute,
    private productsService: ProductsService, 
    private cartService: CartService,
    private favoritosService: FavoritosService, 
    private authService: AuthService 
  ) {}

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    
    this.productsService.getById(id).subscribe((p: any) => {
      this.producto = p;
      this.esFavorito(); 
    });
  }

  esFavorito(): void {
    const usuario = this.authService.getCurrentUser();
    if (usuario) {
      this.favoritosService.getFavoritos(usuario).subscribe(favs => {
        const favencontrado = favs.find(f => f.producto.idProducto === this.producto.idProducto);
        if (favencontrado) {
          this.favoritoId = favencontrado.idFavorito;
        }
      });
    } else {
      this.favoritoId = undefined; 
    }
  }

  get esFavoritoActivo(): boolean {
    if (!this.producto) return false;
    
    const usuario = this.authService.getCurrentUser();
    if (usuario) {
      return this.favoritoId !== undefined;
    }
    return this.favoritosService.esFavoritoLocal(this.producto.idProducto);
  }

  toggleFavorito() {
    if (!this.producto) return;
    const usuario = this.authService.getCurrentUser();

    this.favoritosService.toggleFavorito(this.producto, usuario, this.favoritoId)
      .subscribe({
        next: (res) => {

          if (res && res.idFavorito) {
            this.favoritoId = res.idFavorito;
          } else {
            this.favoritoId = undefined;
          }
        },
        error: (err) => {
          console.error('Error al cambiar favorito', err);

          this.favoritoId = undefined; 
        }
      });
  }

  agregarAlCarrito() {
    if (this.producto) {
      this.cartService.addToCart(this.producto);
    }
  }
}