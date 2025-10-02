USE crime_db;

-- ========================
-- STORED PROCEDURES
-- ========================

-- 1. Add a new FIR
DELIMITER //
CREATE PROCEDURE AddFIR (
    IN p_Date_Filed DATE,
    IN p_Description TEXT,
    IN p_Officer_ID INT,
    IN p_Location_ID INT
)
BEGIN
    INSERT INTO FIR (Date_Filed, Description, Officer_ID, Location_ID)
    VALUES (p_Date_Filed, p_Description, p_Officer_ID, p_Location_ID);
END //
DELIMITER ;

-- 2. Add a new Suspect
DELIMITER //
CREATE PROCEDURE AddSuspect (
    IN p_Name VARCHAR(100),
    IN p_Age INT,
    IN p_Gender VARCHAR(10),
    IN p_Address VARCHAR(255)
)
BEGIN
    INSERT INTO Suspect (Name, Age, Gender, Address)
    VALUES (p_Name, p_Age, p_Gender, p_Address);
END //
DELIMITER ;

-- 3. Add a new Criminal
DELIMITER //
CREATE PROCEDURE AddCriminal (
    IN p_Name VARCHAR(100),
    IN p_Age INT,
    IN p_Gender VARCHAR(10),
    IN p_Address VARCHAR(255),
    IN p_Crime_History TEXT
)
BEGIN
    INSERT INTO Criminal (Name, Age, Gender, Address, Crime_History)
    VALUES (p_Name, p_Age, p_Gender, p_Address, p_Crime_History);
END //
DELIMITER ;

-- 4. Add a new Case
DELIMITER //
CREATE PROCEDURE AddCase (
    IN p_Case_Title VARCHAR(200),
    IN p_Status VARCHAR(50),
    IN p_FIR_ID INT,
    IN p_Criminal_ID INT,
    IN p_Suspect_ID INT
)
BEGIN
    INSERT INTO CaseFile (Case_Title, Status, FIR_ID, Criminal_ID, Suspect_ID)
    VALUES (p_Case_Title, p_Status, p_FIR_ID, p_Criminal_ID, p_Suspect_ID);
END //
DELIMITER ;

-- 5. Add Evidence
DELIMITER //
CREATE PROCEDURE AddEvidence (
    IN p_Case_ID INT,
    IN p_Evidence_Type VARCHAR(100),
    IN p_Description TEXT,
    IN p_Collected_On DATE
)
BEGIN
    INSERT INTO Evidence (Case_ID, Evidence_Type, Description, Collected_On)
    VALUES (p_Case_ID, p_Evidence_Type, p_Description, p_Collected_On);
END //
DELIMITER ;

-- 6. Update Case Status
DELIMITER //
CREATE PROCEDURE UpdateCaseStatus (
    IN p_Case_ID INT,
    IN p_Status VARCHAR(50)
)
BEGIN
    UPDATE CaseFile
    SET Status = p_Status
    WHERE Case_ID = p_Case_ID;
END //
DELIMITER ;

-- 7. Get all Cases by Status
DELIMITER //
CREATE PROCEDURE GetCasesByStatus (
    IN p_Status VARCHAR(50)
)
BEGIN
    SELECT * FROM CaseFile
    WHERE Status = p_Status;
END //
DELIMITER ;

-- 8. Get Criminal History
DELIMITER //
CREATE PROCEDURE GetCriminalHistory (
    IN p_Criminal_ID INT
)
BEGIN
    SELECT * FROM Criminal
    WHERE Criminal_ID = p_Criminal_ID;
END //
DELIMITER ;

-- 9. Get FIRs by Officer
DELIMITER //
CREATE PROCEDURE GetFIRsByOfficer (
    IN p_Officer_ID INT
)
BEGIN
    SELECT * FROM FIR
    WHERE Officer_ID = p_Officer_ID;
END //
DELIMITER ;

-- ========================
-- EXTRA ANALYTICAL PROCEDURES
-- ========================

-- 10. Most Crime-Prone Location
DELIMITER //
CREATE PROCEDURE GetMostCrimeProneLocation()
BEGIN
    SELECT cl.City, cl.State, COUNT(f.FIR_ID) AS TotalCrimes
    FROM FIR f
    JOIN Crime_Location cl ON f.Location_ID = cl.Location_ID
    GROUP BY cl.City, cl.State
    ORDER BY TotalCrimes DESC
    LIMIT 1;
END //
DELIMITER ;

-- 11. Top Officers by Cases Solved
DELIMITER //
CREATE PROCEDURE GetTopOfficersByCasesSolved()
BEGIN
    SELECT o.Name, COUNT(c.Case_ID) AS CasesSolved
    FROM CaseFile c
    JOIN FIR f ON c.FIR_ID = f.FIR_ID
    JOIN Officer o ON f.Officer_ID = o.Officer_ID
    WHERE c.Status = 'Closed'
    GROUP BY o.Officer_ID, o.Name
    ORDER BY CasesSolved DESC;
END //
DELIMITER ;

-- 12. Pending Cases Older Than X Days
DELIMITER //
CREATE PROCEDURE GetPendingCasesOlderThanXDays(IN p_days INT)
BEGIN
    SELECT c.Case_ID, c.Case_Title, c.Status, f.Date_Filed
    FROM CaseFile c
    JOIN FIR f ON c.FIR_ID = f.FIR_ID
    WHERE c.Status = 'Open'
    AND DATEDIFF(CURDATE(), f.Date_Filed) > p_days;
END //
DELIMITER ;
