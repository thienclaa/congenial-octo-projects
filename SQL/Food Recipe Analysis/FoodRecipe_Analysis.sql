-- Show a list of all the ingredients we currently keep track of
Select ingredientid, ingredientname from ingredients;

-- List the recipes that have no notes
Select recipeid, recipetitle, notes from recipes
where notes is Null;

-- Provide a list of recipes that contain eggs in their preparation
Select recipetitle from recipes where preparation like '%egg%';

-- Show the ingredients that are meats
Select i.ingredientname, ic.ingredientclassdescription from ingredients i
inner join ingredient_classes ic on i.ingredientclassid = ic.ingredientclassid 
where ic.ingredientclassdescription = 'Meat';

-- Show the ingredients that are meats but that aren’t chicken
Select i.ingredientname, ic.ingredientclassdescription from ingredients i
inner join ingredient_classes ic on i.ingredientclassid = ic.ingredientclassid 
where ic.ingredientclassdescription = 'Meat' and i.ingredientname not like '%Chicken%';

-- List all meat ingredients and the count of recipes that include each one
Select ic.ingredientclassdescription, i.ingredientname, count(ri.recipeid) as recipe_count from ingredient_classes ic
inner join ingredients i on i.ingredientclassid = ic.ingredientclassid 
inner join recipe_ingredients ri on ri.ingredientid = i.ingredientid
where ic.ingredientclassdescription = 'Meat' group by ic.ingredientclassdescription, i.ingredientname;

-- What class of recipe have two or more recipes
Select count(r.recipeclassid) as recipes_count, rc.recipeclassdescription from recipes r
left outer join recipe_classes rc on r.recipeclassid = rc.recipeclassid
group by r.recipeclassid having count(r.recipeclassid) >=2;

-- Display all recipe classes and any recipes that might be associated with them.
Select rc.recipeclassid, rc.recipeclassdescription, r.recipetitle, r.recipeid from recipe_classes rc
left join recipes r on rc.recipeclassid = r.recipeclassid
where r.recipetitle is not Null;
