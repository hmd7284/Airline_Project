-- Trigger to automatically update address of the airport
CREATE OR REPLACE FUNCTION update_address()
RETURNS TRIGGER AS 
$$
BEGIN
    UPDATE airport 
    SET address = (SELECT city_name || ', '|| country_name
                   FROM cities
                   JOIN countries ON cities.country = countries.country_code
                   WHERE cities.city_code = NEW.city)
    WHERE airport.city = NEW.city;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_address
AFTER INSERT ON airport
FOR EACH ROW
EXECUTE FUNCTION  update_address();

-- Insert some airports
INSERT INTO airport(airport_code, airport_name, city)  VALUES('SWF','Stewart International', 'NYC');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('HND','Tokyo Intl (Haneda)', 'TYO');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('BGH','Biggin Hill', 'LON');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('NAY','Nanyuan', 'PEK');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('PHT','Henry County', 'PAR');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('BML','Berlin Reg. Airport', 'BER');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('YQY','J.A. Douglas McCurdy', 'SYD');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('YHM','John C. Munro Hamilton', 'YTO');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('DMK','Don Mueang Int''l', 'BKK');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('SAW','Sabiha Gokcen', 'IST');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('HLA','Lanseria International', 'JNB');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('TGA','Tengah', 'SIN');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('PSK','New River Valley', 'DUB');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('AZP','Atizapan-Jimenez Cantu', 'MEX');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('DEL','Indira Gandhi Intl', 'DEL');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('ZRH','Zurich Airport', 'ZRH');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('ICN','Incheon International', 'SEL');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('HKG','Hong Kong Intl.', 'HKG');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('HAN','Noi Bai Intl', 'HAN');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('WHP','Whiteman', 'LAX');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('KIX','Kansai International', 'OSA');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('MHT','Manchester-Boston Rgnl', 'MAN');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('PVG','Pudong Intl', 'SHA');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('CDG','Charles de Gaulle', 'CDG');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('AGB','Augsburg Airport', 'MUC');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('MLB','Orlando Melbourne Intl', 'MEL');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('CXH','Harbour SPB', 'YVR');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('BNE','Brisbane Intl.', 'BNE');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('SGN','Tan Son Nhat Intl', 'HCM');
INSERT INTO airport(airport_code, airport_name, city)  VALUES('DAD','Da Nang Intl.', 'DAD');

	
	
	
	



	




	
	


