
C:\Users\HOPELYN>snowsql -v
Version: 1.2.32

C:\Users\HOPELYN>snowsql -a pgqtqup-qc53557 -u ALICIA
Password:
* SnowSQL * v1.2.32
Type SQL statements or !help
ALICIA#COMPUTE_WH@(no database).(no schema)>CREATE OR REP
                                            LACE DATABASE
                                             sf_tuts;

+----------------------------------------+
| status                                 |
|----------------------------------------|
| Database SF_TUTS successfully created. |
+----------------------------------------+
1 Row(s) produced. Time Elapsed: 1.163s
ALICIA#COMPUTE_WH@SF_TUTS.PUBLIC>CREATE OR REPLACE TABLE emp_basic (
                                 first_name STRING,
                                 last_name STRING,
                                 email STRING,
                                 streetaddress STRING,
                                 city STRING,
                                 start_date DATE
                                 );

+---------------------------------------+
| status                                |
|---------------------------------------|
| Table EMP_BASIC successfully created. |
+---------------------------------------+
1 Row(s) produced. Time Elapsed: 1.250s
ALICIA#COMPUTE_WH@SF_TUTS.PUBLIC>CREATE OR REPLACE WAREHOUSE sf_tuts_wh WIT
                                 H
                                 WAREHOUSE_SIZE = 'X-SMALL'
                                 AUTO_SUSPEND = 180
                                 AUTO_RESUME = TRUE
                                 INITIALLY_SUSPENDED = TRUE;
                                                                            +--------------------------------------------+
| status                                     |
|--------------------------------------------|
| Warehouse SF_TUTS_WH successfully created. |
+--------------------------------------------+
1 Row(s) produced. Time Elapsed: 1.146s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>SELECT CURRENT_WAREHOUSE();

+---------------------+
| CURRENT_WAREHOUSE() |
|---------------------|
| SF_TUTS_WH          |
+---------------------+
1 Row(s) produced. Time Elapsed: 0.220s

ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>PUT file://C:\Users\HOPELYN\Desktop/employees0/employees01.csv @sf_tuts.public.%emp_basic;
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source          | target             | source_size | target_size | source_compression | target_compression | status   | message |
|-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| employees01.csv | employees01.csv.gz |         370 |         304 | NONE               | GZIP               | UPLOADED |         |
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 5.552s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>PUT file://C:\Users\HOPELYN\Desktop\employees0/employees02.csv @sf_tuts.public.%emp_basic;
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source          | target             | source_size | target_size | source_compression | target_compression | status   | message |
|-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| employees02.csv | employees02.csv.gz |         364 |         288 | NONE               | GZIP               | UPLOADED |         |
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 4.758s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>PUT file://C:\Users\HOPELYN\Desktop\employees0/employees03.csv @sf_tuts.public.%emp_basic;
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source          | target             | source_size | target_size | source_compression | target_compression | status   | message |
|-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| employees03.csv | employees03.csv.gz |         407 |         304 | NONE               | GZIP               | UPLOADED |         |
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 2.851s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>PUT file://C:\Users\HOPELYN\Desktop\employees0/employees04.csv @sf_tuts.public.%emp_basic;
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source          | target             | source_size | target_size | source_compression | target_compression | status   | message |
|-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| employees04.csv | employees04.csv.gz |         375 |         304 | NONE               | GZIP               | UPLOADED |         |
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 2.599s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>PUT file://C:\Users\HOPELYN\Desktop\employees0/employees05.csv @sf_tuts.public.%emp_basic;
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
| source          | target             | source_size | target_size | source_compression | target_compression | status   | message |
|-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------|
| employees05.csv | employees05.csv.gz |         404 |         304 | NONE               | GZIP               | UPLOADED |         |
+-----------------+--------------------+-------------+-------------+--------------------+--------------------+----------+---------+
1 Row(s) produced. Time Elapsed: 1.549s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>LIST @sf_tuts.public.%emp_basic;

