package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

}
