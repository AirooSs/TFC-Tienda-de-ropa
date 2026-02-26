package tiendaonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tiendaonline.entities.Usuario;
import tiendaonline.repository.UsuarioRepository;

@Service
public class UsuarioServiceImpl implements UsuarioService {

	@Autowired
	private UsuarioRepository usuarioRepository;

	@Override
	public List<Usuario> findAll() {

		return usuarioRepository.findAll();
	}

	@Override
	public Usuario findById(Integer id) {

		return usuarioRepository.findById(id).orElse(null);
	}

	@Override
	public Usuario insertOne(Usuario usuario) {

		return usuarioRepository.save(usuario);
	}

	@Override
	public Usuario updateOne(Usuario usuario) {
		if (usuarioRepository.existsById(usuario.getIdUsuario()))
			return usuarioRepository.save(usuario);
		else
			return null;
	}

	@Override
	public int deleteOne(Integer id) {
		if (usuarioRepository.existsById(id)) {
			usuarioRepository.deleteById(id);
			return 1;
		}
		return 0;
	}

}