+--------------------+------+----------------------------------+-------------------------------+
| name               | size | md5                              | last_modified                 |
|--------------------+------+----------------------------------+-------------------------------|
| employees01.csv.gz |  304 | 25436ade94bb72b4ce3fd22fd1ca594c | Thu, 22 Aug 2024 09:56:02 GMT |
| employees02.csv.gz |  288 | 8b598d6f795cf7dffba55aa6ff6b91d1 | Thu, 22 Aug 2024 10:00:00 GMT |
| employees03.csv.gz |  304 | 00987e3f6d9706c102b55734822b7982 | Thu, 22 Aug 2024 10:03:16 GMT |
| employees04.csv.gz |  304 | 5a9ff8852d47efc6f489548a13da4990 | Thu, 22 Aug 2024 10:08:37 GMT |
| employees05.csv.gz |  304 | 8fc4fc8f4b5ca1b00e482ceba85d3a45 | Thu, 22 Aug 2024 10:09:51 GMT |
+--------------------+------+----------------------------------+-------------------------------+
5 Row(s) produced. Time Elapsed: 1.399s

ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>COPY INTO emp_basic
                                 FROM @%emp_basic
                                 FILE_FORMAT =(type = csv field_optionally_enclosed_by = '"')
                                 PATTERN = '.*employees0[1-5].csv.gz'
                                 ON_ERROR = 'skip_file';
+--------------------+--------+-------------+-------------+-------------+-------------+-------------+------------------+-----------------------+-------------------------+
| file               | status | rows_parsed | rows_loaded | error_limit | errors_seen | first_error | first_error_line | first_error_character | first_error_column_name |
|--------------------+--------+-------------+-------------+-------------+-------------+-------------+------------------+-----------------------+-------------------------|
| employees01.csv.gz | LOADED |           5 |           5 |           1 |           0 | NULL        |             NULL |                  NULL | NULL             |
| employees05.csv.gz | LOADED |           5 |           5 |           1 |           0 | NULL        |             NULL |                  NULL | NULL             |
| employees04.csv.gz | LOADED |           5 |           5 |           1 |           0 | NULL        |             NULL |                  NULL | NULL             |
| employees03.csv.gz | LOADED |           5 |           5 |           1 |           0 | NULL        |             NULL |                  NULL | NULL             |
| employees02.csv.gz | LOADED |           5 |           5 |           1 |           0 | NULL        |             NULL |                  NULL | NULL             |
+--------------------+--------+-------------+-------------+-------------+-------------+-------------+------------------+-----------------------+-------------------------+
5 Row(s) produced. Time Elapsed: 1.622s

---QUERYING DATA----
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>SELECT * FROM emp_basic;

+------------+--------------+---------------------------+-----------------------------+--------------------+------------+
| FIRST_NAME | LAST_NAME    | EMAIL                     | STREETADDRESS
          | CITY               | START_DATE |
