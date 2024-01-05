CREATE VIEW  revenue_by_month AS(
    SELECT extract(MONTH FROM booking_date) as month, 
            sum(case when type = 'Economy' then quantity else 0 end) as num_of_economy_fare,
            sum(case when type = 'Business' then quantity else 0 end) as num_of_business_fare,
            sum(total) as total_income
    FROM transactions_order
    JOIN transactions using(transaction_id)
    WHERE extract(YEAR FROM booking_date) = EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY extract(MONTH FROM booking_date)
);