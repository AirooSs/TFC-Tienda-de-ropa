import { Component, OnDestroy, OnInit, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Subscription, interval } from 'rxjs';

import { ProductsService, Product } from '../../services/products.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class HomeComponent implements OnInit, OnDestroy {
  private productsService = inject(ProductsService);

  loading = signal(true);

  private productos = signal<Product[]>([]);
  randomProductos = signal<Product[]>([]);

  private rotacionSub?: Subscription;

  isFading = signal(false);
  private animando = false;
  private readonly FADE_MS = 650;

  // 4 rectángulos de las imagenes
  private readonly NUM_A_MOSTRAR = 4;
  private readonly ROTACION_MS = 8000; // 8 segundos para rotar

  ngOnInit(): void {
    this.cargarProductos();
  }

  ngOnDestroy(): void {
    this.rotacionSub?.unsubscribe();
  }

  private cargarProductos(): void {
    this.loading.set(true);

    this.productsService.list().subscribe({
      next: (data) => {
        this.productos.set(Array.isArray(data) ? data : []);
        this.refreshRandom();

        // rotación automática
        this.rotacionSub?.unsubscribe();
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

  refreshRandom(): void {
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