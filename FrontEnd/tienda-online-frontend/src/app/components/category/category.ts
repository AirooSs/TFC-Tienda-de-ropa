import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { SubcategoriesComponent } from '../subcategories/subcategories';

@Component({
  selector: 'app-category',
  standalone: true,
  imports: [CommonModule, SubcategoriesComponent],
  templateUrl: './category.html',
  styleUrl: './category.css'
})
export class CategoryComponent implements OnInit {
  categoria: string = '';

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.categoria = params['tipo'];
      console.log(`Cargando página de categoría: ${this.categoria}`);
      
      // justo Aquí cargaremoos: productos destacados, novedades, etc.
    });
  }
}