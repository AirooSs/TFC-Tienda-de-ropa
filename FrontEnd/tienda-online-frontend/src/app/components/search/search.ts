import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, NavigationEnd } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [FormsModule, CommonModule, MatIconModule],
  templateUrl: './search.html',
  styleUrl: './search.css',
})
export class SearchComponent {
  open = false;
  query = '';

  constructor(private router: Router) {
    // Limpia el search cuando sales de la busqueda
    this.router.events
      .pipe(filter((event): event is NavigationEnd => event instanceof NavigationEnd))
      .subscribe((event) => {
        const url = event.urlAfterRedirects;

        if (!url.startsWith('/busqueda')) {
          this.query = '';
          this.open = false;
        }
      });
  }

  toggle() {
    this.open = !this.open;
  }

  submit() {
    const q = this.query.trim();
    if (!q) return;

    this.router.navigate(['/busqueda'], {
      queryParams: { nombre: q }
    });
  }
}
