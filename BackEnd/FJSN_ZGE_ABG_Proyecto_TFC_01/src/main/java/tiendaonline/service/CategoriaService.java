package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Categoria;


public interface CategoriaService {

	//CRUD BASICO
	
	List<Categoria> findAll();

	Categoria findById(Long id);

	Categoria insertOne(Categoria categoria);

	Categoria updateOne(Categoria categoria);

	int deleteOne(Long id);
	
}
