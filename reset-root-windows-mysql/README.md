1. Stop MySQL
Stop the service from the services' pane
or
`net stop mysql57`
note mysql57 will reflect the version such as mysql80 and could be another customized name

2. Run MySQL as the \_mysql user without grant tables. Leave this terminal window running
replace all instances of x.x with the version of mysql, such as 5.7 or 8.0
`"C:\Program Files\MySQL\MySQL Server x.x\bin\mysqld" --datadir="C:/ProgramData/MySQL/MySQL Server x.x/Data" --skip-grant-tables --shared-memory`
Leave this command prompt window running, as it holds the new mysqld service process.
