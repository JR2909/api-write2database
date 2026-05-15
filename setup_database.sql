-- =============================================================
-- Datenbankschema für Wetterdaten (OpenWeatherMap)
-- SQLite-kompatibel
-- =============================================================
CREATE DATABASE IF NOT EXISTS cloud_computing_db;
USE cloud_computing_db;


CREATE TABLE IF NOT EXISTS cities (
    id               INTEGER PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(64)  NOT NULL UNIQUE,
    country          VARCHAR(64),
    lat              FLOAT,
    lon              FLOAT,
    timezone_offset  INTEGER
);


-- Aktuelle Wettermessungen
CREATE TABLE IF NOT EXISTS weather_current (
    id                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    city_id             INTEGER NOT NULL,
    fetched_at          VARCHAR(64)    NOT NULL,   -- UTC-Zeitpunkt des API-Abrufs
    measured_at         VARCHAR(64)    NOT NULL,   -- Messzeitpunkt laut API (UTC)
    temp                FLOAT,
    feels_like          FLOAT,
    temp_min            FLOAT,
    temp_max            FLOAT,
    humidity            INTEGER,
    pressure            INTEGER,
    weather_main        VARCHAR(64),
    weather_description VARCHAR(64),
    weather_icon        VARCHAR(64),
    wind_speed          FLOAT,
    wind_deg            INTEGER,
    clouds              INTEGER,
    visibility          INTEGER,
    sunrise             VARCHAR(64),
    sunset              VARCHAR(64),
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- 5-Tage-Vorhersage (3-Stunden-Intervalle)
CREATE TABLE IF NOT EXISTS weather_forecast (
    id                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    city_id             INTEGER NOT NULL,
    fetched_at          VARCHAR(64)    NOT NULL,   -- UTC-Zeitpunkt des API-Abrufs
    forecast_at         VARCHAR(64)    NOT NULL,   -- Vorhersagezeitpunkt (UTC)
    temp                FLOAT,
    feels_like          FLOAT,
    temp_min            FLOAT,
    temp_max            FLOAT,
    humidity            INTEGER,
    pressure            INTEGER,
    weather_main        VARCHAR(64),
    weather_description VARCHAR(64),
    weather_icon        VARCHAR(64),
    wind_speed          FLOAT,
    wind_deg            INTEGER,
    clouds              INTEGER,
    pop                 FLOAT,              -- Niederschlagswahrscheinlichkeit (0-1)
    FOREIGN KEY (city_id) REFERENCES cities(id)
);



