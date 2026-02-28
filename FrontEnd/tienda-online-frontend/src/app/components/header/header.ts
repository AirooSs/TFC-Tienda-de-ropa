import { Component, inject } from '@angular/core';
import { RouterModule, Router } from '@angular/router';
import { SearchComponent } from '../search/search';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [RouterModule, SearchComponent],
  templateUrl: './header.html',
  styleUrl: './header.css',
})
export class HeaderComponent {

  private auth = inject(AuthService);
  private router = inject(Router);

  get isLogged(): boolean {
    return this.auth.isLogged();
  }

  get nombre(): string | null {
    return this.auth.getName();
  }

  logout() {
    this.auth.logout();
    this.router.navigateByUrl('/login');
  }
}