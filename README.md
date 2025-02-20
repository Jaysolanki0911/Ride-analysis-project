# Ride-analysis-project

# Project Overview
This project aims to analyze ride-sharing data using SQL. The objective is to gain insights into ride trends, customer behaviors, and key performance metrics. The analysis focuses on aspects such as ride frequency, average fare, peak hours, and driver performance.

# Tools & Technologies Used
MySQL -  For data extraction and analysis

# Sample Queries
#.Find the average salary of employees in each department and list the departments where the average salary is greater than 7000.
select department_id,avg(salary) as avg_salary
from employees
group by department_id 
having avg_salary > 7000;

#2.List the employees whose first name starts with the letter 'S'.
select * from employees
where first_name like 'S%';

#3.Find the department names and the number of employees in each department.
select d.department_name,count(e.employee_id) as num_of_emp
from departments d 
left join employees e 
on d.department_id = e.department_id 
group by d.department_name 

#4.List the employees who are managers along with their department names.
select d.manager_id,e.first_name,e.last_name,d.department_name 
from departments d 
join employees e 
on d.department_id = e.department_id
group by d.manager_id,d.department_name,e.first_name,e.last_name ;

#5.Find all employees who do not have a manager.
SELECT e.employee_id, e.first_name
FROM Employees e
LEFT JOIN  Employees m ON e.manager_id = m.department_id
WHERE e.manager_id IS NOT NULL AND m.department_id IS NULL;
 
#6.List all employees along with their department names. If an employee is not assigned to any department, still include them in the result.
select e.employee_id,e.first_name,d.department_name 
from employees e
left join departments d 
on e.department_id = d.department_id;
   
#7.Find all employees and their managers.
select e.employee_id as EmployeeID, e.first_name as EmployeeName,m.first_name as ManagerName
from Employees e
left join Employees m 
on e.manager_id = m.employee_id;

#8.List all employees who earn more than the average salary of their department. 
SELECT e.employee_id,e.first_name,e.Salary, d.department_name 
FROM Employees e
INNER JOIN Departments d 
ON e.department_id = d.department_id 
WHERE e.Salary > (SELECT AVG(e1.Salary)FROM Employees e1
WHERE e1.department_id = e.department_id);

#9.Find the number of employees hired each year.
select count(employee_id),year(hire_date) 
from employees
group by year(hire_date)
order by year(hire_date)

#10.List all unique job IDs from the employees table along with the number of employees for each job ID. 
select job_id,count(employee_id) as employeecount 
from employees   
group by job_id; 

# Insights & Conclusions
Peak ride hours are usually between 8 AM - 10 AM and 6 PM - 9 PM, indicating commuter traffic.
Wallet payments are the most commonly used payment method.
Drivers completing more rides tend to have higher ratings and higher earnings.
Rides with longer distances generally have a higher fare per kilometer.

