package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Producto;

public interface ProductoService {
	// CRUD BASICO

	List<Producto> findAll();

	Producto findById(Integer id);

	Producto insertOne(Producto producto);

	Producto updateOne(Producto producto);

	int deleteOne(Integer id);

	//Filtro productos por nombre de categoria
	List<Producto> findByCategoriaNombre(String nombreCategoria);

	//Busco producto por su nombre

	List<Producto> findByNombre(String nombreProducto);
	
	//filtro por categoria y público:
	List<Producto> findByCategoriaYPublico(
			String nombreCategoria,
			String nombrePublico
			);
	//filtro por público
	List<Producto> findByPublicoNombre(String nombrePublico);
	
}
