/*Age Categories*/

CREATE TEMP TABLE AGECAT AS -- Creating TEMP TABLE AGECAT
SELECT 
  age, region, charges,

  CASE 
  WHEN age <= 19 THEN 'Teen'
  WHEN age BETWEEN 20 AND 39 THEN 'Adult'
  WHEN age BETWEEN 40 AND 59 THEN 'Middle Age'
  WHEN age >= 60 THEN 'Senior'
  END AS AgeCategory
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;


/*Age Category Averages*/
SELECT 
  DISTINCT AgeCategory, 
  COUNT(*) OVER (PARTITION BY AgeCategory) AS AgeCategoryCount,
  ROUND(AVG(charges) OVER (PARTITION BY AgeCategory),2) AS AvgChargeAge
FROM AGECAT
ORDER BY AvgChargeAge;


/*Correlation Between Age and Charges*/
SELECT
  ROUND(CORR(Age,charges),2) AS CORR_Age_Charges
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;
-- Low correlation between age and charges 


/*Distribution of Charges*/
SELECT 
  DISTINCT TRUNC(charges,-3) AS Charge_Bin, 
  COUNT(*) AS Count
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
GROUP BY Charge_Bin
ORDER BY Charge_Bin;
--Right skew of distribution


/*Male Distrubution of Charges*/
SELECT  
  DISTINCT sex,
  TRUNC(charges,-4) AS charge_bins,
  COUNT(*) AS Count
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
WHERE Sex = 'male'
GROUP BY sex,charge_bins
ORDER BY charge_bins;
--Right skew


/*Female Distribution of Charges*/
SELECT  
  DISTINCT sex,
  TRUNC(charges,-4) AS charge_bins,
  COUNT(*)
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
WHERE Sex = 'female'
GROUP BY sex,charge_bins
ORDER BY charge_bins;
-- Right skew


/*Male and Female Average Charges*/
SELECT 
  DISTINCT Sex, 
  ROUND(AVG(charges) OVER (PARTITION BY sex),2) AS Avg_Charges_Sex
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;



/*Male and Female Median Charges*/
SELECT 
  DISTINCT Sex,
  ROUND(PERCENTILE_CONT(charges, 0.50) OVER (PARTITION BY Sex),2) AS Sex_Median
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;


/*Smoker Region Totals*/
SELECT
  DISTINCT region,smoker, COUNT(smoker) OVER (PARTITION BY region, 
  smoker) AS SmokerRegionCount,COUNT(smoker) OVER () AS TotalSmokerCount,
  ROUND((COUNT(smoker) OVER (PARTITION BY region, smoker)/COUNT(smoker) OVER ()*100),0) AS SmokerPercentage
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
WHERE smoker = true
ORDER BY SmokerRegionCount;
--Southwest has the least amount of smokers


SELECT
  Smoker, 
  ROUND(AVG(charges),2) AS Avg_Smoking_Charges
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
GROUP BY Smoker;


/*Comparing charges for smokers to non-smokers*/
SELECT
  ROUND(32050.23/8434.27);
--smoking accounts for an average cost that is about four times greater than a non-smoker



/*Smokers by Region - Sex*/
SELECT
  DISTINCT sex,region,smoker, COUNT(smoker) OVER (PARTITION BY region, sex, smoker) AS SmokerRegionCount,
  COUNT(smoker) OVER () AS SmokerTotal, 
  ROUND((COUNT(smoker) OVER (PARTITION BY region, sex, smoker)/COUNT(smoker) OVER () * 100),0) AS RegionFemaleSmokerPercentage
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
WHERE smoker = true
ORDER BY SmokerRegionCount;
--Southwest has lowest number of female smokers



/*Children and Charge Correlation*/
SELECT 
  ROUND(CORR(children, charges),2) AS CORR_CO_Charges
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;



/*Region Median Charges*/
SELECT 
   DISTINCT Region,
   ROUND(PERCENTILE_CONT(charges, 0.50) OVER (PARTITION BY Region),2) AS Region_Median,
  ROUND(PERCENTILE_CONT(charges, 0.50) OVER (),2) AS Overall_Median
FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`
ORDER BY Region_Median;



/*BMI Categories*/
CREATE TEMP TABLE BMI_Table AS
SELECT 
*,
  CASE 
  WHEN BMI < 18.5 THEN 'Underweight'
  WHEN BMI >= 18.5 AND BMI < 25 THEN 'Normal'
  WHEN BMI >= 25 AND BMI < 30 THEN 'Overweight'
  WHEN BMI >= 30 THEN 'Obese'
  END AS BMI_Category,

  CASE 
  WHEN BMI < 30 THEN 'Not Obese'
  WHEN BMI >= 30 THEN 'Obese'
  END Obese

FROM `single-being-353600.Medical_Insurance_Data.Insurance_Data`;

SELECT 
  BMI_Category,
  ROUND(AVG(charges),2) AS Avg_Cost
FROM BMI_Table
GROUP BY BMI_Category
ORDER BY Avg_Cost;


SELECT 
  BMI_Category,
  ROUND(AVG(charges),2) AS Avg_Cost
FROM BMI_Table
GROUP BY BMI_Category
ORDER BY Avg_Cost;


