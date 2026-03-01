package tiendaonline.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import tiendaonline.entities.Favoritos;

public interface FavoritosRepository extends JpaRepository<Favoritos, Integer>{

	
    // Metodo para buscar por ID de usuario
    List<Favoritos> findByUsuarioIdUsuario(Integer idUsuario);
	
	
    @Query("SELECT f FROM Favoritos f WHERE f.usuario.idUsuario = :idUsuario AND f.producto.idProducto = :idProducto")
    Favoritos findByUsuarioAndProducto(@Param("idUsuario") Integer idUsuario, @Param("idProducto") Integer idProducto);
    
    
}
