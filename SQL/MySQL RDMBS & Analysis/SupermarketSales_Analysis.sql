-- Multi-Tables Data Analysis for the First Quarter of Supermarket Sales

-- 1. Sales Performance
-- The trends in total sales revenue across branches and cities?
select COUNT(s.invoiceid) as "Total Invoices", b.city, b.branch, ROUND(SUM(sd.total),2) as "Total Sales"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join branchdetails b on s.branchid = b.branchid
group by b.city, b.branch;

-- Sales performance between member and non-member?
select COUNT(s.invoiceid) as "Total Invoices", c.customertype, ROUND(SUM(sd.total),2) as "Total Sales"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
group by c.customertype;

-- Sales performance between male and female?
select COUNT(s.invoiceid) as "Total Invoices", g.gender, ROUND(SUM(sd.total),2) as "Total Sales"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join genderdetails g on s.genderid = g.genderid
group by g.gender;

-- Which product lines are top-selling, and their contribution to overall revenue?
select pl.productline, ROUND(SUM(sd.total),2) as "Total Sales", 
ROUND((SUM(sd.total) / (select SUM(total) from salesdetails)),3) * 100 as "Sales %"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join productlinedetails pl on s.productlineid = pl.productlineid
group by pl.productline;

-- Which product lines generate the best income?
select pl.productline, ROUND(SUM(pd.grossincome),2) as "Total Income"
from supermarketdetails s
inner join profitdetails pd on s.invoiceid = pd.invoiceid
inner join productlinedetails pl on s.productlineid = pl.productlineid
group by pl.productline order by ROUND(SUM(pd.grossincome),2) asc;

-- How does sales performance compare across different branches and cities?
select b.branch, ROUND(SUM(sd.total),2) as "Total Sales", ROUND(AVG(sd.total),2) as "Average Value", COUNT(*) as "Total Invoices"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join branchdetails b on s.branchid = b.branchid
group by b.branch order by b.branch;

-- How does the sales performance of product lines compare among branches?
select b.branch, pl.productline, ROUND(SUM(sd.total),2) as "Total Sales", COUNT(*) as "Total Invoices"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join branchdetails b on s.branchid = b.branchid
inner join productlinedetails pl on s.productlineid = pl.productlineid
group by b.branch, pl.productline order by b.branch;

-- 2. Customer Behavior
-- How are customer purchases distributed across different product categories?
select pl.productline, c.customertype, ROUND(SUM(sd.total),2) as "Total Sales", 
ROUND((SUM(sd.total) / (select SUM(total) from salesdetails)),4) * 100 as "Sales %"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
inner join productlinedetails pl on s.productlineid = pl.productlineid
group by pl.productline, c.customertype order by pl.productline asc;

-- What are the preferred payment methods among customers?
select p.paymenttype, c.customertype, COUNT(s.invoiceid) as "Total Invoices"
from supermarketdetails s
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
inner join paymenttypedetails p on s.paymentid = p.paymentid
group by p.paymenttype, c.customertype order by c.customertype;

-- What are the preferred payment methods among customers by branches?
select b.branch, p.paymenttype, c.customertype, COUNT(s.invoiceid) as "Total Invoices"
from supermarketdetails s
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
inner join paymenttypedetails p on s.paymentid = p.paymentid
inner join branchdetails b on s.branchid = b.branchid
group by b.branch, p.paymenttype, c.customertype order by b.branch;

-- Is there any relationship between satisfaction ratings and sales?
select b.branch, ROUND(AVG(ratings),2) as "Average Rating", ROUND(SUM(sd.total),2) as "Total Sales"
from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join branchdetails b on s.branchid = b.branchid
inner join productlinedetails pl on s.productlineid = pl.productlineid
group by b.branch order by b.branch, "Average Rating" desc;

-- Product Analysis
-- Some retailers believe, there is more money to be made in selling fashion accessories to men than sports and travel to women. Is this true?

select  pd.productline, g.gender, sum(pf.grossincome) as totalprofit, count(s.invoiceid) as invoicecount from supermarketdetails s
inner join profitdetails pf on s.profitid = pf.profitid
inner join genderdetails g on s.genderid = g.genderid
inner join productlinedetails pd on s.productlineid = pd.productlineid
where pd.productline in ("Fashion accessories", "Sports and travel")
group by pd.productline, g.gender;

-- Some retailers believe that revenue in food and beverages can be increased amongst women by focusing on Ewallets, 
-- while others believe eWallets are more popular with men buying electronic accessories. Who is right?

select  pd.productline, g.gender, p.paymenttype, sum(total) as totalrevenue, count(s.invoiceid) as invoicecount from supermarketdetails s
inner join salesdetails sd on s.salesid = sd.salesid
inner join genderdetails g on s.genderid = g.genderid
inner join productlinedetails pd on s.productlineid = pd.productlineid
inner join paymenttypedetails p on s.paymentid = p.paymentid
where pd.productline in ("Food and beverages", "Electronic accessories") and paymenttype in ("Ewallet")
group by pd.productline, g.gender, p.paymenttype;

-- Some retailers believe their members are spending more per purchase while members believe they are spending less per purchase. Who is right?

select week(s.date) as weekly_purchased, count(s.invoiceid) as totalinvoice, sum(sd.total) as totalrevenue
from supermarketdetails s
inner join salesdetails sd on s.salesid = sd.salesid
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
where customertype in ("Member")
group by week(s.date) order by week(s.date);

-- Some retailers believe their male members are bringing in more overall revenue per purchase, 
-- while others believe female non-members are bringing in more revenue per purchase of fashion accessories. Who is right?

select g.gender, c.customertype, productline, sum(sd.total) as "Total Revenue",
sum(sd.total) / count(s.invoiceid) as "Total Revenue per Purchase" from supermarketdetails s
inner join salesdetails sd on s.invoiceid = sd.invoiceid
inner join genderdetails g on s.genderid = g.genderid
inner join customerdetails c on s.customerdetailsid = c.customerdetailsid
inner join productlinedetails pd on s.productlineid = pd.productlineid
where pd.productline in ("Fashion accessories")
group by g.gender, c.customertype;

-- Yangon calls itself the most eWallet-friendly city for health and beauty while Mandalay calls itself a haven for cash spending. 
-- Does the data support their claims?

select b.city, p.paymenttype, pd.productline, count(s.invoiceid) as "Total Invoices"
from supermarketdetails s 
inner join branchdetails b on s.branchid = b.branchid
inner join paymenttypedetails p on s.paymentid = p.paymentid
inner join productlinedetails pd on s.productlineid = pd.productlineid
where pd.productline in ("Health and beauty") and b.city in ("Yangon", "Mandalay")
group by b.city, p.paymenttype;
