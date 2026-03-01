import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { SubcategoriesComponent } from '../subcategories/subcategories';
import { ProductsService, Product } from '../../services/products.service';
import { FavoritosService, Favorito } from '../../services/favoritos.service';
import { AuthService } from '../../services/auth.service';
import { Observable } from 'rxjs';
import { EstadoService } from '../../services/estado.service';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, SubcategoriesComponent, RouterLink],
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class ProductsComponent implements OnInit {

  categoria: string = '';
  subcategoria: string = '';
  products$!: Observable<Product[]>;
  favoritosMap: Map<number, number> = new Map();

  constructor(
    private route: ActivatedRoute,
    private productsService: ProductsService,
    public favoritosService: FavoritosService,
    public authService: AuthService,
    private estadoService: EstadoService
  ) {
    this.estadoService.login$.subscribe(() => {
      console.log('Login detectado, recargando favoritos...');
      this.cargarFavoritos();
    });
  }

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.categoria = params['tipo'];
      this.subcategoria = params['subcategoria'];
      this.products$ = this.productsService.listByCategoriaYPublico(this.subcategoria, this.categoria);
      this.cargarFavoritos();
    });
  }

  cargarFavoritos() {
    const usuario = this.authService.getCurrentUser();
    this.favoritosService.getFavoritos(usuario).subscribe({
      next: (favoritos: Favorito[]) => {
        console.log('FAVORITOS RECIBIDOS:', JSON.stringify(favoritos, null, 2));
        this.favoritosMap.clear();
        favoritos.forEach(f => {
          if (f && f.producto && f.producto.idProducto && f.idFavorito) {
            // Asegurar que el ID es número
            const productoId = Number(f.producto.idProducto);
            this.favoritosMap.set(productoId, f.idFavorito);
            console.log(`Añadido al mapa: producto ${productoId} -> idFavorito ${f.idFavorito}`);
          }
        });
        console.log('Favoritos cargados (mapa):', this.favoritosMap);
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

    // Asegurar que productoId es número
    const id = Number(productoId);

    if (usuario) {
      const existe = this.favoritosMap.has(id);
      console.log(`¿Producto ${id} es favorito?`, existe, this.favoritosMap);
      return existe;
    } else {
      const existe = this.favoritosService.esFavoritoLocal(id);
      console.log(`¿Producto ${id} es favorito local?`, existe);
      return existe;
    }
  }
  toggleFavorito(producto: any, event: Event) {
    event.preventDefault();
    event.stopPropagation();

    const productoId = Number(producto.idProducto);
    const usuario = this.authService.getCurrentUser();

    console.log('Toggle favorito:', { productoId, usuario, esFavorito: this.esFavorito(productoId) });

    if (this.esFavorito(productoId)) {
      const idFavorito = this.favoritosMap.get(productoId);
      console.log('Eliminando favorito:', { productoId, idFavorito, usuario });

      this.favoritosService.removeFavorito(productoId, usuario, idFavorito).subscribe({
        next: (resp) => {
          console.log('Respuesta al eliminar:', resp);
          if (usuario) {
            this.cargarFavoritos();
          } else {
            this.favoritosMap.delete(productoId);
          }
        },
        error: (error: any) => {
          console.error('Error al eliminar favorito', error);
          alert('Error al eliminar de favoritos');
        }
      });
    } else {
      console.log('Añadiendo favorito:', { producto, usuario });

      this.favoritosService.addFavorito(producto, usuario).subscribe({
        next: (resp: any) => {
          console.log('Respuesta al añadir:', resp);
          if (resp && resp.local) {
            console.log('Favorito local guardado');
            this.favoritosMap.set(productoId, -1);
          } else if (resp && resp.idFavorito) {
            this.favoritosMap.set(productoId, resp.idFavorito);
            console.log('Producto añadido a favoritos:', productoId);
          }
          // Forzar actualización de la vista
          this.favoritosMap = new Map(this.favoritosMap);
        },
        error: (error: any) => {
          console.error('Error al añadir favorito', error);
          if (error.status === 409) {
            alert('Este producto ya está en tus favoritos');
          } else {
            alert('Error al añadir a favoritos. Revisa la consola.');
          }
        }
      });
    }
  }
}