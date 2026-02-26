package tiendaonline.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import tiendaonline.entities.Usuario;
import tiendaonline.service.UsuarioService;

@RestController
@RequestMapping("/usuarios")
public class UsuarioRestController {

	@Autowired
	private UsuarioService usuarioService;

	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(usuarioService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Integer id) {
		return ResponseEntity.ok(usuarioService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Usuario usuario) {
		return ResponseEntity.ok(usuarioService.insertOne(usuario));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Usuario usuario) {
		return ResponseEntity.ok(usuarioService.updateOne(usuario));
	}

	@DeleteMapping("/{id}")
	ResponseEntity<?> deleteOne(@PathVariable Integer id) {
		usuarioService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}

}
