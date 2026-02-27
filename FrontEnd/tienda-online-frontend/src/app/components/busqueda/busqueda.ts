import { Component, inject, signal } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Product, ProductsService } from '../../services/products.service';

@Component({
  selector: 'app-busqueda',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './busqueda.html',
  styleUrl: './busqueda.css',
})
export class BusquedaComponent {

  private route = inject(ActivatedRoute);
  private productsService = inject(ProductsService);

  loading = signal(false);
  results = signal<Product[]>([]);
  nombre = signal('');

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const nombre = (params.get('nombre') ?? '').trim();

      this.nombre.set(nombre);

      if (!nombre) {
        this.results.set([]);
        return;
      }

      this.loading.set(true);

      this.productsService.searchByNombre(nombre).subscribe({
        next: (res) => {
          this.results.set(res ?? []);
          this.loading.set(false);
        },
        error: () => {
          this.results.set([]);
          this.loading.set(false);
        }
      });
    });
  }
}