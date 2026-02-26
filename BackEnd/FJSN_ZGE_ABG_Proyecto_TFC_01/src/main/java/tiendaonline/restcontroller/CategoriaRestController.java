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

import tiendaonline.entities.Categoria;
import tiendaonline.service.CategoriaService;

@RestController
@RequestMapping("/categoria")
public class CategoriaRestController {

	@Autowired
	private CategoriaService categoriaService;
	
	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(categoriaService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Integer id) {
		return ResponseEntity.ok(categoriaService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Categoria categoria) {
		return ResponseEntity.ok(categoriaService.insertOne(categoria));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Categoria categoria) {
		return ResponseEntity.ok(categoriaService.updateOne(categoria));
	}

	@DeleteMapping("/{id}")
	ResponseEntity<?> deleteOne(@PathVariable Integer id) {
		categoriaService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}
}
