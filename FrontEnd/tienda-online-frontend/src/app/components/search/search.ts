import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './search.html',
  styleUrl: './search.css',
})
export class SearchComponent {
  open = false;
  query = '';

  constructor(private router: Router) { }

  toggle() {
    this.open = !this.open;
    console.log('open:', this.open);
  }


  submit() {
    const q = this.query.trim();
    if (!q) return;

    this.open = false;
    this.router.navigate(['/busqueda'], {
      queryParams: { q }
    });
  }
}

