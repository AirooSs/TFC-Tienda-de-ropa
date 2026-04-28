import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { forkJoin, Subscription } from 'rxjs';
import { FavoritosService, Favorito } from '../../services/favoritos.service';
import { AuthService } from '../../services/auth.service';
import { ProductsService } from '../../services/products.service';
import { EstadoService } from '../../services/estado.service';

@Component({
  selector: 'app-favorites',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './favorites.html',
  styleUrl: './favorites.css'
})
export class FavoritesComponent implements OnInit, OnDestroy {
  
  favoritos: Favorito[] = [];
  loading: boolean = true;
  error: string | null = null;
  
  private refreshSubscription!: Subscription;

  constructor(
    public favoritosService: FavoritosService, 
    public authService: AuthService,
    private productsService: ProductsService,
    private estadoService: EstadoService
  ) {
    this.refreshSubscription = this.estadoService.login$.subscribe(() => {
      console.log('Login detectado en favoritos, recargando...');
      this.cargarFavoritos();
    });
  }

  ngOnInit() {
    this.cargarFavoritos();
  }

  ngOnDestroy() {
    if (this.refreshSubscription) {
      this.refreshSubscription.unsubscribe();
    }
  }

  getTrackId(favorito: Favorito): number {
    return favorito.idFavorito || favorito.producto.idProducto;
  }

  cargarFavoritos() {
    const usuario = this.authService.getCurrentUser();
    
    if (usuario) {
      this.loading = true;
      this.favoritosService.getFavoritos(usuario).subscribe({
        next: (data: Favorito[]) => {
          this.favoritos = data;
          this.loading = false;
          console.log('Favoritos cargados de backend:', this.favoritos.length);
        },
        error: (error: any) => {
          console.error('Error al cargar favoritos:', error);
          this.error = 'Error al cargar los favoritos';
          this.loading = false;
        }
      });
    } else {
      this.cargarFavoritosLocales();
    }
  }

  cargarFavoritosLocales() {
    const favoritosLocalesIds = this.favoritosService.getFavoritosLocalesIds();
    
    if (favoritosLocalesIds.length === 0) {
      this.favoritos = [];
      this.loading = false;
      return;
    }

    this.loading = true;
    
    const peticiones = favoritosLocalesIds.map(id => 
      this.productsService.getById(id)
    );
    
    forkJoin(peticiones).subscribe({
      next: (productos: any[]) => {
        this.favoritos = productos
          .filter(producto => producto !== null && producto !== undefined)
          .map(producto => ({
            idFavorito: undefined,
            producto: {
              idProducto: producto.idProducto,
              nombreProducto: producto.nombreProducto,
              precioProducto: producto.precioProducto,
              stockProducto: producto.stockProducto,
              imagenUrl: producto.imagenUrl,
              categoria: producto.categoria,
              publico: producto.publico
            }
          }));
        console.log('Favoritos locales cargados:', this.favoritos.length);
        this.loading = false;
      },
      error: (error) => {
        console.error('Error al cargar productos locales:', error);
        this.error = 'Error al cargar los favoritos locales';
        this.loading = false;
      }
    });
  }

  quitarFavorito(favorito: Favorito, event: Event) {
    event.preventDefault();
    event.stopPropagation();
    
    const usuario = this.authService.getCurrentUser();
    
    if (usuario && favorito.idFavorito) {
      this.favoritosService.removeFavorito(favorito.producto.idProducto, usuario, favorito.idFavorito).subscribe({
        next: () => {
          this.favoritos = this.favoritos.filter(f => f.idFavorito !== favorito.idFavorito);
          console.log('Producto eliminado de favoritos (backend):', favorito.producto.idProducto);
        },
        error: (error: any) => {
          console.error('Error al eliminar favorito:', error);
          alert('Error al eliminar el producto de favoritos');
        }
      });
    } else {
      this.favoritosService.eliminarFavoritoLocal(favorito.producto.idProducto);
      this.favoritos = this.favoritos.filter(f => f.producto.idProducto !== favorito.producto.idProducto);
      console.log('Producto eliminado de favoritos locales:', favorito.producto.idProducto);
    }
  }
}