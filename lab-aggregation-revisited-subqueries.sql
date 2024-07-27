-- Select the first name, last name, and email address of all the customers who have rented a movie.

select first_name, last_name, email
from sakila.customer
where active = 1;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select c.customer_id, concat(c.first_name, ' ', c.last_name) as 'name', round(avg(p.amount), 2) as 'average payment'
from sakila.customer c
left join sakila.payment p
on c.customer_id
group by 1
order by 3 desc;

-- Select the name and email address of all the customers who have rented the "Action" movies.
	-- Write the query using multiple join statements
	-- Write the query using sub queries with multiple WHERE clause and IN condition
	-- Verify if the above two queries produce the same results or not

select distinct concat(c.first_name, ' ', c.last_name) as 'name', c.email
from sakila.customer c
left join sakila.store st
on c.store_id = st.store_id
left join sakila.inventory inv
on st.store_id = inv.store_id
left join sakila.film f
on inv.film_id = f.film_id
left join sakila.film_category fc
on f.film_id = fc.film_id
left join sakila.category cat
on fc.category_id = cat.category_id
where cat.name = 'Action'
order by 1 desc;

select concat(first_name, ' ', last_name) as 'name', email from sakila.customer
where store_id in(
	select store_id from sakila.store
	where store_id in (
		select store_id from sakila.inventory
        where film_id in (
			select film_id from sakila.film
            where film_id  in (
				select category_id from sakila.film_category
                where category_id in (
					select category_id from sakila.category
					where name = 'Action')))))
order by 1 desc;

-- Use the case statement to create a new column classifying existing columns as either low or high value transactions based on the amount of payment. 
	-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
    -- and if it is more than 4, then it should be high.
    
select * , 
case
	when amount < 2 then 'low'
	when amount < 4 then 'medium'
    when amount > 4 then 'high'
end as 'trans_label'
from sakila.payment;