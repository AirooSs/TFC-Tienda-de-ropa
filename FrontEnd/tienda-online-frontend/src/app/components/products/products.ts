import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { SubcategoriesComponent } from '../subcategories/subcategories'; 
import { ProductsService, Product } from '../../services/products.service';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, SubcategoriesComponent,RouterLink], //importamos Subcategrías
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class ProductsComponent implements OnInit {

  //usaremos cadenas de string vacías para rellenar según seleccionemos o filtremos:
  categoria: string = '';  //son strings vacíos (mostrarán hombre, mujer o junior)
  subcategoria: string = '';  //string vacío que mostrará la subcategoria seleccionada.

  products$!: Observable<Product[]>; // Productos que vienen del backend

  //proporciona info sobre la ruta actual
  constructor(
    private route: ActivatedRoute,
    private productsService: ProductsService  // Inyectamos el service
  ) {}

  ngOnInit() {
    this.route.params.subscribe(params => {  // Extraemos el parámetro :tipo
      this.categoria = params['tipo'];
      this.subcategoria = params['subcategoria']; // Extraemos el parámetro subcategoria

      // Llamamos al backend ----> (método que filtra por categoría + público)
      this.products$ = this.productsService.listByCategoriaYPublico(this.subcategoria, this.categoria);
    });
  }
}