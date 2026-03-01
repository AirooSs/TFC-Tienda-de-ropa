import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class EstadoService {
  private loginSource = new Subject<void>();
  login$ = this.loginSource.asObservable();

  notificarLogin() {
    console.log('Notificando login a componentes');
    this.loginSource.next();
  }
}