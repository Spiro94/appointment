enum ModelEnum_AppointmentType {
  consultaGeneral('Consulta General'),
  control('Control'),
  procedimiento('Procedimiento'),
  cirugia('Cirugía'),
  terapia('Terapia'),
  examen('Examen'),
  otro('Otro') ;

  final String name;
  const ModelEnum_AppointmentType(this.name);
}
