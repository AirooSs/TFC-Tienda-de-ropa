import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, catchError, forkJoin, Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { CurrentUser } from './auth.service';

export interface Favorito {
  idFavorito?: number;
  producto: {
    idProducto: number;
    nombreProducto: string;
    precioProducto: number;
    stockProducto: number;
    imagenUrl: string;
    categoria?: {
      idCategoria: number;
      nombreCategoria: string;
    };
    publico?: {
      idPublico: number;
      nombrePublico: string;
    };
  };
  usuario?: {
    idUsuario: number;
  };
}

export interface FavoritoLocal {
  idProducto: number;
  fecha: Date;
}

@Injectable({
  providedIn: 'root'
})
export class FavoritosService {
  private apiUrl = `${environment.apiUrl}/favoritos`;
  private readonly LOCAL_STORAGE_KEY = 'favoritos_temp';

  private favoritosSubject = new BehaviorSubject<Favorito[]>([]);
  favoritos$ = this.favoritosSubject.asObservable();

  constructor(private http: HttpClient) { }

  refreshFavoritos(usuario: CurrentUser | null) {
    this.getFavoritos(usuario).subscribe(favs => {
      this.favoritosSubject.next(favs);
    });
  }

  getFavoritos(usuario: CurrentUser | null): Observable<Favorito[]> {
    if (usuario) {
      return this.http.get<Favorito[]>(`${this.apiUrl}/usuario/${usuario.idUsuario}`);
    } else {
      return of(this.getFavoritosLocales().map(f => ({
        idFavorito: undefined,
        producto: {
          idProducto: f.idProducto,
          nombreProducto: 'Cargando...',
          precioProducto: 0,
          stockProducto: 0,
          imagenUrl: ''
        }
      })));
    }
  }

  addFavorito(producto: any, usuario: CurrentUser | null): Observable<any> {
    if (usuario) {
      const favorito = {
        producto: { idProducto: producto.idProducto },
        usuario: { idUsuario: usuario.idUsuario }
      };
      return this.http.post<Favorito>(`${this.apiUrl}/`, favorito);
    } else {
      this.guardarFavoritoLocal(producto.idProducto);
      return of({ success: true, local: true });
    }
  }

  removeFavorito(productoId: number, usuario: CurrentUser | null, favoritoId?: number): Observable<any> {
    if (usuario && favoritoId) {
      return this.http.delete<void>(`${this.apiUrl}/${favoritoId}`);
    } else {
      this.eliminarFavoritoLocal(productoId);
      return of({ success: true, local: true });
    }
  }

  toggleFavorito(producto: any, usuario: CurrentUser | null, favoritoId?: number): Observable<any> {
    const yaEsFavorito = usuario 
      ? favoritoId !== undefined 
      : this.esFavoritoLocal(producto.idProducto);

    if (yaEsFavorito) {
      return this.removeFavorito(producto.idProducto, usuario, favoritoId);
    } else {
      return this.addFavorito(producto, usuario);
    }
  }

  //--------------- MÉTODOS PARA FAVORITOS LOCALES (USUARIOS ANÓNIMOS) ---------------

  private getFavoritosLocales(): FavoritoLocal[] {
    const stored = localStorage.getItem(this.LOCAL_STORAGE_KEY);
    return stored ? JSON.parse(stored) : [];
  }

  private guardarFavoritoLocal(idProducto: number): void {
    const actuales = this.getFavoritosLocales();
    if (!actuales.some(f => f.idProducto === idProducto)) {
      actuales.push({ idProducto, fecha: new Date() });
      localStorage.setItem(this.LOCAL_STORAGE_KEY, JSON.stringify(actuales));
    }
  }

  private limpiarFavoritosLocales(): void {
    localStorage.removeItem(this.LOCAL_STORAGE_KEY);
  }

  // MÉTODOS PÚBLICOS PARA ACCEDER A FAVORITOS LOCALES DESDE OTROS COMPONENTES

  /**
   * Obtiene solo los IDs de los productos favoritos locales
   */
  getFavoritosLocalesIds(): number[] {
    const locales = this.getFavoritosLocales();
    return locales.map(f => f.idProducto);
  }

  /**
   * Elimina un producto de los favoritos locales por su ID
   */
  eliminarFavoritoLocal(idProducto: number): void {
    const actuales = this.getFavoritosLocales();
    const nuevos = actuales.filter(f => f.idProducto !== idProducto);
    localStorage.setItem(this.LOCAL_STORAGE_KEY, JSON.stringify(nuevos));
  }

  /**
   * Verifica si un producto está en favoritos locales
   */
  esFavoritoLocal(productoId: number): boolean {
    const locales = this.getFavoritosLocales();
    return locales.some(f => f.idProducto === productoId);
  }

  /**
   * Obtiene la cantidad de favoritos locales
   */
  getCantidadFavoritosLocales(): number {
    return this.getFavoritosLocales().length;
  }

  //--------------- SINCRONIZACIÓN DE FAVORITOS AL HACER LOGIN ---------------

  /**
   * Sincroniza los favoritos locales con el backend cuando el usuario inicia sesión
   * Crea una petición POST por cada favorito local y las ejecuta todas.
   * Si el favorito ya existe (error 409) lo ignora.
   * Espera a que todas las peticiones terminen antes de limpiar localStorage
   */
  sincronizarFavoritosAlLogin(usuario: CurrentUser): Observable<any> {
    const locales = this.getFavoritosLocales();
    console.log('Sincronizando favoritos locales:', locales);

    if (locales.length === 0) {
      return of({ sincronizados: 0 });
    }

    // Crear una petición POST para cada favorito local
    const peticiones = locales.map(local => {
      const favorito = {
        producto: { idProducto: local.idProducto },
        usuario: { idUsuario: usuario.idUsuario }
      };
      console.log('Enviando favorito al backend:', favorito);
      return this.http.post<Favorito>(`${this.apiUrl}/`, favorito).pipe(
        catchError(error => {
          console.log('Error al sincronizar favorito:', local.idProducto, error);
          // Si el error es 409 (duplicado), lo ignoramos (ya existe)
          if (error.status === 409) {
            console.log('El producto ya existía en favoritos:', local.idProducto);
            return of({ success: true, alreadyExists: true });
          }
          return of({ success: false, error: error, idProducto: local.idProducto });
        })
      );
    });

    // Usar forkJoin para esperar a que TODAS las peticiones terminen
    return new Observable(observer => {
      forkJoin(peticiones).subscribe({
        next: (resultados) => {
          console.log('Resultados de sincronización:', resultados);
          // Limpiar localStorage SOLO después de sincronizar
          this.limpiarFavoritosLocales();
          observer.next({ sincronizados: resultados.length, detalles: resultados });
          observer.complete();
        },
        error: (error) => {
          console.error('Error grave en sincronización:', error);
          observer.error(error);
        }
      });
    });
  }
}