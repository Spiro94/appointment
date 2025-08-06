/// Enum for capture methods used to create appointments
enum ModelEnum_CaptureMethod {
  audio('Audio'),
  image('Imagen'),
  text('Texto');

  final String name;
  const ModelEnum_CaptureMethod(this.name);
}
