# catalog
App que muestra un catálogo de juegos.

##Arquitectura
MVVM (personalizada)

- Se usa una sola func genérica (Service o UseCase) para hacer todas las llamadas a la API que se adapta a cualquier Request y Response reduciendo el tiempo en generar (Services o UseCase) cada vez que se necesita acceder a un enpoint de la API.

- Reducción de tiempo en programación usando un único contenedor (BackgroundView) que se encarga, en un único lugar, de mostrar las Alerts, Errors, Loading, Content, etc

- Uso de URLProtocols y Mocks para que Test Unitarios y en maquetación (Preview) la App ejecute los servicios correspondientes sin necesidad de salir a Internet y se comporte como si en realidad lo hiciera. Sin tener que realizar modificación en código o creaciones de nuevas func (en caso de Unit Test) para este propósito. 

##Pantalla 1:
Listado de juegos con buscar por nombre y breve descripción

##Pantalla 2:
Detalle de un juego con opción de editar y eliminar

##Pantalla 3:
Editar campos de un juego en específico

##Plus
Unit Test (breve implementación)
