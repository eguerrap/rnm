# rnm

Un proyecto Flutter para visualizar personajes de la serie Rick y Morty.

## Descripción

Esta aplicación permite a los usuarios buscar y visualizar detalles de los personajes de la serie Rick y Morty. Utiliza la API pública de Rick and Morty para obtener los datos de los personajes.

## Arquitectura

El proyecto utiliza una arquitectura limpia (Clean Architecture) que se divide en tres capas principales:

1. **Capa de Dominio (Domain Layer)**: Contiene las entidades, casos de uso y repositorios.
2. **Capa de Datos (Data Layer)**: Maneja la obtención de datos a través de fuentes remotas o locales. Aquí se encuentran los modelos y las implementaciones de los repositorios.
3. **Capa de Presentación (Presentation Layer)**: Contiene las interfaces de usuario (UI), los proveedores (providers) y la lógica de presentación.

### Propósito de los Archivos y Capas

- **Entidades (Entities)**: Son objetos simples que representan los datos de dominio.
- **Casos de Uso (Use Cases)**: Contienen la lógica de negocio y son llamados desde la capa de presentación.
- **Repositorios (Repositories)**: Definen las interfaces para acceder a los datos. Las implementaciones de estos repositorios se encuentran en la capa de datos.
- **Fuentes de Datos (Data Sources)**: Son responsables de la obtención de datos desde una fuente remota (API) o local (base de datos).
- **Modelos (Models)**: Son las representaciones de los datos que se reciben o se envían a las fuentes de datos.
- **Proveedores (Providers)**: Manejan el estado de la UI y coordinan la interacción entre la UI y los casos de uso.

## Configuración del Proyecto

### Requisitos Previos

- Flutter SDK
- Dart SDK

### Instalación

1. Clona el repositorio:
    ```sh
    git clone https://github.com/eguerrap/rnm.git
    ```
2. Navega al directorio del proyecto:
    ```sh
    cd rnm
    ```
3. Instala las dependencias:
    ```sh
    flutter pub get
    ```

## Ejecución de la Aplicación

Para ejecutar la aplicación en modo de desarrollo, usa el siguiente comando:
```sh
flutter run
