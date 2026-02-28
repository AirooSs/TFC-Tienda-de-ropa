package tiendaonline.security;

import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import tiendaonline.entities.Usuario;
import tiendaonline.repository.UsuarioRepository;

import java.util.List;

@Service
public class UsuarioDetailsService implements UserDetailsService {

  private final UsuarioRepository usuarioRepository;

  public UsuarioDetailsService(UsuarioRepository usuarioRepository) {
    this.usuarioRepository = usuarioRepository;
  }

  @Override
  public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
    Usuario u = usuarioRepository.findByEmailUsuario(email)
        .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

    String role = "ROLE_" + u.getRole();

    return new org.springframework.security.core.userdetails.User(
        u.getEmailUsuario(),
        u.getPasswordUsuario(),
        List.of(new org.springframework.security.core.authority.SimpleGrantedAuthority(role))
    );
  }
}