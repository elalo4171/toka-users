# Toka aplicación para entrevista
Para acceder a la app el usuario por default es:
Email: z@z.com
Password: 123456

La aplicación debe tener los siguientes requerimientos:
* Iniciar sesión
* Conservar la sesión al cerrar la aplicación
* Cerrar sesión
* Guardar usuarios en la base de datos
* Cargar usuario desde [Random User Generator | Home](https://randomuser.me)

Un requerimiento que agregue extra es el de editar un usuario.

Para tener la conexión con la base de datos cree un provider que se inicia cuando se abre la app para que en ese momento se carguen los datos de la base de datos, y en caso de que no estén cargados los perfiles de los doctores se cargan con una petición http.
Para saber si el usuario tiene iniciada la sesion en el dispositivo cree una tabla en la base de datos para almacenar el usuario que inicio sesion. Para leer esta tabla tuve que poner un StreamBuilder en el main el cual muestra un CircularProgressIndicator el cual se muestra en lo que se lee la información.
Para mostrar los usuarios simplemente use un ListView Builder, por si se edita un usuario se vuelvan a cargar desde la BD. 