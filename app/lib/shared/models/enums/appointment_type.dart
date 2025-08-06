enum ModelEnum_AppointmentType {
  consultaGeneral('Consulta General', 'consulta_general'),
  control('Control', 'control'),
  procedimiento('Procedimiento', 'procedimiento'),
  cirugia('Cirugía', 'cirugia'),
  terapia('Terapia', 'terapia'),
  examen('Examen', 'examen'),
  otro('Otro', 'otro');

  final String name;
  final String key;
  const ModelEnum_AppointmentType(this.name, this.key);
}
