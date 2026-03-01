package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Favoritos;

public interface FavoritosService {
	// CRUD BASICO

	List<Favoritos> findAll();

	Favoritos findById(Integer id);

	Favoritos insertOne(Favoritos favoritos);

	Favoritos updateOne(Favoritos favoritos);

	int deleteOne(Integer id);
	
	//Método para la busqueda por usuario
	List<Favoritos> findByUsuarioId(Integer idUsuario);
	
	
	Favoritos findByUsuarioAndProducto(
			Integer idUsuario, 
			Integer idProducto
			);
	
	
	
	
	
}
