1. Stop MySQL

* _Stop the service from the services pane or_

`net stop mysql57`

* _note mysql57 will reflect the version such as mysql80 and could be another customized name_

2. Run MySQL as the \_mysql user without grant tables. Leave this terminal window running
replace all instances of x.x with the version of mysql, such as 5.7 or 8.0

`"C:\Program Files\MySQL\MySQL Server x.x\bin\mysqld" --datadir="C:/ProgramData/MySQL/MySQL Server x.x/Data" --skip-grant-tables --shared-memory`

* _Leave this command prompt window running, as it holds the new mysqld service process._

3. Log into MySQL in a new terminal window

* _Replace x.x with the version of mysql, such as 5.7 or 8.0_

`"C:\Program Files\MySQL\MySQL Server x.x\bin\mysql" -u root`

4. Flush privileges, and set the new password

`flush privileges;`

* _5.7.6 and later (includes 8.0)_
`alter user 'root'@'localhost' identified by "newpass";`

* _5.7.5 and earlier_
`set password for 'root'@'localhost' = password('newpass');`

* if those fail try_
`UPDATE mysql.user SET authentication_string = PASSWORD('newpass')
WHERE User = 'root' AND Host = 'localhost';`
`FLUSH PRIVILEGES;`

5. Stop MySQL again.

* _Close the window that has the mysqld process running from step 2._

6. Start MySQL

* _Start the service in the services pane or_

`net start mysql57`

* note mysql57 will reflect the version such as mysql80 and could be another customized name_

7. Log in with the new password

* _Replace x.x with the version of mysql, such as 5.7 or 8.0_

`"C:\Program Files\MySQL\MySQL Server x.x\bin\mysql" -u root -p`

_Credits to: github dot com slash prikla_
