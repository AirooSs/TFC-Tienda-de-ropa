package tiendaonline.service;

import java.util.List;

import tiendaonline.entities.Usuario;

public interface UsuarioService {

	//CRUD BASICO
	
	List<Usuario> findAll();

	Usuario findById(Integer id);

	Usuario insertOne(Usuario usuario);

	Usuario updateOne(Usuario usuario);

	int deleteOne(Integer id);

}
