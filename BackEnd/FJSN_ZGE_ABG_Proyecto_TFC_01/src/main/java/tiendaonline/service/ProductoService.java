package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Producto;

public interface ProductoService {
	// CRUD BASICO

	List<Producto> findAll();

	Producto findById(Long id);

	Producto insertOne(Producto producto);

	Producto updateOne(Producto producto);

	int deleteOne(Long id);
}
