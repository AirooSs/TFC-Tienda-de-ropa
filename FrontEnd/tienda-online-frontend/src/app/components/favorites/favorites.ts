import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { FavoritosService, Favorito } from '../../services/favoritos.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-favorites',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './favorites.html',
  styleUrl: './favorites.css'
})
export class FavoritesComponent implements OnInit {
  
  favoritos: Favorito[] = [];
  loading: boolean = true;
  error: string | null = null;

  constructor(
    public favoritosService: FavoritosService,  // Cambiado a public
    public authService: AuthService              // Cambiado a public
  ) {}

  ngOnInit() {
    this.cargarFavoritos();
  }

  cargarFavoritos() {
    const usuario = this.authService.getCurrentUser();
    if (!usuario) {
      this.error = 'Debes iniciar sesión para ver tus favoritos';
      this.loading = false;
      return;
    }

    this.favoritosService.getFavoritos(usuario).subscribe({
      next: (data: Favorito[]) => {
        this.favoritos = data;
        this.loading = false;
        console.log('Favoritos cargados en página de favoritos:', this.favoritos);
      },
      error: (error: any) => {
        console.error('Error al cargar favoritos:', error);
        this.error = 'Error al cargar los favoritos';
        this.loading = false;
      }
    });
  }

  quitarFavorito(favorito: Favorito, event: Event) {
    event.preventDefault();
    event.stopPropagation();
    
    const usuario = this.authService.getCurrentUser();
    
    if (favorito.idFavorito && usuario) {
      this.favoritosService.removeFavorito(favorito.producto.idProducto, usuario, favorito.idFavorito).subscribe({
        next: () => {
          this.favoritos = this.favoritos.filter(f => f.idFavorito !== favorito.idFavorito);
          console.log('Producto eliminado de favoritos:', favorito.producto.idProducto);
        },
        error: (error: any) => {
          console.error('Error al eliminar favorito:', error);
          alert('Error al eliminar el producto de favoritos');
        }
      });
    }
  }
}