select last_name, salary, NVL(to_char(commission_pct), 'No Commission') from hr.employees order by salary desc;

select last_name, (salary*12) + (salary*12* NVL(commission_pct,0)) AN_SAL from hr.employees order by AN_SAL DESC;

select e.last_name, d.department_name from hr.employees e join departments d using (department_id) where LOWER(last_name) like '_%r%' and job_id = 'SA_MAN' order by salary;

select e.last_name from hr.employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id where city='Toronto';

select e.first_name, e.hire_date,m.first_name as Manager_name,m.hire_date,e.salary from hr.employees e join hr.employees m on e.manager_id =m.employee_id where e.hire_date<m.hire_date;

select e.last_name, d.department_name, l.city  from hr.employees e join departments d on d.department_id = e.department_id join locations l on l.location_id = d.location_id where e.salary > 5000;

select j.job_id,count(*) from jobs j  join hr.employees e on j.job_id=e.job_id group by j.job_id;

select count(distinct manager_id) as "Number of Managers" from hr.employees where manager_id is not null;

select max(salary),min(salary),max(salary)-min(salary) as difference from hr.employees;

select manager_id, min(salary) from hr.employees where manager_id is not null group by manager_id having min(salary) >5000 order by min(salary) desc;

select e.last_name,j.job_title,d.department_name,h.start_date from employees e inner join departments d on d.department_id = e.department_id 
inner join jobs j on j.job_id = e.job_id inner join job_history h on h.employee_id = e.employee_id
where to_char(h.start_date,'yyyy') between 2001 and 2005;

select count(end_date), employee_id from job_history group by employee_id having count(end_date) >1;

select first_name,last_name, department_id from hr.employees where first_name like '__s%';

select e.last_name, l.city from hr.employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where l.city = 'Seattle' or l.city = 'London';

select last_name as Employee, salary as "Monthly Salary" from hr.employees where salary between 5000 and 12000 and (department_id = 20 or department_id=50);

select e.last_name, d.department_name, l.city, c.country_name from hr.employees e 
join departments d on e.department_id = d.department_id join locations l on d.location_id=l.location_id
join countries c on l.country_id=c.country_id where e.salary>7500;

select d.department_id as "Department Number", d.department_name,count(e.employee_id) as "Number of People", avg(salary) as "Avarage Salary" from departments d join hr.employees e
on e.department_id = d.department_id group by d.department_id, d.department_name order by "Avarage Salary" desc;

select employee_id, first_name, last_name  from hr.employees where employee_id not in (select employee_id from job_history);

select l.city from hr.employees e 
join departments d on e.department_id = d.department_id join locations l on d.location_id=l.location_id
join countries c on l.country_id=c.country_id where e.employee_id = 107;

select first_name, last_name, hire_date, last_day(hire_date)+1 as "FIRST_SALARY" from hr.employees;

select a.first_name,a.last_name, f.title,f.description, c.name from actor a join
film_actor fa on a.actor_id = fa.actor_id join film f on f.film_id=fa.film_id join 
film_category fc on fc.film_id = f.film_id join category c on fc.category_id= c.category_id
where f.description like '%Cat%' or f.description like '%Dog%';

select a.actor_id,a.first_name, a.last_name,count(fa.film_id) as Appeared from actor a join
film_actor fa on a.actor_id = fa.actor_id group by a.first_name,a.last_name,a.actor_id 
order by Appeared desc limit 1;

select co.country_id, count(ci.city) from country co join city ci on co.country_id=ci.country_id
group by co.country_id having count(ci.city) >1;

select first_name,last_name from actor where substr(first_name,1,1) = substr(last_name,1,1);

select l.name,count(f.title) as Movie_Count from film f join language l on l.language_id=f.language_id group by l.name;

select cu.customer_id, count(re.rental_id) as renting_number from rental re join customer cu
on cu.customer_id=re.customer_id group by cu.customer_id order by renting_number desc limit 5; 

select first_name, count(first_name) as name_count from actor a  group by first_name order by name_count desc limit 10;

select  s.staff_id, s.first_name, s.last_name,count(p.payment_id) as Sale_Count from staff s
join payment p on s.staff_id=p.staff_id where date_part('year',payment_date) =2007 and date_part('month',payment_date)=4 group by s.staff_id, s.first_name, s.last_name order by Sale_Count desc limit 1;

select count(*) as "Number of Customer returned in 1 day" from rental where date_part('day',return_date-rental_date) = 1;

select a.actor_id,a.first_name,a.last_name, count(fa.film_id) as Movie_count from actor a join film_actor fa on
a.actor_id=fa.actor_id group by a.first_name,a.last_name,a.actor_id order by Movie_count desc limit 5;

select rating,avg(rental_rate) as Avarage_rate from film where rating in ('R','G','PG','PG-13') 
group by rating having Avarage_rate <3;

select concat(a.first_name,' ',a.last_name) as Name, f.title from actor a join film_actor fa on a.actor_id=fa.actor_id
join film f on f.film_id=fa.film_id where f.length <50;

select cu.customer_id, concat(cu.first_name,' ',cu.last_name) as Full_name, sum(p.amount) as total_payment from customer cu join payment p
on p.customer_id=cu.customer_id group by cu.customer_id, Full_name order by total_payment desc limit 1; 

select ca.name as Category_name, count(f.rental_rate) as Count from category ca join film_category fc on ca.category_id= fc.category_id
join film f on f.film_id= fc.film_id group by Category_name order by Count desc limit 10;

select last_name, count(actor_id) as actor_number from actor group by last_name;

select f.title, count(f.title) as count from film f join inventory i on i.film_id=f.film_id
join rental re on i.inventory_id=re.inventory_id group by f.title order by count desc limit 10;

select first_name,last_name from actor where actor_id in(select actor_id from film_actor where film_id in 
(select film_id from film where title='Ridgemont Submarine'));

select f.film_id,f.rental_duration,ca.name from film_actor fa join film f on fa.film_id = f.film_id 
join film_category fc on f.film_id=fc.film_id join category ca on ca.category_id=fc.category_id where ca.name='Family' order by f.rental_duration desc limit 1;

select count(f.film_id)as Movie_number from category ca join film_category fc on ca.category_id= fc.category_id join film f on f.film_id=fc.film_id
where ca.name='Family' and f.rental_rate <2;

select a.first_name||' '|| a.last_name as actor,f.title,f.length,
case when f.length <=60 then '1 hour or less'
     when f.length >60 and f.length <=120 then 'Between 1-2 hours'
     when f.length>120 and f.length <=180 then 'Between 2-3 hours'
     else 'More then 3 hours'end as "length category"
from film f join film_actor fa on f.film_id=fa.film_id 
join actor a on a.actor_id=fa.actor_id limit 10;