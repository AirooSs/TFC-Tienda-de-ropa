package tiendaonline.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {

    //Filtro productos por nombre de categoria
    List<Producto> findByCategoria_NombreCategoriaIgnoreCase(String nombreCategoria);

    //Busco productos por su nombre
    List<Producto> findByNombreProductoContainingIgnoreCase(String nombreProducto);

    //Filtramos productos por categoria y publico. ¡Necesario para filtrarlo correctamente!
    List<Producto> findByCategoria_NombreCategoriaIgnoreCaseAndPublico_NombrePublicoIgnoreCase(
    		String nombreCategoria, 
    		String nombrePublico
    		);
    
    //Filtro necesario por tipo de público
    List<Producto> findByPublico_NombrePublicoIgnoreCase(String nombrePublico);
     
    
}
