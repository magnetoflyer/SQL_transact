CREATE TABLE payment_methods(
    id: Int (auto increment),
    method: text

--1. netbanking
--2. cheque
--3. cash
--4. credit card
--5. debit card
--7. upi
)

CREATE TABLE payment_type ()
id: int auto increment
type : text
--1. sale
--2. refund
--3. driver_payment
)

CREATE TABLE transactions(
    trans_ID UUID,
    method_ID INT (foreign key to methods table),
    payment_type_id (foreign key to payment type)
    paid_amount double precision,
    Payment_detail JSON_B DEFAULT("none"),
    Ride_ID uuid,
    created_at DATETIME,
    updated_at default DateTime
    PRIMARY KEY(Trans_ID),
    FOREIGN KEY(Ride_ID)
);

CREATE TABLE rides(
    Ride_ID uuid AUTO_INCREMENT,
    Passenger_id uuid,
    Driver_id uuid NOT NULL,
    cost: double presions 
    driver_share double precision(base_fare*15)/100,
    source_point VARCHAR NOT NULL,
    dest_point VARCHAR NOT NULL,
    created_at DATETIME,
    updated_at DATETIME,
    PRIMARY KEY(Ride_ID)
);

--REPORT QUERIES:
1. SELECT SUM(paid_amount) FROM transactions
WHERE created_at BETWEEN a AND b  --between date a and b 
and method_ID = 4
ORDER BY created_at DESC;

2. SELECT SUM(amount) as driver_earned_amount FROM transactions
left join rides as ri on transactions.ride_id = ri.id
WHERE created_at BETWEEN a AND b 
and ri.driver_id = <driver_id>
and payment_type_id = 3
ORDER BY created_at DESC;

3. SELECT date_trunc(week, created_at) as date, 
SUM(Amount) AS weekly_income
FROM transactions
where payment_type_id = 1
GROUP BY date
order by  date desc;

4. SELECT date_trunc(week, created_at) as date, 
SUM(Amount) AS weekly_driver_amount_paid
FROM transactions
where payment_type_id = 3
GROUP BY date
order by  date desc;