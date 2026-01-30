import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { SubcategoriesComponent } from '../subcategories/subcategories'; 

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, SubcategoriesComponent], //importamos Subcategrías
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class ProductsComponent implements OnInit {

  //usaremos cadenas de string vacías para rellenar según seleccionemos o filtremos:
  categoria: string = '';  //son strings vacíos (mostrarán hombre, mujer o junior)
  subcategoria: string = '';  //string vacío que mostrará la subcategoria seleccionada.

  //proporciona info sobre la ruta actual
  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    this.route.params.subscribe(params => {  //extraemos el parámetro :tipo
      this.categoria = params['tipo'];
      this.subcategoria = params['subcategoria']; //extraemos el parámetro subcategoria
    });
  }
}