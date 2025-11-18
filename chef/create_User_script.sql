-- 1. Neuen User anlegen und ihm die Rechte zur Datenbank geben
CREATE USER bundesheer_user WITH PASSWORD '5678910'; 
GRANT CONNECT ON DATABASE bundesheer_db TO bundesheer_user;