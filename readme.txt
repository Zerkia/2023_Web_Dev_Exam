# Web Development Exam Project 2023/2024

## Created by Nikolaj Engstrøm Pregaard

## Special Thanks to [Santiago Donoso](https://github.com/santiagodonoso) for some of the code I've used for validation !

### Extensions/Libraries/Plugins etc. used

- [Faker](https://github.com/fzaninotto/Faker) for fake seeder data
- [Tailwind](https://tailwindcss.com/docs/installation) for general easy to use css stylings
- [PhPMyAdmin](https://www.phpmyadmin.net/) & [MySQL Workbench 8.0 CE](https://www.mysql.com/products/workbench/) for Database creation and procedures
- [XAMPP](https://www.apachefriends.org/) to run my program as well as how to start up my database

## How to run program

- Clone the Repository
- Take files out of downloaded folder and insert them into htdocs folder, provided by XAMPP installation
- Run XAMPP and Start Apache and MySQL (Should be port 80,443 and 3306 by default)
- Go to Localhost:80 and see if a page pops up
- Go to Localhost:80/phpmyadmin and import the database through the company.sql file (import -> choose file -> import button at the bottom)
- Go to Localhost:80/seeders/seed_database.php, if a blank page with some text and "SEED COMPLETE" is displayed, you're good to go!
- Go back to Localhost:80 and you're ready! Either create a user or use the ones seeded from previous step (check in Localhost:80/phpmyadmin under the "users" table. Every password is just the word "password", it's just hashed for security reasons)
- Enjoy !

- If an error happens with logging in or lack of data, try resetting the database by going to "Localhost:80/deleters/delete_database.php", then go to "Localhost:80/seeders/seed_database.php" and try again.

### How to Run tailwindcss (For devs)
- cd into the tailwindcss folder (cd .\tailwindcss\ from htdocs)
- npx tailwindcss -i ./input.css -o ../app.css --watch

- This shouldn't be needed, but isn't a bad thing to run either