|------------+--------------+---------------------------+-----------------------------+--------------------+------------|
| Lem        | Boissier     | lboissier@sf_tuts.com     | 3002 Ruskin Trail           | Shikārpur          | 2017-08-25 |
| Iain       | Hanks        | ihanks1@sf_tuts.com       | 2 Pankratz Hill             | Monte-Carlo        | 2017-12-10 |
| Avo        | Laudham      | alaudham2@sf_tuts.com     | 6948 Debs Park              | Prażmów            | 2017-10-18 |
| Emili      | Cornner      | ecornner3@sf_tuts.com     | 177 Magdeline Avenue        | Norrköping         | 2017-08-13 |
| Harrietta  | Goolding     | hgoolding4@sf_tuts.com    | 450 Heath Trail             | Osielsko           | 2017-11-27 |
| Arlene     | Davidovits   | adavidovitsk@sf_tuts.com  | 7571 New Castle Circle      | Meniko             | 2017-05-03 |
| Violette   | Shermore     | vshermorel@sf_tuts.com    | 899 Merchant Center         | Troitsk            | 2017-01-19 |
| Ron        | Mattys       | rmattysm@sf_tuts.com      | 423 Lien Pass               | Bayaguana          | 2017-11-15 |
| Shurlocke  | Oluwatoyin   | soluwatoyinn@sf_tuts.com  | 40637 Portage Avenue        | Semënovskoye       | 2017-09-12 |
| Granger    | Bassford     | gbassfordo@sf_tuts.co.uk  | 6 American Ash Circle       | Kardítsa           | 2016-12-30 |
| Wallis     | Sizey        | wsizeyf@sf_tuts.com       | 36761 American Lane         | Taibao             | 2016-12-30 |
| Di         | McGowran     | dmcgowrang@sf_tuts.com    | 1856 Maple Lane             | Banjar Bengkelgede | 2017-04-22 |
| Carson     | Bedder       | cbedderh@sf_tuts.co.au    | 71 Clyde Gallagher Place    | Leninskoye         | 2017-03-29 |
| Dana       | Avory        | davoryi@sf_tuts.com       | 2 Holy Cross Pass           | Wenlin             | 2017-05-11 |
| Ronny      | Talmadge     | rtalmadgej@sf_tuts.co.uk  | 588 Chinook Street          | Yawata             | 2017-06-02 |
| Althea     | Featherstone | afeatherstona@sf_tuts.com | 8172 Browning Street, Apt B | Calatrava          | 2017-07-12 |
| Hollis     | Anneslie     | hanneslieb@sf_tuts.com    | 3248 Roth Park              | Aleysk             | 2017-11-16 |
| Betti      | Cicco        | bciccoc@sf_tuts.com       | 121 Victoria Junction       | Sinegor'ye         | 2017-06-22 |
| Brendon    | Durnall      | bdurnalld@sf_tuts.com     | 26814 Weeping Birch Place   | Sabadell           | 2017-11-14 |
| Kylila     | MacConnal    | kmacconnale@sf_tuts.com   | 04 Valley Edge Court        | Qingshu            | 2017-06-22 |
| Nyssa      | Dorgan       | ndorgan5@sf_tuts.com      | 7 Tomscot Way               | Pampas Chico       | 2017-04-13 |
| Catherin   | Devereu      | cdevereu6@sf_tuts.co.au   | 535 Basil Terrace           | Magapit            | 2016-12-17 |
| Grazia     | Glaserman    | gglaserman7@sf_tuts.com   | 162 Debra Lane              | Shiquanhe          | 2017-06-06 |
| Ivett      | Casemore     | icasemore8@sf_tuts.com    | 84 Holmberg Pass            | Campina Grande     | 2017-03-29 |
| Cesar      | Hovie        | chovie9@sf_tuts.com       | 5 7th Pass                  | Miami              | 2016-12-21 |
+------------+--------------+---------------------------+-----------------------------+--------------------+------------+
25 Row(s) produced. Time Elapsed: 1.638s

ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>INSERT INTO emp_basic VALUES ( 'Clementine','Adamou','cadamou@sf_tuts.com','10510 Sachs road','Klenak','2017-9-22'),
                                 ('Marlowe','De Anesy','madamouc@sf_tuts.co.uk','36768 Northfield Plaza', 'Fangshan','2017-1-26');
+-------------------------+
| number of rows inserted |
|-------------------------|
|                       2 |
+-------------------------+
2 Row(s) produced. Time Elapsed: 1.548s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>SELECT email FROM emp_basic WHERE
                                 email LIKE '%.uk';

+--------------------------+
| EMAIL                    |
|--------------------------|
| gbassfordo@sf_tuts.co.uk |
| rtalmadgej@sf_tuts.co.uk |
| madamouc@sf_tuts.co.uk   |
+--------------------------+
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>SELECT first_name, last_name, DATEADD('day', 90, start_date)
                                 FROM emp_basic WHERE start_date <= '2017-01-01';
+------------+-----------+--------------------------------+
| FIRST_NAME | LAST_NAME | DATEADD('DAY', 90, START_DATE) |
|------------+-----------+--------------------------------|
| Granger    | Bassford  | 2017-03-30                     |
| Wallis     | Sizey     | 2017-03-30                     |
| Catherin   | Devereu   | 2017-03-17                     |
| Cesar      | Hovie     | 2017-03-21                     |
+------------+-----------+--------------------------------+
4 Row(s) produced. Time Elapsed: 1.488s
ALICIA#SF_TUTS_WH@SF_TUTS.PUBLIC>
