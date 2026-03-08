import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

export interface Category {
  idCategoria: number;
  nombreCategoria: string;
}

export interface Publico {
  idPublico: number;
  nombrePublico: string;
}

export interface Product {
  idProducto: number;
  nombreProducto: string;
  precioProducto: number;
  stockProducto: number;
  categoria?: Category;
  publico?: Publico;
  imagenUrl?: string;
}

@Injectable({ providedIn: 'root' })
export class ProductsService {

  private baseUrl = `${environment.apiUrl}/productos/`;

  constructor(private http: HttpClient) { }


  list(): Observable<Product[]> {
    return this.http.get<Product[]>(this.baseUrl);
  }

  getById(id: number): Observable<Product> {
    return this.http.get<Product>(`${this.baseUrl}${id}`);
  }

  listByCategoria(nombreCategoria: string): Observable<Product[]> {
    return this.http.get<Product[]>(
      `${environment.apiUrl}/productos/categoria/${encodeURIComponent(nombreCategoria)}`
    );
  }

  searchByNombre(nombre: string): Observable<Product[]> {
    return this.http.get<Product[]>(`${this.baseUrl}buscar`, {
      params: { nombre }
    });
  }

  listByCategoriaYPublico(categoria: string, publico: string): Observable<Product[]> {
    return this.http.get<Product[]>(
      `${environment.apiUrl}/productos/categoria/${encodeURIComponent(categoria)}/publico/${encodeURIComponent(publico)}`
    );
  }
  listByPublico(nombrePublico: string): Observable<Product[]> {
    return this.http.get<Product[]>(
      `${environment.apiUrl}/productos/publico/${encodeURIComponent(nombrePublico)}`
    );
  }
}