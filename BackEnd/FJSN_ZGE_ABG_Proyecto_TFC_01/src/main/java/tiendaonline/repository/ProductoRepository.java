package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Long> {

}
