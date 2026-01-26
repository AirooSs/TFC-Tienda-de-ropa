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

import tiendaonline.entities.DetallePedido;
import tiendaonline.service.DetallePedidoService;

@RestController
@RequestMapping("/detalle")
public class DetallePedidoRestController {

	@Autowired
	private DetallePedidoService detallePedidoService;
	
	@GetMapping("/")
	ResponseEntity<?> todos() {
		return ResponseEntity.ok(detallePedidoService.findAll());
	}

	@GetMapping("/{id}")
	ResponseEntity<?> uno(@PathVariable Long id) {
		return ResponseEntity.ok(detallePedidoService.findById(id));
	}

	@PostMapping("/")
	ResponseEntity<?> insertOne(@RequestBody DetallePedido detalle) {
		return ResponseEntity.ok(detallePedidoService.insertOne(detalle));
	}

	@PutMapping("/")
	ResponseEntity<?> updateOne(@RequestBody DetallePedido detalle) {
		return ResponseEntity.ok(detallePedidoService.updateOne(detalle));
	}

	@DeleteMapping("{id}")
	ResponseEntity<?> deleteOne(@PathVariable Long id) {
		detallePedidoService.deleteOne(id);
		return ResponseEntity.noContent().build();
	}
}
