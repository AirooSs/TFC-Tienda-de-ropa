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

import tiendaonline.entities.Favoritos;
import tiendaonline.service.FavoritosService;

@RestController
@RequestMapping("/favoritos")
public class FavoritosRestController {

	@Autowired
	private FavoritosService favoritosService;
	
	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(favoritosService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Integer id) {
		return ResponseEntity.ok(favoritosService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Favoritos favoritos) {
		return ResponseEntity.ok(favoritosService.insertOne(favoritos));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Favoritos favoritos) {
		return ResponseEntity.ok(favoritosService.updateOne(favoritos));
	}

	@DeleteMapping("/{id}")
	ResponseEntity<?> deleteOne(@PathVariable Integer id) {
		favoritosService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}
}
