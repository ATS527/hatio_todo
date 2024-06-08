                         
<br/>
<div align="center">

<h3 align="center">Hatio Todo Application</h3>
<p align="center">
A Web Application Submission as part of Take Home Challenge by Hatio.

<br/>
<br/>
  
<a href="https://github.com/ShaanCoding/ReadME-Generator/issues/new?labels=bug&template=bug-report---.md">Report Bug .</a>
<a href="https://github.com/ShaanCoding/ReadME-Generator/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
</p>
</div>

 ## About The Project

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/yr53kaMzu50/0.jpg)](https://www.youtube.com/watch?v=yr53kaMzu50 "Hatio Todo Application Working Video")
Working Video

This project is a comprehensive task management application developed using Flutter for the frontend and Node.js for the backend, with PostgreSQL serving as the database. Sequelize is employed as the ORM to facilitate database operations. For state management, the Bloc library is utilized, enabling a structured flow of events and states to control the application's logic. Users can register and log in to the application, with authentication managed through JWT and cookies. Once authenticated, users can create and manage projects, each of which can have multiple to-dos. Users can update project names, add new to-dos, edit existing ones, delete them, and even export a summary of their to-dos in the form of a GitHub README markdown file. This functionality ensures a seamless and organized approach to task management, with a robust authentication mechanism to secure user data and actions.
 ### Built With

- [Flutter](https://flutter.dev/)
- [Node.js](https://nodejs.org)
- [Postgres](https://www.postgresql.org)
- [Sequelize](https://sequelize.org)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
 ## Getting Started

Inorder to run the whole application first you need to start the backend server with postgres then run the frontend.
 ### Prerequisites

Inorder to run the application you should install the following:
- Flutter
- Postgres
- Node.js
- Npm
- Chrome (flutter web only supports chrome for debug builds)
 ### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/ATS527/hatio_todo.git
   ```
2. Go to server folder
   ```sh
   cd server
   ```
3. Install NPM packages
    ```sh
    npm install
    ```
4. Enter your env variables inside .env file
   ```sh
   JWT_SECRET_KEY="n3#do5-QL3lXRHn1%'aKq"
   JWT_EXPIRES=18
   COOKIE_EXPIRE=18
   DB_NAME="postgres"
   DB_USER="postgres"
   DB_PASSWORD=""
   DB_HOST="localhost"
   PORT=5270
   ```
5. Run the node app using
   ```sh
   node app
   ```
6. Open new window and open client folder. Inside hatio-todo folder execute 

   ```sh
    flutter pub get
    flutter run -d chrome --web-hostname=127.0.0.1 --web-port=8200
    ```
 ## Acknowledgments

Opensource packages that i used for building the application. Listed packages are hosted in pub.dev and npm.


- [makeread.me](https://github.com/ShaanCoding/ReadME-Generator)
- [othneildrew](https://github.com/othneildrew/Best-README-Template)
- [bcryptjs](https://www.npmjs.com/package/bcryptjs)
- [cookie-parser](https://www.npmjs.com/package/cookie-parser)
- [body-parser](https://www.npmjs.com/package/body-parser)
- [cookie-parser](https://www.npmjs.com/package/cookie-parser)
- [cors](https://www.npmjs.com/package/cors)
- [dotenv](https://www.npmjs.com/package/dotenv)
- [express](https://www.npmjs.com/package/express)
- [jsonwebtoken](https://www.npmjs.com/package/jsonwebtoken)
- [pg (postgres node plugin)](https://www.npmjs.com/package/pg)
- [sequelize](https://www.npmjs.com/package/sequelize)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [msh_checkbox](https://pub.dev/packages/msh_checkbox)
- [lottie](https://pub.dev/packages/lottie)
- [LottieFiles](https://lottiefiles.com/)
- [equatable](https://pub.dev/packages/equatable)
