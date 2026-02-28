package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import tiendaonline.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    //Metodo para buscar por email 
    Optional<Usuario> findByEmailUsuario(String emailUsuario);

    //Metodo para comprobar si existe un email en la base de datos
    boolean existsByEmailUsuario(String emailUsuario);
}
