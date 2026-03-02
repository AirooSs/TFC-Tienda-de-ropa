import { Component, OnDestroy, OnInit, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { Subscription, interval } from 'rxjs';

import { ProductsService, Product } from '../../services/products.service';
import { SubcategoriesComponent } from '../subcategories/subcategories';

@Component({
  selector: 'app-category',
  standalone: true,
  imports: [CommonModule, RouterModule, SubcategoriesComponent],
  templateUrl: './category.html',
  styleUrl: './category.css',
})
export class CategoryComponent implements OnInit, OnDestroy {
  private route = inject(ActivatedRoute);
  private productsService = inject(ProductsService);

  tipo = '';

  loading = signal(true);
  private productos = signal<Product[]>([]);
  randomProductos = signal<Product[]>([]);

  isFading = signal(false);
  private animando = false;

  private rotacionSub?: Subscription;
  private routeSub?: Subscription;

  private readonly NUM_A_MOSTRAR = 8;
  private readonly ROTACION_MS = 5000; // 5 segundos
  private readonly FADE_MS = 650;

  ngOnInit(): void {
    const t0 = (this.route.snapshot.paramMap.get('tipo') || '').toLowerCase();
    this.tipo = t0;
    this.cargarPorPublico();

    this.routeSub = this.route.paramMap.subscribe((params) => {
      const t = (params.get('tipo') || '').toLowerCase();
      if (t && t !== this.tipo) {
        this.tipo = t;
        this.cargarPorPublico();
      }
    });
  }

  ngOnDestroy(): void {
    this.rotacionSub?.unsubscribe();
    this.routeSub?.unsubscribe();
  }

  private cargarPorPublico(): void {
    this.loading.set(true);
    this.rotacionSub?.unsubscribe();

    const publicoBackend = this.mapPublicoParaBackend(this.tipo);

    // Requiere que añadas listByPublico() en ProductsService
    this.productsService.listByPublico(publicoBackend).subscribe({
      next: (data) => {
        this.productos.set(Array.isArray(data) ? data : []);
        this.refreshRandom();

        this.rotacionSub = interval(this.ROTACION_MS).subscribe(() => {
          this.refreshRandom();
        });

        this.loading.set(false);
      },
      error: () => {
        this.productos.set([]);
        this.randomProductos.set([]);
        this.loading.set(false);
      },
    });
  }

  private mapPublicoParaBackend(tipo: string): string {
    const t = (tipo || '').toLowerCase();

    if (t === 'hombre') return 'Hombre';
    if (t === 'mujer') return 'Mujer';
    if (t === 'junior') return 'Junior';
    if (t === 'nino' || t === 'niño') return 'Junior';

    return tipo;
  }

  private refreshRandom(): void {
    if (this.animando) return;

    const lista = this.productos();
    if (!lista || lista.length === 0) {
      this.randomProductos.set([]);
      return;
    }

    this.animando = true;
    this.isFading.set(true);

    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        setTimeout(() => {
          const mezclada = [...lista].sort(() => Math.random() - 0.5);
          this.randomProductos.set(
            mezclada.slice(0, Math.min(this.NUM_A_MOSTRAR, mezclada.length))
          );

          requestAnimationFrame(() => {
            this.isFading.set(false);
            setTimeout(() => {
              this.animando = false;
            }, this.FADE_MS);
          });
        }, this.FADE_MS);
      });
    });
  }

  getImagen(p: Product): string {
    return p.imagenUrl && p.imagenUrl.trim().length > 0
      ? p.imagenUrl
      : 'assets/img/producto-placeholder.png';
  }

  onImgError(ev: Event): void {
    const img = ev.target as HTMLImageElement;
    img.src = 'assets/img/producto-placeholder.png';
  }
}