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
  private todosLosProductos: Product[] = [];

  loading = signal(true);
  private productos = signal<Product[]>([]);
  randomProductos = signal<Product[]>([]);
  esJunior = signal(false);

  isFading = signal(false);
  private animando = false;

  private rotacionSub?: Subscription;
  private routeSub?: Subscription;

  private readonly NUM_A_MOSTRAR = 8;
  private readonly ROTACION_MS = 5000;
  private readonly FADE_MS = 650;

  ngOnInit(): void {
    this.productsService.list().subscribe({
      next: (data) => {
        this.todosLosProductos = Array.isArray(data) ? data : [];
        console.log('Productos cargados:', this.todosLosProductos.length);
        
        const t0 = (this.route.snapshot.paramMap.get('tipo') || '').toLowerCase();
        this.tipo = t0;
        this.filtrarYMostrar();
        
        this.loading.set(false);
      },
      error: () => {
        this.todosLosProductos = [];
        this.loading.set(false);
      }
    });

    this.routeSub = this.route.paramMap.subscribe((params) => {
      const t = (params.get('tipo') || '').toLowerCase();
      if (t && t !== this.tipo) {
        this.tipo = t;
        this.filtrarYMostrar();
      }
    });
  }

  private filtrarYMostrar(): void {
    this.rotacionSub?.unsubscribe();
    
    const publicoBuscado = this.mapPublicoParaBackend(this.tipo);
    this.esJunior.set(publicoBuscado === 'Junior');
    
    const filtrados = this.todosLosProductos.filter(p => 
      p.publico && p.publico.nombrePublico === publicoBuscado
    );
    
    this.productos.set(filtrados);
    this.refreshRandom();

    if (filtrados.length > 0) {
      this.rotacionSub = interval(this.ROTACION_MS).subscribe(() => {
        this.refreshRandom();
      });
    }
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

  ngOnDestroy(): void {
    this.rotacionSub?.unsubscribe();
    this.routeSub?.unsubscribe();
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