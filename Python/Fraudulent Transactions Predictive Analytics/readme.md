  -  Define Problem: ABC Bank has recently experienced an increase in fraudulent online transactions. The bank is seeking to implement a more robust fraud detection system to mitigate financial losses and protect its customers. They have collected a dataset of online transactions containing both legitimate and fraudulent transactions. The dataset is split into three separate tables: customers, transactions, and merchants.
    
  - Objective: Build a predictive model to identify potentially fraudulent transactions. Provide recommendations on how to improve the fraud detection system based on findings.
    
  - Data Collection: Datasets are collected from interal sources.
    - **Customers table:** Contains customer_id, account_age and customer_demographics.
    - **Transactions table:** Records of online transactions including transaction_id, customer_id, transaction_timestamp, transaction_amount, transaction_type, payment_method, account_balance_before, account_balance_after, transaction_device, ip_address, user_agent, and is_fraud.
    - **Merchants table:** Information about the merchants involved merchan_id, merchan_category.

  - Data Preparation: Datasets are well structured but still require some manipulation to ensure the completeness and validity of data.

  - Data Exploratory: Key insights are gathered through Exploratory Data Analysis. Some insights are listed below.
    
    - 95% of transactions are Non-Fraudulent and 5% of transactions are Fraudulent.
    - Fraudulent transactions were highest with mobile transaction device and transfer transaction type.
    - Fraudulent transactions were highest with credit card payment method and grocery category.
    - Fraudulent Transactions were happened highest on Sunday and Thursday.
    - Fraudulent transaction amount falls between -$5000 and $10,0000, and 50% of the transactions is greater than $5000.
    - 50% of the frauduent transactions were happened to accounts that opened more than 1000 days.
      
  - Communication of insights: Python visualization libraries.
