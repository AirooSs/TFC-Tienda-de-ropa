package tiendaonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tiendaonline.entities.Pedido;

public interface PedidoRepository extends JpaRepository<Pedido, Long>{

}
