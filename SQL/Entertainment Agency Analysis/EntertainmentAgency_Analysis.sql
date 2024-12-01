-- Names and phone numbers of all agents 
Select agtfirstname, agtlastname,  agtphonenumber from agents
order by agtfirstname;

-- Show the engagements that run for at least 3 days
Select engagementnumber, startdate, enddate, datediff(enddate, startdate) as 'Total days' from engagements 
where datediff(enddate, startdate) >= 3;
-- OR
Select engagementnumber, startdate, enddate from engagements
where datediff(Cast(concat(enddate,' ',stoptime) as datetime), Cast(concat(startdate,' ',starttime) as datetime))>=3;

-- Provide a list of all engagements along with names of agent and entertainer who are from Seattle
Select eg.engagementnumber as 'Engagement', concat(agt.agtlastname,' ', agt.agtfirstname) as 'Agent', 
ent.entstagename as 'Entertainer', ent.entcity as 'City' from engagements eg
inner join agents agt on eg.agentid = agt.agentid
inner join entertainers ent on eg.entertainerid = ent.entertainerid where ent.entcity = 'Seattle';

-- Find the agents and entertainers who live in the sane postal code
Select agt.AgentID, ent.EntertainerID, concat(agt.agtlastname,' ', agt.agtfirstname) as 'Agent', ent.entstagename as 'Entertainer', 
agt.agtzipcode as 'Agent Zip', ent.entzipcode as 'Entertainer Zip' from agents agt
inner join entertainers ent on agt.agtzipcode = ent.entzipcode
where agt.agtzipcode = ent.entzipcode order by agt.agentid;

-- Find entertainers who played engagement for either customer Berg or Hallmark
Select distinct ent.entstagename as 'Entertainer' from entertainers ent
inner join engagements eg on ent.entertainerid = eg.entertainerid
inner join customers cust on eg.customerid = cust.customerid
where cust.custlastname in ('Berg','Hallmark');

-- List customers with no bookings
Select cust.customerid as 'CustID', concat(cust.custfirstname,' ', cust.custlastname) as 'Custname', eg.EngagementNumber from customers cust
left join engagements eg on cust.customerid = eg.customerid
where eg.engagementnumber is Null;

-- Prodvide a list of customers who like contemporary music together with a list of entertainers who play contemporary music
Select cust.customerid, concat(cust.custfirstname,' ', cust.custlastname) as 'Custname', ms.stylename, 'Customer' as 'type' from customers cust
left join musical_preferences mp on cust.customerid = mp.customerid
left join musical_styles ms on mp.styleid = ms.styleid
where ms.stylename in ('Contemporary')
UNION
Select  ent.entertainerid, ent.entstagename, ms.stylename, 'Entertainer' as 'type' from entertainers ent
left join entertainer_styles es on ent.entertainerid = es.entertainerid
left join musical_styles ms on es.styleid = ms.styleid
where ms.stylename in ('Contemporary');

-- List customers who have booked entertainers who play country or country rock
Select distinct c.customerid, Concat(c.custfirstname,' ',c.custlastname) as 'Custname' from customers c 
inner join engagements eg on c.customerid = eg.customerid
inner join entertainer_styles es on eg.entertainerid = es.entertainerid 
where es.styleid in (select styleid from musical_styles where stylename in ('Country','Country Rock'));

-- Add 5% to the commision rate of agents who have sold more than $20,000 in engagements
Update agents agt
set commissionrate = commissionrate + 0.05 
where agentid in (Select agentid from engagements eg group by agentid having sum(eg.contractprice) >= 20000);