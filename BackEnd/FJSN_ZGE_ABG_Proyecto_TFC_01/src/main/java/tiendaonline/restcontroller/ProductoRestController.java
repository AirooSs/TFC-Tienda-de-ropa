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

import tiendaonline.entities.Producto;
import tiendaonline.service.ProductoService;

@RestController
@RequestMapping("/productos")
public class ProductoRestController {

	@Autowired
	private ProductoService productoService;

	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(productoService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Long id) {
		return ResponseEntity.ok(productoService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody Producto producto) {
		return ResponseEntity.ok(productoService.insertOne(producto));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody Producto producto) {
		return ResponseEntity.ok(productoService.updateOne(producto));
	}

	@DeleteMapping("{id}")
	ResponseEntity<?> deleteOne(@PathVariable Long id) {
		productoService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}

}
