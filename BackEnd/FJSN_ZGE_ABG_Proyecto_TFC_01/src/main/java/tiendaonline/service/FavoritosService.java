package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Favoritos;

public interface FavoritosService {
	// CRUD BASICO

	List<Favoritos> findAll();

	Favoritos findById(Long id);

	Favoritos insertOne(Favoritos favoritos);

	Favoritos updateOne(Favoritos favoritos);

	int deleteOne(Long id);
}
