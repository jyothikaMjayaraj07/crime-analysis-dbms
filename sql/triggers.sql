USE crime_db;

-- ============================================
-- 1. BUSINESS RULE TRIGGERS
-- ============================================

-- 1. Log FIR into Evidence table
DROP TRIGGER IF EXISTS after_fir_insert;
DELIMITER //
CREATE TRIGGER after_fir_insert
AFTER INSERT ON FIR
FOR EACH ROW
BEGIN
    INSERT INTO Evidence (Case_ID, Evidence_Type, Description, Collected_On)
    VALUES (NULL, 'System Log', CONCAT('New FIR filed with ID: ', NEW.FIR_ID), CURDATE());
END //
DELIMITER ;

-- 2. Auto-close CaseFile when marked as 'Closed'
DROP TRIGGER IF EXISTS before_casefile_update;
DELIMITER //
CREATE TRIGGER before_casefile_update
BEFORE UPDATE ON CaseFile
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Closed' THEN
        SET NEW.Status = 'Closed'; -- enforce closed state
    END IF;
END //
DELIMITER ;

-- 3. Prevent duplicate suspects (same Name + Age)
DROP TRIGGER IF EXISTS before_suspect_insert;
DELIMITER //
CREATE TRIGGER before_suspect_insert
BEFORE INSERT ON Suspect
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Suspect WHERE Name = NEW.Name AND Age = NEW.Age) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate suspect entry not allowed';
    END IF;
END //
DELIMITER ;

-- 4. Auto-update CaseFile status when evidence is added
DROP TRIGGER IF EXISTS after_evidence_insert;
DELIMITER //
CREATE TRIGGER after_evidence_insert
AFTER INSERT ON Evidence
FOR EACH ROW
BEGIN
    UPDATE CaseFile
    SET Status = 'Under Investigation'
    WHERE Case_ID = NEW.Case_ID AND Status = 'Open';
END //
DELIMITER ;


-- ============================================
-- 2. FULL AUDIT LOG TRIGGERS (21 total)
-- ============================================

-- OFFICER
DROP TRIGGER IF EXISTS log_officer_insert;
DROP TRIGGER IF EXISTS log_officer_update;
DROP TRIGGER IF EXISTS log_officer_delete;
DELIMITER //
CREATE TRIGGER log_officer_insert AFTER INSERT ON Officer
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Officer','INSERT',NEW.Officer_ID,CONCAT('Officer added: ',NEW.Name,' (',NEW.Rank_name,')'),USER());
END //
CREATE TRIGGER log_officer_update AFTER UPDATE ON Officer
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Officer','UPDATE',NEW.Officer_ID,CONCAT('Officer updated: ',OLD.Name,' → ',NEW.Name),USER());
END //
CREATE TRIGGER log_officer_delete AFTER DELETE ON Officer
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Officer','DELETE',OLD.Officer_ID,CONCAT('Officer removed: ',OLD.Name),USER());
END //
DELIMITER ;

-- CRIMINAL
DROP TRIGGER IF EXISTS log_criminal_insert;
DROP TRIGGER IF EXISTS log_criminal_update;
DROP TRIGGER IF EXISTS log_criminal_delete;
DELIMITER //
CREATE TRIGGER log_criminal_insert AFTER INSERT ON Criminal
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Criminal','INSERT',NEW.Criminal_ID,CONCAT('Criminal added: ',NEW.Name),USER());
END //
CREATE TRIGGER log_criminal_update AFTER UPDATE ON Criminal
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Criminal','UPDATE',NEW.Criminal_ID,CONCAT('Criminal updated: ',OLD.Name,' → ',NEW.Name),USER());
END //
CREATE TRIGGER log_criminal_delete AFTER DELETE ON Criminal
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Criminal','DELETE',OLD.Criminal_ID,CONCAT('Criminal removed: ',OLD.Name),USER());
END //
DELIMITER ;

