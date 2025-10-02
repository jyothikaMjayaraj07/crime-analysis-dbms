USE crime_db;

-- Officer lookups
CREATE INDEX idx_officer_name   ON Officer(Name);
CREATE INDEX idx_officer_station ON Officer(Station);

-- FIR filters & joins
CREATE INDEX idx_fir_date    ON FIR(Date_Filed);
CREATE INDEX idx_fir_officer ON FIR(Officer_ID);
CREATE INDEX idx_fir_location ON FIR(Location_ID);

-- CaseFile filters & joins
CREATE INDEX idx_case_status   ON CaseFile(Status);
CREATE INDEX idx_case_fir      ON CaseFile(FIR_ID);
CREATE INDEX idx_case_criminal ON CaseFile(Criminal_ID);
CREATE INDEX idx_case_suspect  ON CaseFile(Suspect_ID);

-- Evidence join
CREATE INDEX idx_evidence_case ON Evidence(Case_ID);

-- Location filters
CREATE INDEX idx_city_state ON Crime_Location(City, State);

-- Name searches
CREATE INDEX idx_criminal_name ON Criminal(Name);
CREATE INDEX idx_suspect_name  ON Suspect(Name);
