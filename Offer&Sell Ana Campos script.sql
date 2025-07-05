CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(150) NOT NULL,
  correo VARCHAR(150) NOT NULL UNIQUE,
  telefono VARCHAR(20),
  password VARCHAR(255) NOT NULL,
  foto_perfil VARCHAR(255),
  fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario)
);

CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_categoria)
);

CREATE TABLE producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_categoria INT NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10,2) NOT NULL,
  estado ENUM('nuevo','usado') NOT NULL,
  fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  vendido BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (id_producto),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE producto_imagen (
  id_imagen INT NOT NULL AUTO_INCREMENT,
  id_producto INT NOT NULL,
  url_imagen VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_imagen),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE favorito (
  id_favorito INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_producto INT NOT NULL,
  PRIMARY KEY (id_favorito),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE chat (
  id_chat INT NOT NULL AUTO_INCREMENT,
  id_producto INT NOT NULL,
  id_usuario1 INT NOT NULL,
  id_usuario2 INT NOT NULL,
  fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_chat),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_usuario1) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_usuario2) REFERENCES usuario(id_usuario)
);

CREATE TABLE mensaje (
  id_mensaje INT NOT NULL AUTO_INCREMENT,
  id_chat INT NOT NULL,
  id_remitente INT NOT NULL,
  mensaje TEXT NOT NULL,
  fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_mensaje),
  FOREIGN KEY (id_chat) REFERENCES chat(id_chat),
  FOREIGN KEY (id_remitente) REFERENCES usuario(id_usuario)
);

CREATE TABLE metodo_pago (
  id_metodo_pago INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_metodo_pago)
);

INSERT INTO metodo_pago (nombre) VALUES
('Nequi'),
('Bancolombia'),
('Daviplata'),
('PSE'),
('Contraentrega');

CREATE TABLE transaccion (
  id_transaccion INT NOT NULL AUTO_INCREMENT,
  id_producto INT NOT NULL,
  id_comprador INT NOT NULL,
  id_vendedor INT NOT NULL,
  id_metodo_pago INT NOT NULL,
  precio_final DECIMAL(10,2) NOT NULL,
  fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_transaccion),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_comprador) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_vendedor) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago)
);

CREATE TABLE valoracion (
  id_valoracion INT NOT NULL AUTO_INCREMENT,
  id_usuario_valorado INT NOT NULL,
  id_usuario_valorador INT NOT NULL,
  calificacion TINYINT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
  comentario TEXT,
  fecha_valoracion DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_valoracion),
  FOREIGN KEY (id_usuario_valorado) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_usuario_valorador) REFERENCES usuario(id_usuario)
);

CREATE TABLE reporte (
  id_reporte INT NOT NULL AUTO_INCREMENT,
  id_usuario_reporta INT NOT NULL,
  id_usuario_reportado INT,
  id_producto_reportado INT,
  motivo VARCHAR(255) NOT NULL,
  descripcion TEXT,
  fecha_reporte DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_reporte),
  FOREIGN KEY (id_usuario_reporta) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_usuario_reportado) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_producto_reportado) REFERENCES producto(id_producto)
);