-- SUSPECT
DROP TRIGGER IF EXISTS log_suspect_insert;
DROP TRIGGER IF EXISTS log_suspect_update;
DROP TRIGGER IF EXISTS log_suspect_delete;
DELIMITER //
CREATE TRIGGER log_suspect_insert AFTER INSERT ON Suspect
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Suspect','INSERT',NEW.Suspect_ID,CONCAT('Suspect added: ',NEW.Name),USER());
END //
CREATE TRIGGER log_suspect_update AFTER UPDATE ON Suspect
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Suspect','UPDATE',NEW.Suspect_ID,CONCAT('Suspect updated: ',OLD.Name,' → ',NEW.Name),USER());
END //
CREATE TRIGGER log_suspect_delete AFTER DELETE ON Suspect
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Suspect','DELETE',OLD.Suspect_ID,CONCAT('Suspect removed: ',OLD.Name),USER());
END //
DELIMITER ;

-- FIR
DROP TRIGGER IF EXISTS log_fir_insert;
DROP TRIGGER IF EXISTS log_fir_update;
DROP TRIGGER IF EXISTS log_fir_delete;
DELIMITER //
CREATE TRIGGER log_fir_insert AFTER INSERT ON FIR
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('FIR','INSERT',NEW.FIR_ID,CONCAT('FIR filed by Officer ',NEW.Officer_ID),USER());
END //
CREATE TRIGGER log_fir_update AFTER UPDATE ON FIR
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('FIR','UPDATE',NEW.FIR_ID,CONCAT('FIR updated: ',OLD.Description,' → ',NEW.Description),USER());
END //
CREATE TRIGGER log_fir_delete AFTER DELETE ON FIR
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('FIR','DELETE',OLD.FIR_ID,CONCAT('FIR removed: ',OLD.Description),USER());
END //
DELIMITER ;

-- CASEFILE
DROP TRIGGER IF EXISTS log_casefile_insert;
DROP TRIGGER IF EXISTS log_casefile_update;
DROP TRIGGER IF EXISTS log_casefile_delete;
DELIMITER //
CREATE TRIGGER log_casefile_insert AFTER INSERT ON CaseFile
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('CaseFile','INSERT',NEW.Case_ID,CONCAT('Case created: ',NEW.Case_Title),USER());
END //
CREATE TRIGGER log_casefile_update AFTER UPDATE ON CaseFile
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('CaseFile','UPDATE',NEW.Case_ID,CONCAT('Case status changed: ',OLD.Status,' → ',NEW.Status),USER());
END //
CREATE TRIGGER log_casefile_delete AFTER DELETE ON CaseFile
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('CaseFile','DELETE',OLD.Case_ID,CONCAT('Case removed: ',OLD.Case_Title),USER());
END //
DELIMITER ;

-- EVIDENCE
DROP TRIGGER IF EXISTS log_evidence_insert;
DROP TRIGGER IF EXISTS log_evidence_update;
DROP TRIGGER IF EXISTS log_evidence_delete;
DELIMITER //
CREATE TRIGGER log_evidence_insert AFTER INSERT ON Evidence
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Evidence','INSERT',NEW.Evidence_ID,CONCAT('Evidence added: ',NEW.Evidence_Type,' for Case ',NEW.Case_ID),USER());
END //
CREATE TRIGGER log_evidence_update AFTER UPDATE ON Evidence
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Evidence','UPDATE',NEW.Evidence_ID,CONCAT('Evidence updated: ',OLD.Description,' → ',NEW.Description),USER());
END //
CREATE TRIGGER log_evidence_delete AFTER DELETE ON Evidence
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Evidence','DELETE',OLD.Evidence_ID,CONCAT('Evidence removed: ',OLD.Description),USER());
END //
DELIMITER ;

-- CRIME LOCATION
DROP TRIGGER IF EXISTS log_location_insert;
DROP TRIGGER IF EXISTS log_location_update;
DROP TRIGGER IF EXISTS log_location_delete;
DELIMITER //
CREATE TRIGGER log_location_insert AFTER INSERT ON Crime_Location
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Crime_Location','INSERT',NEW.Location_ID,CONCAT('Location added: ',NEW.City,', ',NEW.State),USER());
END //
CREATE TRIGGER log_location_update AFTER UPDATE ON Crime_Location
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Crime_Location','UPDATE',NEW.Location_ID,CONCAT('Location updated: ',OLD.City,' → ',NEW.City),USER());
END //
CREATE TRIGGER log_location_delete AFTER DELETE ON Crime_Location
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Operation, Record_ID, Details, Changed_By)
    VALUES ('Crime_Location','DELETE',OLD.Location_ID,CONCAT('Location removed: ',OLD.City,', ',OLD.State),USER());
END //
DELIMITER ;
