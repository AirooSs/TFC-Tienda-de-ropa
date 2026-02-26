package tiendaonline.service;

import java.util.List;
import tiendaonline.entities.Pedido;

public interface PedidoService {

	//CRUD BASICO
	
	List<Pedido> findAll();

	Pedido findById(Integer id);

	Pedido insertOne(Pedido pedido);

	Pedido updateOne(Pedido pedido);

	int deleteOne(Integer id);
}
