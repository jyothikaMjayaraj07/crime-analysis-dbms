USE crime_db;

-- Drop old views if they exist
DROP VIEW IF EXISTS View_Active_Cases;
DROP VIEW IF EXISTS View_Criminal_History;
DROP VIEW IF EXISTS View_FIR_Summary;
DROP VIEW IF EXISTS View_Suspect_Case_Link;
DROP VIEW IF EXISTS View_Evidence_Summary;
DROP VIEW IF EXISTS View_Officer_Performance;
DROP VIEW IF EXISTS View_City_Crime_Stats;
DROP VIEW IF EXISTS View_Case_Duration;

-- 1. Active Cases (not yet closed)
CREATE VIEW View_Active_Cases AS
SELECT c.Case_ID, c.Case_Title, c.Status, f.Date_Filed, o.Name AS Officer_Name
FROM CaseFile c
JOIN FIR f ON c.FIR_ID = f.FIR_ID
JOIN Officer o ON f.Officer_ID = o.Officer_ID
WHERE c.Status IN ('Open', 'Under Investigation', 'Under Trial');

-- 2. Criminal History (all cases tied to a criminal)
CREATE VIEW View_Criminal_History AS
SELECT cr.Criminal_ID, cr.Name AS Criminal_Name, c.Case_ID, c.Case_Title, c.Status,
       f.Date_Filed, f.Description AS FIR_Details
FROM Criminal cr
JOIN CaseFile c ON cr.Criminal_ID = c.Criminal_ID
JOIN FIR f ON c.FIR_ID = f.FIR_ID;

-- 3. FIR Summary with officer & location
CREATE VIEW View_FIR_Summary AS
SELECT f.FIR_ID, f.Date_Filed, f.Description, o.Name AS Officer_Name, o.Station,
       l.City, l.State
FROM FIR f
JOIN Officer o ON f.Officer_ID = o.Officer_ID
JOIN Crime_Location l ON f.Location_ID = l.Location_ID;

-- 4. Suspect-Case Link
CREATE VIEW View_Suspect_Case_Link AS
SELECT s.Suspect_ID, s.Name AS Suspect_Name, c.Case_ID, c.Case_Title, c.Status
FROM Suspect s
JOIN CaseFile c ON s.Suspect_ID = c.Suspect_ID;

-- 5. Evidence Summary
CREATE VIEW View_Evidence_Summary AS
SELECT e.Evidence_ID, e.Evidence_Type, e.Description, e.Collected_On,
       c.Case_Title, c.Status
FROM Evidence e
JOIN CaseFile c ON e.Case_ID = c.Case_ID;

-- 6. Officer Performance (how many FIRs & cases handled)
CREATE VIEW View_Officer_Performance AS
SELECT o.Officer_ID, o.Name AS Officer_Name, COUNT(DISTINCT f.FIR_ID) AS Total_FIRs,
       COUNT(DISTINCT c.Case_ID) AS Total_Cases
FROM Officer o
LEFT JOIN FIR f ON o.Officer_ID = f.Officer_ID
LEFT JOIN CaseFile c ON f.FIR_ID = c.FIR_ID
GROUP BY o.Officer_ID;

-- 7. City Crime Stats (count of FIRs by city/state)
CREATE VIEW View_City_Crime_Stats AS
SELECT l.City, l.State, COUNT(f.FIR_ID) AS Total_FIRs
FROM Crime_Location l
LEFT JOIN FIR f ON l.Location_ID = f.Location_ID
GROUP BY l.City, l.State;

-- 8. Case Duration (days since FIR filed)
CREATE VIEW View_Case_Duration AS
SELECT c.Case_ID, c.Case_Title, f.Date_Filed,
       DATEDIFF(CURDATE(), f.Date_Filed) AS Days_Since_Filed,
       c.Status
FROM CaseFile c
JOIN FIR f ON c.FIR_ID = f.FIR_ID;
