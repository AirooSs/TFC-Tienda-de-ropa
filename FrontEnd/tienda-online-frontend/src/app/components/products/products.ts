import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { SubcategoriesComponent } from '../subcategories/subcategories';
import { ProductsService, Product } from '../../services/products.service';
import { FavoritosService, Favorito } from '../../services/favoritos.service';
import { AuthService } from '../../services/auth.service';
import { Observable, Subscription } from 'rxjs';
import { EstadoService } from '../../services/estado.service';
import { CartService } from '../../services/cart.service';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, SubcategoriesComponent, RouterLink],
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class ProductsComponent implements OnInit, OnDestroy {

  categoria: string = '';
  subcategoria: string = '';
  products$!: Observable<Product[]>;
  favoritosMap: Map<number, number> = new Map();
  
  private loginSubscription!: Subscription;
  private routeSubscription!: Subscription;

  constructor(
    private route: ActivatedRoute,
    private productsService: ProductsService,
    public favoritosService: FavoritosService,
    public authService: AuthService,
    private estadoService: EstadoService,
    private cartService: CartService
  ) {
    this.loginSubscription = this.estadoService.login$.subscribe(() => {
      console.log('Login detectado, recargando favoritos...');
      this.cargarFavoritos();
    });
  }

  ngOnInit() {
    this.routeSubscription = this.route.params.subscribe(params => {
      this.categoria = params['tipo'];
      this.subcategoria = params['subcategoria'];
      this.products$ = this.productsService.listByCategoriaYPublico(this.subcategoria, this.categoria);
      this.cargarFavoritos();
    });
  }

  ngOnDestroy() {
    if (this.loginSubscription) {
      this.loginSubscription.unsubscribe();
    }
    if (this.routeSubscription) {
      this.routeSubscription.unsubscribe();
    }
  }

  cargarFavoritos() {
    const usuario = this.authService.getCurrentUser();
    this.favoritosService.getFavoritos(usuario).subscribe({
      next: (favoritos: Favorito[]) => {
        console.log('FAVORITOS RECIBIDOS:', favoritos.length);
        
        this.favoritosMap.clear();
        favoritos.forEach(f => {
          if (f && f.producto && f.producto.idProducto && f.idFavorito) {
            const productoId = Number(f.producto.idProducto);
            this.favoritosMap.set(productoId, f.idFavorito);
          }
        });
        console.log('Favoritos cargados (mapa):', this.favoritosMap.size);
      },
      error: (error: any) => console.error('Error al cargar favoritos', error)
    });
  }
  
  recargarFavoritos() {
    console.log('Recargando favoritos después de login...');
    this.cargarFavoritos();
  }

  esFavorito(productoId: number): boolean {
    const usuario = this.authService.getCurrentUser();
    const id = Number(productoId);

    if (usuario) {
      return this.favoritosMap.has(id);
    } else {
      return this.favoritosService.esFavoritoLocal(id);
    }
  }
  
  toggleFavorito(producto: any, event: Event) {
    event.preventDefault();
    event.stopPropagation();

    const productoId = Number(producto.idProducto);
    const usuario = this.authService.getCurrentUser();

    if (this.esFavorito(productoId)) {
      const idFavorito = this.favoritosMap.get(productoId);
      console.log('Eliminando favorito:', { productoId, idFavorito });

      this.favoritosService.removeFavorito(productoId, usuario, idFavorito).subscribe({
        next: (resp) => {
          console.log('Respuesta al eliminar:', resp);
          if (usuario) {
            this.cargarFavoritos();
          } else {
            this.favoritosMap.delete(productoId);
            this.favoritosMap = new Map(this.favoritosMap);
          }
        },
        error: (error: any) => {
          console.error('Error al eliminar favorito', error);
          alert('Error al eliminar de favoritos');
        }
      });
    } else {
      console.log('Añadiendo favorito:', { productoId });

      this.favoritosService.addFavorito(producto, usuario).subscribe({
        next: (resp: any) => {
          console.log('Respuesta al añadir:', resp);
          if (resp && resp.local) {
            console.log('Favorito local guardado');
            this.favoritosMap.set(productoId, -1);
            this.favoritosMap = new Map(this.favoritosMap);
          } else if (resp && resp.idFavorito) {
            this.favoritosMap.set(productoId, resp.idFavorito);
            this.favoritosMap = new Map(this.favoritosMap);
            console.log('Producto añadido a favoritos:', productoId);
          }
        },
        error: (error: any) => {
          console.error('Error al añadir favorito', error);
          if (error.status === 409) {
            alert('Este producto ya está en tus favoritos');
            this.cargarFavoritos();
          } else {
            alert('Error al añadir a favoritos. Revisa la consola.');
          }
        }
      });
    }
  }
  
  agregarAlCarrito(producto: any) {
    this.cartService.addToCart(producto);
    alert(`${producto.nombreProducto} añadido al carrito`);
  }
  
  incrementarCantidad(producto: any) {
    this.cartService.addToCart(producto); 
  }

  decrementarCantidad(producto: any) {
    this.cartService.removeFromCart(producto); 
  }

  obtenerCantidad(productoId: number): number {
    return this.cartService.getCartItems().filter(item => item.idProducto === productoId).length;
  }

  quitarUno(producto: any) {
    this.cartService.removeFromCart(producto);
  }

  masUno(producto: any) {
    this.cartService.addToCart(producto);
  }
}