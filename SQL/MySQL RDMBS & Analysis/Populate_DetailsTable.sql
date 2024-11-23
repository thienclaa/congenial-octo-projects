-- View multiple columns by joinning different tables
Select s.invoiceid, date, time, grossmarginpercentage, rating, branchid, customerdetailsid, genderid, paymentid, productlineid, profitid, salesid
From myanmar_supermarket s
inner join branchdetails b on s.branch = b.branch
inner join customerdetails c on s.customertype = c.customertype
inner join genderdetails g on s.gender = g.gender
inner join paymenttypedetails p on s.payment = p.paymenttype
inner join productlinedetails pl on s.productline = pl.productline
inner join profitdetails pf on s.invoiceid = pf.invoiceid
inner join salesdetails sd on pf.invoiceid = sd.invoiceid;

-- Insert into Supermarketdetails Table
Insert Into supermarketdetails
Select s.invoiceid, date, time, grossmarginpercentage, rating, branchid, customerdetailsid, genderid, paymentid, productlineid, profitid, salesid
From myanmar_supermarket s
inner join branchdetails b on s.branch = b.branch
inner join customerdetails c on s.customertype = c.customertype
inner join genderdetails g on s.gender = g.gender
inner join paymenttypedetails p on s.payment = p.paymenttype
inner join productlinedetails pl on s.productline = pl.productline
inner join profitdetails pf on s.invoiceid = pf.invoiceid
inner join salesdetails sd on pf.invoiceid = sd.invoiceid