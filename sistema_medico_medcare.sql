-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-05-2026 a las 03:43:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_medico_medcare`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `id_calificacion` int(11) NOT NULL,
  `puntuacion` int(11) DEFAULT NULL CHECK (`puntuacion` >= 1 and `puntuacion` <= 5),
  `comentario` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`id_calificacion`, `puntuacion`, `comentario`, `fecha`) VALUES
(1, 5, 'Buena atencion medica, doctor recomendado', '2026-04-30 11:08:16'),
(2, 5, 'ok', '2026-04-30 12:33:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas_medicas`
--

CREATE TABLE `citas_medicas` (
  `id_cita` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  `id_calificacion` int(11) DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `notas_adicionales` text DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `hora_fin` time DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `motivo_cambio` text DEFAULT NULL,
  `reprogramada_por` varchar(20) DEFAULT NULL,
  `confirmacion_asistencia` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `citas_medicas`
--

INSERT INTO `citas_medicas` (`id_cita`, `id_paciente`, `id_medico`, `id_calificacion`, `motivo`, `notas_adicionales`, `fecha`, `hora`, `hora_fin`, `estado`, `motivo_cambio`, `reprogramada_por`, `confirmacion_asistencia`) VALUES
(1, 1, 1, 1, 'dolor en el pecho', NULL, '2026-04-30', '11:00:00', NULL, 'Completada', NULL, NULL, 0),
(2, 1, 1, NULL, 'dolor de cabeza', NULL, '2026-05-13', '11:30:00', NULL, 'Cancelada', NULL, NULL, 0),
(3, 2, 1, 2, 'dolor en el pecho', NULL, '2026-04-30', '00:00:00', NULL, 'Completada', NULL, NULL, 0),
(4, 2, 1, NULL, 'dolor de cabeza', 'dolor de cabeza', '2026-05-05', '18:00:00', '19:00:00', 'Cancelada', 'Lo siento querido paciente, no podre atender esta consulta debido a que tengo otros casos mas importantes, porfavor le pido que vuelva a genera una cita pero seleccione la especialidad general', 'paciente', 0),
(5, 2, 1, NULL, 'dolor en el pecho', '', '2026-05-18', '15:00:00', '16:00:00', 'Programada', NULL, NULL, 1),
(6, 2, 1, NULL, 'Infarto previo', '', '2026-05-28', '10:00:00', '11:00:00', 'Programada', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

CREATE TABLE `direcciones` (
  `id_direccion` int(11) NOT NULL,
  `departamento` varchar(100) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `residencia_detalle` varchar(255) DEFAULT NULL,
  `pasaje_poligono_calle` varchar(100) DEFAULT NULL,
  `numero_casa` varchar(20) DEFAULT NULL,
  `punto_referencia` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`id_direccion`, `departamento`, `municipio`, `distrito`, `residencia_detalle`, `pasaje_poligono_calle`, `numero_casa`, `punto_referencia`) VALUES
(1, 'San Salvador', 'Soyapango', NULL, 'Margaritas, pasaje 10, casa 66', NULL, NULL, NULL),
(2, 'San Salvador', 'Soyapango', '', 'San jose 2, avn principal pj 18', '', '77', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id_especialidad` int(11) NOT NULL,
  `nombre_especialidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id_especialidad`, `nombre_especialidad`) VALUES
(1, 'Medicina General'),
(2, 'Cardiología'),
(3, 'Pediatría');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expedientes_clinicos`
--

CREATE TABLE `expedientes_clinicos` (
  `id_expediente` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `diagnostico` text DEFAULT NULL,
  `tratamiento` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_medicos`
--

CREATE TABLE `horarios_medicos` (
  `id_horario` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  `dia_semana` varchar(20) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `descanso_inicio` time DEFAULT NULL,
  `descanso_fin` time DEFAULT NULL,
  `es_dia_descanso` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios_medicos`
--

INSERT INTO `horarios_medicos` (`id_horario`, `id_medico`, `dia_semana`, `hora_inicio`, `hora_fin`, `descanso_inicio`, `descanso_fin`, `es_dia_descanso`) VALUES
(1, 1, 'Lunes', '08:00:00', '17:00:00', '12:00:00', '13:30:00', 0),
(2, 1, 'Martes', '11:00:00', '21:30:00', '02:00:00', '03:00:00', 0),
(3, 1, 'Domingo', NULL, NULL, NULL, NULL, 1),
(4, 1, 'Sábado', NULL, NULL, NULL, NULL, 1),
(5, 1, 'Miércoles', '11:30:00', '21:00:00', '04:30:00', '05:30:00', 0),
(6, 1, 'Viernes', NULL, NULL, NULL, NULL, 1),
(7, 1, 'Jueves', '00:00:00', '12:00:00', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `id_medico` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_especialidad` int(11) NOT NULL,
  `numero_colegiado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`id_medico`, `id_usuario`, `id_especialidad`, `numero_colegiado`) VALUES
(1, 2, 2, 'COL-12345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje_recordatorio` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `leida` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id_notificacion`, `id_usuario`, `mensaje_recordatorio`, `fecha`, `leida`) VALUES
(1, 1, 'Su cita ha sido programada para el 2026-04-30 a las 11:00', '2026-04-30 11:05:49', 0),
(2, 1, 'Su cita ha sido programada para el 2026-05-13 a las 11:30', '2026-04-30 11:21:32', 0),
(3, 1, 'Su cita ha sido programada para el 2026-04-30 a las 00:00', '2026-04-30 11:57:57', 0),
(4, 4, 'Su cita ha sido programada para el 2026-05-04 a las 08:00', '2026-04-30 13:01:56', 0),
(5, 4, 'Su cita ha sido programada para el 2026-05-18 a las 15:00', '2026-04-30 13:06:46', 0),
(6, 2, '✅ El paciente Kevin Portillo confirmó su asistencia para la cita del 18/05/2026 a las 3:00 PM.', '2026-04-30 13:30:54', 1),
(7, 4, 'Su cita ha sido programada para el 2026-05-28 a las 10:00', '2026-04-30 19:16:33', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_direccion` int(11) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `edad` int(11) GENERATED ALWAYS AS (year(curdate()) - year(`fecha_nacimiento`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `id_usuario`, `id_direccion`, `fecha_nacimiento`, `genero`) VALUES
(1, 3, 1, '2005-06-13', 'M'),
(2, 4, 2, '2006-11-05', 'M');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Doctor'),
(3, 'Paciente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `primer_nombre` varchar(50) NOT NULL,
  `segundo_nombre` varchar(50) DEFAULT NULL,
  `primer_apellido` varchar(50) NOT NULL,
  `segundo_apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `id_rol`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `correo`, `contrasena`, `telefono`) VALUES
(1, 1, 'Super', NULL, 'Administrador', NULL, 'admin@medcare.com', '$2y$10$zVoPWn.DxoSjCqOdRWmD4.Ng8zSDIH4ooJWc8slxDJP4qoLXgjFRu', '00000000'),
(2, 2, 'Roberto', NULL, 'Martínez', NULL, 'doctor@medcare.com', '$2y$10$e2qQfbzyADaBj9O46WW8V.a19ewJc4.kmY/XzJXAVSEMu19L6NzOq', '11111111'),
(3, 3, 'Raul', 'Alejandro', 'Pineda', 'Vasquez', 'kdiaz.sistec@gmail.com', '$2y$10$/rl.pbjFkCeSDoflNoC0W.DgzFD0IG8.NqqL5tUjcin1xSAdyYqgu', '7010-2794'),
(4, 3, 'Kevin', 'Samuel', 'Portillo', 'Diaz', 'kevinportillosd56@gmail.com', '$2y$10$SCKm0j4IAo7fXbih/32nkeD5hq9RZMsMzM/Zd6i8d2qjrDUuIPNHG', '7843-7638');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id_calificacion`);

--
-- Indices de la tabla `citas_medicas`
--
ALTER TABLE `citas_medicas`
  ADD PRIMARY KEY (`id_cita`),
  ADD UNIQUE KEY `id_calificacion` (`id_calificacion`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`id_direccion`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id_especialidad`);

--
-- Indices de la tabla `expedientes_clinicos`
--
ALTER TABLE `expedientes_clinicos`
  ADD PRIMARY KEY (`id_expediente`),
  ADD KEY `id_paciente` (`id_paciente`);

--
-- Indices de la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD PRIMARY KEY (`id_horario`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id_medico`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD UNIQUE KEY `numero_colegiado` (`numero_colegiado`),
  ADD KEY `id_especialidad` (`id_especialidad`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_direccion` (`id_direccion`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `citas_medicas`
--
ALTER TABLE `citas_medicas`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `id_direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `expedientes_clinicos`
--
ALTER TABLE `expedientes_clinicos`
  MODIFY `id_expediente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id_medico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas_medicas`
--
ALTER TABLE `citas_medicas`
  ADD CONSTRAINT `citas_medicas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  ADD CONSTRAINT `citas_medicas_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`),
  ADD CONSTRAINT `citas_medicas_ibfk_3` FOREIGN KEY (`id_calificacion`) REFERENCES `calificaciones` (`id_calificacion`);

--
-- Filtros para la tabla `expedientes_clinicos`
--
ALTER TABLE `expedientes_clinicos`
  ADD CONSTRAINT `expedientes_clinicos_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE;

--
-- Filtros para la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD CONSTRAINT `horarios_medicos_ibfk_1` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`) ON DELETE CASCADE;

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicos_ibfk_2` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `pacientes_ibfk_2` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones` (`id_direccion`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
