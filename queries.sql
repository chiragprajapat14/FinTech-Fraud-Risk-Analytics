select * FROM bank_customers bc ;
select * from credit_cards cc ;
select * from card_transactions ct ;


#Business Intent: The risk compliance team wants to blacklist accounts that are trading without completed documentation.
#Extract all columns from bank_customers where the kyc_status is strictly 'Pending'

select * from bank_customers bc 
where bc.kyc_status = "pending";

#The anti-money laundering (AML) department wants to see which spending categories are triggered globally.
#Count how many total transactions exist for each unique merchant_category across the whole database

select 
    COUNT(transaction_id) AS transaction_no,merchant_category 
    from card_transactions ct 
    group by merchant_category 
    order by transaction_no desc;

#Product marketing wants to see which card class is popular. Group your issued inventory by card_type 
#and calculate the average credit monthly_limit given out to users per card tier.

select 
    card_type,
    AVG(monthly_limit) as avg_mouths_lim FROM credit_cards cc 
    group by card_type
    order by avg_mouths_lim desc;

#Fraud monitoring wants a raw alert list of overseas purchases. Pull all transactions where the transaction country (tx_country) is NOT 'India' 
#and the swiped swipe amount is strictly greater than $1,000.

select 
    transaction_id,
    card_number,
    tx_country,
    amount from card_transactions ct 
    where ct.tx_country != "india" 
    and ct.amount > "1000";

 #The executive board wants a single aggregated number representing the total financial loss currently tied up under fraudulent transactions (is_disputed = 1).

select 
    SUM(amount) as total_loss_amount 
    from card_transactions ct 
    where is_disputed = "1"
    
#Fraud prevention teams want to catch "Velocity Attacks," where a stolen credit card is swiped multiple times in very quick succession 
#before the account gets blocked.
    
select 
    card_number,
    merchant_category,
    tx_time,
    LAG(ct.tx_time,1) OVER(partition by card_number order by tx_time) as velocity 
    from card_transactions ct 
#Risk management needs to flag users who are dangerously close to breaching their contractual credit wall or have already over-spent their account allowance.    

select 
    bc.customer_name,
    cc.card_type,
    cc.monthly_limit,
    SUM(ct.amount) as amount,
    concat(round(SUM(ct.amount/ cc.monthly_limit) *100,2),"%") as pers
    from credit_cards cc 
    inner join bank_customers bc 
    on cc.customer_id = bc.customer_id 
    inner join card_transactions ct 
    ON cc.card_number = ct.card_number 
    GROUP by bc.customer_name,cc.card_type,cc.monthly_limit
    having sum(ct.amount) > (0.8* cc.monthly_limit)
    
    
#The Anti-Money Laundering (AML) team needs to evaluate geopolitical risk. They want to identify which international jurisdictions 
#are receiving the highest volumes of disputed transactions
    
select 
    tx_country,
    SUM(amount) amount,
    concat(round(SUM(amount)/SUM(SUM(amount)) OVER()*100,2),"%") as percentage
    FROM card_transactions ct 
    where is_disputed ="1"
    group by tx_country 
    
    
    
#The credit card marketing department needs a structured profile matrix to launch 
#customized cash-back rewards campaigns for specific consumer brackets
    
select
    bc.customer_name,
    GROUP_CONCAT(DISTINCT ct.merchant_category," ") as details
    from card_transactions ct 
    inner join credit_cards cc 
    ON ct.card_number  = cc.card_number 
    inner JOIN bank_customers bc 
    on cc.customer_id = bc.customer_id 
    GROUP by bc.customer_name 
    
#Corporate compliance rules mandate that unverified users cannot bypass fraud risk filters.
#dentify high-exposure targets who are trading with uncompleted paperwork.

select 
     bc.customer_name,
     bc.kyc_status,
     MAX(amount) amount
     FROM bank_customers bc 
     inner join credit_cards cc 
     on bc.customer_id = cc.customer_id 
     inner join card_transactions ct 
     on cc.card_number = ct.card_number 
     where bc.kyc_status = "Pending"
     GROUP by bc.customer_name
     HAVING MAX(amount)> 1000;
    
    
    
