package tiendaonline.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {

    //Filtro productos por nombre de categoria
    List<Producto> findByCategoria_NombreCategoriaIgnoreCase(String nombreCategoria);

    //Busco productos por su nombre
    List<Producto> findByNombreProductoContainingIgnoreCase(String nombreProducto);

}
