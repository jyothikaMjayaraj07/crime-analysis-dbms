USE crime_db;

-- 1. List all active cases with officer details
SELECT * FROM View_Active_Cases;

-- 2. Show criminal history for each criminal
SELECT * FROM View_Criminal_History ORDER BY Criminal_Name;

-- 3. Get FIR summary with officer and location
SELECT * FROM View_FIR_Summary ORDER BY Date_Filed DESC;

-- 4. Show which suspects are linked to which cases
SELECT * FROM View_Suspect_Case_Link;

-- 5. Evidence collected for each case
SELECT * FROM View_Evidence_Summary;

-- 6. Top 5 officers by number of FIRs handled
SELECT Officer_Name, Total_FIRs
FROM View_Officer_Performance
ORDER BY Total_FIRs DESC
LIMIT 5;

-- 7. Top 5 officers by number of cases handled
SELECT Officer_Name, Total_Cases
FROM View_Officer_Performance
ORDER BY Total_Cases DESC
LIMIT 5;

-- 8. City-wise FIR statistics
SELECT * FROM View_City_Crime_Stats ORDER BY Total_FIRs DESC;

-- 9. Longest running open cases
SELECT Case_ID, Case_Title, Days_Since_Filed, Status
FROM View_Case_Duration
WHERE Status <> 'Closed'
ORDER BY Days_Since_Filed DESC
LIMIT 10;

-- 10. Find suspects who are linked to cases still under investigation
SELECT s.Name AS Suspect_Name, c.Case_Title, c.Status
FROM Suspect s
JOIN CaseFile c ON s.Suspect_ID = c.Suspect_ID
WHERE c.Status = 'Under Investigation';

-- 11. Find criminals involved in more than one case
SELECT Criminal_Name, COUNT(Case_ID) AS Total_Cases
FROM View_Criminal_History
GROUP BY Criminal_ID
HAVING COUNT(Case_ID) > 1;

-- 12. Show evidence count per case
SELECT c.Case_Title, COUNT(e.Evidence_ID) AS Evidence_Count
FROM CaseFile c
LEFT JOIN Evidence e ON c.Case_ID = e.Case_ID
GROUP BY c.Case_ID
ORDER BY Evidence_Count DESC;
