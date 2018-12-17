MariaDB [CISC3500Fall2018]> show tables;
+----------------------------+
| Tables_in_CISC3500Fall2018 |
+----------------------------+
| AboveAvgStudents           |
| Boats                      |
| Department_Locations       |
| Departments                |
| Employee_Hours             |
| Employees                  |
| Enrolled                   |
| Projects                   |
| Projects_Head              |
| Reserves                   |
| SailorThird                |
| Sailors                    |
| SailorsAnother             |
| SailorsNew                 |
| Sessions                   |
| Students                   |
| StudentsEnrollment         |
| Sub_Students               |
| Works_On                   |
| Works_On_Head              |
+----------------------------+
20 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> Select * from Projects;
+-----+----------------+-----------+------+
| pid | pname          | plocation | pdid |
+-----+----------------+-----------+------+
|   1 | ProductX       | Chicago   |    5 |
|   2 | ProductY       | New York  |    5 |
|   3 | ProductZ       | New York  |    5 |
|   4 | Computation    | Houston   |    4 |
|   5 | Reorganization | Houston   |    1 |
|   6 | Benefit        | Houston   |    1 |
|   7 | PromotionA     | Houston   |    3 |
|   8 | PromotionB     | Chicago   |    3 |
+-----+----------------+-----------+------+
8 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select pname
    -> from Projects
    -> where plocation='Chicago';
+------------+
| pname      |
+------------+
| ProductX   |
| PromotionB |
+------------+
2 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select dname as Department_Name
    -> from Projects, Departments
    -> where plocation='New York' and pdid=did;
+-----------------+
| Department_Name |
+-----------------+
| Research        |
| Research        |
+-----------------+
2 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select fname as M_First_Name, lname as M_Last_Name, dname as Department_Name, pname as Project_Name
    -> from Projects P, Departments D, Employees E
    -> where plocation='Houston' and P.pdid=D.did 
    -> and D.managerssn=E.ssn;
+--------------+-------------+-----------------+----------------+
| M_First_Name | M_Last_Name | Department_Name | Project_Name   |
+--------------+-------------+-----------------+----------------+
| Jennifer     | Wallace     | Administra      | Computation    |
| Ramesh       | Narayan     | Headquarte      | Reorganization |
| Ramesh       | Narayan     | Headquarte      | Benefit        |
| James        | Borg        | Marketing       | PromotionA     |
+--------------+-------------+-----------------+----------------+
4 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select essn, sum(hours) from Works_On group by essn;
+-----------+------------+
| essn      | sum(hours) |
+-----------+------------+
| 123456789 |         40 |
| 333445555 |        190 |
| 666884444 |        200 |
| 666884445 |        111 |
| 666885555 |        201 |
| 986754321 |        390 |
| 999885555 |        190 |
| 999887777 |        120 |
+-----------+------------+
8 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select pname as Project_Name, 'Manager' as Role from Projects P, Departments D, Employees E where lname like '%r%' and P.pdid=D.did and D.managerssn=E.ssn
    -> union
    -> select pname as Project_Name, 'Employee' as Role
    -> from Projects P, Works_On W, Employees E
    -> where lname like '%r%' and W.pid=P.pid
    -> and W.essn=E.ssn;
+----------------+----------+
| Project_Name   | Role     |
+----------------+----------+
| Reorganization | Manager  |
| Benefit        | Manager  |
| PromotionA     | Manager  |
| PromotionB     | Manager  |
| Computation    | Employee |
| Reorganization | Employee |
| Benefit        | Employee |
| PromotionA     | Employee |
| PromotionB     | Employee |
+----------------+----------+
9 rows in set (0.00 sec)

MariaDB [CISC3500Fall2018]> select distinct E.ssn from Employees E, Projects P, Works_On W where not exists(select P.pid from Projects P where not exists (select W.pid from Works_On W  where W.pid=P.pid and W.essn=E.ssn));
+-----------+
| ssn       |
+-----------+
| 999887777 |
+-----------+
1 row in set (0.09 sec)

MariaDB [CISC3500Fall2018]> notee ;
