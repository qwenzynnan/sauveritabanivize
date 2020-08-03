--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bolumdekidersler1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bolumdekidersler1() RETURNS TABLE(bolumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT * FROM "Bolum" inner join "Ders" on "Bolum"."BolumNo" = "Ders"."BolumNo";
END;
$$;


ALTER FUNCTION public.bolumdekidersler1() OWNER TO postgres;

--
-- Name: ililcelistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ililcelistele() RETURNS void
    LANGUAGE sql
    AS $$
  SELECT "ilAdi","ilceAdi" FROM "ilce" inner join "il" on "il"."ilNo" = "ilce"."ilNo";
$$;


ALTER FUNCTION public.ililcelistele() OWNER TO postgres;

--
-- Name: isim_buyut(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isim_buyut() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."ilAdi" = UPPER(NEW."ilAdi");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.isim_buyut() OWNER TO postgres;

--
-- Name: kampustekibinasayisi(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kampustekibinasayisi(secenek integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "Bina" WHERE "kampusNo" = secenek ;
   RETURN a;
END;
$$;


ALTER FUNCTION public.kampustekibinasayisi(secenek integer) OWNER TO postgres;

--
-- Name: log_ogretimuyesi_soyadi_degisikligi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_ogretimuyesi_soyadi_degisikligi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW."soyisim" <> OLD."soyisim" THEN
		 INSERT INTO public."Ogretim Uyesi"("SicilNo","soyisim")
		 VALUES(OLD."SicilNo",OLD."soyisim");
	END IF;

	RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_ogretimuyesi_soyadi_degisikligi() OWNER TO postgres;

--
-- Name: ogrenci_aktif(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenci_aktif() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."aktifMi" = NEW."aktifMi"= True;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ogrenci_aktif() OWNER TO postgres;

--
-- Name: temizle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.temizle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."binaAdi" = LTRIM(NEW."binaAdi");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.temizle() OWNER TO postgres;

--
-- Name: toplam_bolum_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_bolum_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "Bolum";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_bolum_sayisi() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Bilgiler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bilgiler" (
    "universiteNo" integer NOT NULL,
    "BolumSayisi" integer NOT NULL,
    "OgretmenSayisi" integer NOT NULL,
    "OgrenciSayisi" integer
);


ALTER TABLE public."Bilgiler" OWNER TO postgres;

--
-- Name: Bilgiler_BolumSayisi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilgiler_BolumSayisi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilgiler_BolumSayisi_seq" OWNER TO postgres;

--
-- Name: Bilgiler_BolumSayisi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilgiler_BolumSayisi_seq" OWNED BY public."Bilgiler"."BolumSayisi";


--
-- Name: Bilgiler_OgretmenSayisi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilgiler_OgretmenSayisi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilgiler_OgretmenSayisi_seq" OWNER TO postgres;

--
-- Name: Bilgiler_OgretmenSayisi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilgiler_OgretmenSayisi_seq" OWNED BY public."Bilgiler"."OgretmenSayisi";


--
-- Name: Bilgiler_universiteNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilgiler_universiteNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilgiler_universiteNo_seq" OWNER TO postgres;

--
-- Name: Bilgiler_universiteNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilgiler_universiteNo_seq" OWNED BY public."Bilgiler"."universiteNo";


--
-- Name: Bina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bina" (
    "binaNo" integer NOT NULL,
    "binaAdi" character varying(2044) NOT NULL,
    "derslikSayisi" integer NOT NULL,
    "fakülteNo" integer NOT NULL,
    "kampüsNo" integer NOT NULL
);


ALTER TABLE public."Bina" OWNER TO postgres;

--
-- Name: Bina_binaNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bina_binaNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bina_binaNo_seq" OWNER TO postgres;

--
-- Name: Bina_binaNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bina_binaNo_seq" OWNED BY public."Bina"."binaNo";


--
-- Name: Bolum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bolum" (
    "BolumNo" integer NOT NULL,
    "FakulteNo" integer NOT NULL,
    "BolumAdi" character varying(2044) NOT NULL
);


ALTER TABLE public."Bolum" OWNER TO postgres;

--
-- Name: Bolum_BolumNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bolum_BolumNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bolum_BolumNo_seq" OWNER TO postgres;

--
-- Name: Bolum_BolumNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bolum_BolumNo_seq" OWNED BY public."Bolum"."BolumNo";


--
-- Name: Bolum_FakulteNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bolum_FakulteNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bolum_FakulteNo_seq" OWNER TO postgres;

--
-- Name: Bolum_FakulteNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bolum_FakulteNo_seq" OWNED BY public."Bolum"."FakulteNo";


--
-- Name: Dekan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dekan" (
    "sicilNo" integer NOT NULL,
    "FakulteNo" integer NOT NULL
);


ALTER TABLE public."Dekan" OWNER TO postgres;

--
-- Name: Dekan_sicilNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Dekan_sicilNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Dekan_sicilNo_seq" OWNER TO postgres;

--
-- Name: Dekan_sicilNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Dekan_sicilNo_seq" OWNED BY public."Dekan"."sicilNo";


--
-- Name: Ders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ders" (
    "dersKodu" integer NOT NULL,
    sube character varying(2044) NOT NULL,
    "dersKresisi" integer NOT NULL,
    "BolumNo" integer NOT NULL,
    "BinaNo" integer NOT NULL,
    "OgretmenSicilNo" integer NOT NULL
);


ALTER TABLE public."Ders" OWNER TO postgres;

--
-- Name: Ders_dersKodu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ders_dersKodu_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ders_dersKodu_seq" OWNER TO postgres;

--
-- Name: Ders_dersKodu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ders_dersKodu_seq" OWNED BY public."Ders"."dersKodu";


--
-- Name: Fakulte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fakulte" (
    "fakulteNo" integer NOT NULL,
    "fakulteAdi" character varying(2044) NOT NULL,
    "dekanSicilNo" integer NOT NULL,
    "universiteNo" integer NOT NULL
);


ALTER TABLE public."Fakulte" OWNER TO postgres;

--
-- Name: Fakulte_fakulteNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Fakulte_fakulteNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Fakulte_fakulteNo_seq" OWNER TO postgres;

--
-- Name: Fakulte_fakulteNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Fakulte_fakulteNo_seq" OWNED BY public."Fakulte"."fakulteNo";


--
-- Name: Kampus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kampus" (
    "kampusNo" integer NOT NULL,
    "kampusAdi" character varying(2044) NOT NULL,
    "ilceNo" integer NOT NULL,
    "universiteNo" integer NOT NULL
);


ALTER TABLE public."Kampus" OWNER TO postgres;

--
-- Name: Kampus_kampusNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kampus_kampusNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kampus_kampusNo_seq" OWNER TO postgres;

--
-- Name: Kampus_kampusNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kampus_kampusNo_seq" OWNED BY public."Kampus"."kampusNo";


--
-- Name: Kayit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kayit" (
    "ogrenciNo" integer NOT NULL,
    "dersKodu" integer NOT NULL,
    "kayıtTarihi" date NOT NULL
);


ALTER TABLE public."Kayit" OWNER TO postgres;

--
-- Name: Ogrenci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogrenci" (
    isim character varying(2044) NOT NULL,
    soyisim character varying(2044) NOT NULL,
    "dogumTarihi" date,
    "maksimumKredi" integer NOT NULL,
    "Danışman" integer NOT NULL,
    "notOrtalaması" integer NOT NULL,
    "ogrenciNo" integer NOT NULL,
    "UniversiteNo" integer,
    "aktifMi" boolean
);


ALTER TABLE public."Ogrenci" OWNER TO postgres;

--
-- Name: Ogrenci_ogrenciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ogrenci_ogrenciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ogrenci_ogrenciNo_seq" OWNER TO postgres;

--
-- Name: Ogrenci_ogrenciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ogrenci_ogrenciNo_seq" OWNED BY public."Ogrenci"."ogrenciNo";


--
-- Name: Ogretim Uyesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogretim Uyesi" (
    "sicilNo" integer NOT NULL,
    isim character varying(2044) NOT NULL,
    soyisim character varying(2044) NOT NULL,
    "ogretimUyesiTuru" character varying(2044) NOT NULL,
    "bolumNo" integer NOT NULL,
    "UniversiteNo" integer NOT NULL
);


ALTER TABLE public."Ogretim Uyesi" OWNER TO postgres;

--
-- Name: Ogretim Uyesi_sicilNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ogretim Uyesi_sicilNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ogretim Uyesi_sicilNo_seq" OWNER TO postgres;

--
-- Name: Ogretim Uyesi_sicilNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ogretim Uyesi_sicilNo_seq" OWNED BY public."Ogretim Uyesi"."sicilNo";


--
-- Name: Rektör; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rektör" (
    "sicilNo" integer NOT NULL,
    "universiteNo" integer NOT NULL
);


ALTER TABLE public."Rektör" OWNER TO postgres;

--
-- Name: Rektör_sicilNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rektör_sicilNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rektör_sicilNo_seq" OWNER TO postgres;

--
-- Name: Rektör_sicilNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rektör_sicilNo_seq" OWNED BY public."Rektör"."sicilNo";


--
-- Name: Universite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Universite" (
    "UniversiteNo" integer NOT NULL,
    "universiteAdi" character varying(2044) NOT NULL,
    "RektorSicilNo" integer NOT NULL
);


ALTER TABLE public."Universite" OWNER TO postgres;

--
-- Name: Universite_UniversiteNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Universite_UniversiteNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Universite_UniversiteNo_seq" OWNER TO postgres;

--
-- Name: Universite_UniversiteNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Universite_UniversiteNo_seq" OWNED BY public."Universite"."UniversiteNo";


--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    "ilNo" integer NOT NULL,
    "ilAdi" character varying(2044) NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: il_ilNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."il_ilNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."il_ilNo_seq" OWNER TO postgres;

--
-- Name: il_ilNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."il_ilNo_seq" OWNED BY public.il."ilNo";


--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    "ilceNo" integer NOT NULL,
    "ilceAdi" character varying(2044) NOT NULL,
    "ilNo" integer NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: ilce_ilceNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ilce_ilceNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ilce_ilceNo_seq" OWNER TO postgres;

--
-- Name: ilce_ilceNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ilce_ilceNo_seq" OWNED BY public.ilce."ilceNo";


--
-- Name: Bilgiler universiteNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilgiler" ALTER COLUMN "universiteNo" SET DEFAULT nextval('public."Bilgiler_universiteNo_seq"'::regclass);


--
-- Name: Bilgiler BolumSayisi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilgiler" ALTER COLUMN "BolumSayisi" SET DEFAULT nextval('public."Bilgiler_BolumSayisi_seq"'::regclass);


--
-- Name: Bilgiler OgretmenSayisi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilgiler" ALTER COLUMN "OgretmenSayisi" SET DEFAULT nextval('public."Bilgiler_OgretmenSayisi_seq"'::regclass);


--
-- Name: Bina binaNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina" ALTER COLUMN "binaNo" SET DEFAULT nextval('public."Bina_binaNo_seq"'::regclass);


--
-- Name: Bolum BolumNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bolum" ALTER COLUMN "BolumNo" SET DEFAULT nextval('public."Bolum_BolumNo_seq"'::regclass);


--
-- Name: Dekan sicilNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dekan" ALTER COLUMN "sicilNo" SET DEFAULT nextval('public."Dekan_sicilNo_seq"'::regclass);


--
-- Name: Ders dersKodu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ders" ALTER COLUMN "dersKodu" SET DEFAULT nextval('public."Ders_dersKodu_seq"'::regclass);


--
-- Name: Fakulte fakulteNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fakulte" ALTER COLUMN "fakulteNo" SET DEFAULT nextval('public."Fakulte_fakulteNo_seq"'::regclass);


--
-- Name: Kampus kampusNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kampus" ALTER COLUMN "kampusNo" SET DEFAULT nextval('public."Kampus_kampusNo_seq"'::regclass);


--
-- Name: Ogrenci ogrenciNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci" ALTER COLUMN "ogrenciNo" SET DEFAULT nextval('public."Ogrenci_ogrenciNo_seq"'::regclass);


--
-- Name: Ogretim Uyesi sicilNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogretim Uyesi" ALTER COLUMN "sicilNo" SET DEFAULT nextval('public."Ogretim Uyesi_sicilNo_seq"'::regclass);


--
-- Name: Rektör sicilNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rektör" ALTER COLUMN "sicilNo" SET DEFAULT nextval('public."Rektör_sicilNo_seq"'::regclass);


--
-- Name: Universite UniversiteNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Universite" ALTER COLUMN "UniversiteNo" SET DEFAULT nextval('public."Universite_UniversiteNo_seq"'::regclass);


--
-- Name: il ilNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il ALTER COLUMN "ilNo" SET DEFAULT nextval('public."il_ilNo_seq"'::regclass);


--
-- Name: ilce ilceNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce ALTER COLUMN "ilceNo" SET DEFAULT nextval('public."ilce_ilceNo_seq"'::regclass);


--
-- Data for Name: Bilgiler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bilgiler" VALUES
	(4, 4, 6, 0),
	(5, 2, 8, 0),
	(1, 5, 5, 2),
	(2, 3, 5, 2),
	(3, 5, 7, 1);


--
-- Data for Name: Bina; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bina" VALUES
	(1, 'Haşim Gürdamar', 12, 1, 2),
	(2, 'İlahiyat A', 10, 1, 2),
	(3, 'Fen Edebiyat C', 20, 2, 3);


--
-- Data for Name: Bolum; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bolum" VALUES
	(1, 1, 'Bilgisayar Mühendisliği'),
	(2, 1, 'Yazılım Mühendisliği'),
	(3, 1, 'Siber Güvenilk'),
	(4, 1, 'Bilgi İşlem'),
	(5, 2, 'Tarih'),
	(6, 2, 'Matematik'),
	(7, 2, 'Makine Mühendisliği'),
	(8, 3, 'Gıda Mühendisliği'),
	(9, 4, 'Gastronomi'),
	(10, 4, 'Tiyatro');


--
-- Data for Name: Dekan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Dekan" VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4);


--
-- Data for Name: Ders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ders" VALUES
	(1, '2A', 4, 1, 1, 2),
	(2, '1B', 6, 1, 1, 3),
	(3, '1C', 8, 5, 3, 6);


--
-- Data for Name: Fakulte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Fakulte" VALUES
	(1, 'Bilişim', 1, 2),
	(2, 'Fen Edebiyat', 2, 3),
	(3, 'Mühendislik', 3, 4),
	(4, 'Güzel Sanatlar', 4, 2);


--
-- Data for Name: Kampus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kampus" VALUES
	(2, 'Esentepe', 1, 2),
	(3, 'Maslak', 2, 3),
	(4, 'Merkez', 3, 4),
	(5, 'Sümele', 4, 5);


--
-- Data for Name: Kayit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kayit" VALUES
	(2, 2, '2017-11-11'),
	(3, 3, '2016-12-12');


--
-- Data for Name: Ogrenci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ogrenci" VALUES
	('Somer', 'Şef', '1992-08-08', 35, 2, 1, 4, 2, true),
	('Mehmet', 'Taş', '1992-07-07', 30, 4, 4, 3, 2, true),
	('Kubilay', 'Ceylan', NULL, 25, 2, 14, 5, 3, true),
	('Ayşe', 'yıldız', '1991-06-06', 30, 3, 3, 2, 1, true),
	('Ali', 'Veli', NULL, 50, 2, 2, 6, NULL, NULL);


--
-- Data for Name: Ogretim Uyesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ogretim Uyesi" VALUES
	(2, 'Celal', 'Çeken', '1', 1, 1),
	(3, 'Ümit', 'Kocabıçak', '2', 2, 2),
	(4, 'Sinan', 'Kaya', '1', 3, 2),
	(5, 'Ali', 'Mehmet', '1', 4, 3),
	(6, 'İlber', 'Ortaylı', '1', 5, 3),
	(8, 'Tolga', 'Çevik', '1', 2, 4),
	(9, 'Cem', 'Yılmaz', '2', 3, 5),
	(10, 'Özlem', 'yıldız', '1', 2, 4),
	(11, 'Ali', 'Veli', '2', 3, 5),
	(7, 'Veli', 'Ali', '1', 2, 1),
	(1, 'Çakır', 'Memati', '1', 2, 1);


--
-- Data for Name: Rektör; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rektör" VALUES
	(8, 2),
	(9, 3),
	(10, 4),
	(7, 5),
	(11, 1);


--
-- Data for Name: Universite; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Universite" VALUES
	(2, 'Sakarya Üniversitesi', 7),
	(3, 'İstanbul Teknik Üniversitesi', 8),
	(4, 'ODTÜ', 9),
	(5, 'KATÜ', 10),
	(1, 'Bahçeşehir Üniversitesi', 11);


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	(1, 'Sakarya'),
	(2, 'İstanbul'),
	(3, 'Ankara'),
	(4, 'Trabzon'),
	(5, 'Kocaeli'),
	(6, 'Tekirdağ');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(1, 'Serdivan', 1),
	(2, 'Beşiktaş', 2),
	(3, 'Dikmen', 3),
	(4, 'Merke', 4),
	(5, 'Adapazarı', 1),
	(6, 'Karasu', 1),
	(7, 'Kocaali', 1),
	(8, 'Ataşehir', 2),
	(9, 'Kadıköy', 2),
	(10, 'Bakırköy', 2),
	(11, 'Çankaya', 3),
	(12, 'Bahçelievler', 3),
	(13, 'Of', 4);


--
-- Name: Bilgiler_BolumSayisi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilgiler_BolumSayisi_seq"', 1, false);


--
-- Name: Bilgiler_OgretmenSayisi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilgiler_OgretmenSayisi_seq"', 1, false);


--
-- Name: Bilgiler_universiteNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilgiler_universiteNo_seq"', 1, false);


--
-- Name: Bina_binaNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bina_binaNo_seq"', 3, true);


--
-- Name: Bolum_BolumNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bolum_BolumNo_seq"', 10, true);


--
-- Name: Bolum_FakulteNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bolum_FakulteNo_seq"', 1, false);


--
-- Name: Dekan_sicilNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Dekan_sicilNo_seq"', 3, true);


--
-- Name: Ders_dersKodu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ders_dersKodu_seq"', 3, true);


--
-- Name: Fakulte_fakulteNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Fakulte_fakulteNo_seq"', 3, true);


--
-- Name: Kampus_kampusNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kampus_kampusNo_seq"', 5, true);


--
-- Name: Ogrenci_ogrenciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ogrenci_ogrenciNo_seq"', 7, true);


--
-- Name: Ogretim Uyesi_sicilNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ogretim Uyesi_sicilNo_seq"', 6, true);


--
-- Name: Rektör_sicilNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rektör_sicilNo_seq"', 11, true);


--
-- Name: Universite_UniversiteNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Universite_UniversiteNo_seq"', 5, true);


--
-- Name: il_ilNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."il_ilNo_seq"', 6, true);


--
-- Name: ilce_ilceNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ilce_ilceNo_seq"', 13, true);


--
-- Name: Bilgiler Bilgiler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilgiler"
    ADD CONSTRAINT "Bilgiler_pkey" PRIMARY KEY ("universiteNo");


--
-- Name: Bina Bina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina"
    ADD CONSTRAINT "Bina_pkey" PRIMARY KEY ("binaNo");


--
-- Name: Bolum Bolum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bolum"
    ADD CONSTRAINT "Bolum_pkey" PRIMARY KEY ("BolumNo");


--
-- Name: Dekan Dekan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dekan"
    ADD CONSTRAINT "Dekan_pkey" PRIMARY KEY ("sicilNo");


--
-- Name: Ders Ders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ders"
    ADD CONSTRAINT "Ders_pkey" PRIMARY KEY ("dersKodu");


--
-- Name: Fakulte Fakulte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fakulte"
    ADD CONSTRAINT "Fakulte_pkey" PRIMARY KEY ("fakulteNo");


--
-- Name: Kampus Kampus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kampus"
    ADD CONSTRAINT "Kampus_pkey" PRIMARY KEY ("kampusNo");


--
-- Name: Kayit Kayit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "Kayit_pkey" PRIMARY KEY ("ogrenciNo", "dersKodu");


--
-- Name: Ogrenci Ogrenci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "Ogrenci_pkey" PRIMARY KEY ("ogrenciNo");


--
-- Name: Universite Universite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Universite"
    ADD CONSTRAINT "Universite_pkey" PRIMARY KEY ("UniversiteNo");


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY ("ilNo");


--
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY ("ilceNo");


--
-- Name: Dekan unique_Dekan_sicilNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dekan"
    ADD CONSTRAINT "unique_Dekan_sicilNo" UNIQUE ("sicilNo");


--
-- Name: Ogretim Uyesi unique_Ogretim Uyesi_sicilNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogretim Uyesi"
    ADD CONSTRAINT "unique_Ogretim Uyesi_sicilNo" PRIMARY KEY ("sicilNo");


--
-- Name: Rektör unique_Rektör_sicilNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rektör"
    ADD CONSTRAINT "unique_Rektör_sicilNo" PRIMARY KEY ("sicilNo");


--
-- Name: Bina BinaTemizle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "BinaTemizle" BEFORE INSERT ON public."Bina" FOR EACH ROW EXECUTE PROCEDURE public.temizle();


--
-- Name: Ogretim Uyesi soyadi_degisikligi; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER soyadi_degisikligi BEFORE UPDATE ON public."Ogretim Uyesi" FOR EACH ROW EXECUTE PROCEDURE public.log_ogretimuyesi_soyadi_degisikligi();


--
-- Name: il trg_il_buyut; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_il_buyut BEFORE INSERT ON public.il FOR EACH ROW EXECUTE PROCEDURE public.isim_buyut();


--
-- Name: Ogrenci trg_ogrenci_aktif; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_ogrenci_aktif BEFORE INSERT ON public."Ogrenci" FOR EACH ROW EXECUTE PROCEDURE public.ogrenci_aktif();


--
-- Name: Ders lnk_Bina_Ders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ders"
    ADD CONSTRAINT "lnk_Bina_Ders" FOREIGN KEY ("BinaNo") REFERENCES public."Bina"("binaNo") MATCH FULL;


--
-- Name: Ders lnk_Bolum_Ders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ders"
    ADD CONSTRAINT "lnk_Bolum_Ders" FOREIGN KEY ("BolumNo") REFERENCES public."Bolum"("BolumNo") MATCH FULL;


--
-- Name: Ogretim Uyesi lnk_Bolum_Ogretim Uyesi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogretim Uyesi"
    ADD CONSTRAINT "lnk_Bolum_Ogretim Uyesi" FOREIGN KEY ("bolumNo") REFERENCES public."Bolum"("BolumNo") MATCH FULL;


--
-- Name: Kayit lnk_Ders_Kayit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "lnk_Ders_Kayit" FOREIGN KEY ("dersKodu") REFERENCES public."Ders"("dersKodu") MATCH FULL;


--
-- Name: Bina lnk_Fakulte_Bina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina"
    ADD CONSTRAINT "lnk_Fakulte_Bina" FOREIGN KEY ("fakülteNo") REFERENCES public."Fakulte"("fakulteNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Bolum lnk_Fakulte_Bolum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bolum"
    ADD CONSTRAINT "lnk_Fakulte_Bolum" FOREIGN KEY ("FakulteNo") REFERENCES public."Fakulte"("fakulteNo") MATCH FULL;


--
-- Name: Dekan lnk_Fakulte_Dekan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dekan"
    ADD CONSTRAINT "lnk_Fakulte_Dekan" FOREIGN KEY ("FakulteNo") REFERENCES public."Fakulte"("fakulteNo") MATCH FULL;


--
-- Name: Bina lnk_Kampus_Bina; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina"
    ADD CONSTRAINT "lnk_Kampus_Bina" FOREIGN KEY ("kampüsNo") REFERENCES public."Kampus"("kampusNo") MATCH FULL;


--
-- Name: Kayit lnk_Ogrenci_Kayit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "lnk_Ogrenci_Kayit" FOREIGN KEY ("ogrenciNo") REFERENCES public."Ogrenci"("ogrenciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dekan lnk_Ogretim Uyesi_Dekan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dekan"
    ADD CONSTRAINT "lnk_Ogretim Uyesi_Dekan" FOREIGN KEY ("sicilNo") REFERENCES public."Ogretim Uyesi"("sicilNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Ders lnk_Ogretim Uyesi_Ders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ders"
    ADD CONSTRAINT "lnk_Ogretim Uyesi_Ders" FOREIGN KEY ("OgretmenSicilNo") REFERENCES public."Ogretim Uyesi"("sicilNo") MATCH FULL;


--
-- Name: Ogrenci lnk_Ogretim Uyesi_Ogrenci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "lnk_Ogretim Uyesi_Ogrenci" FOREIGN KEY ("Danışman") REFERENCES public."Ogretim Uyesi"("sicilNo") MATCH FULL;


--
-- Name: Rektör lnk_Ogretim Uyesi_Rektör; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rektör"
    ADD CONSTRAINT "lnk_Ogretim Uyesi_Rektör" FOREIGN KEY ("sicilNo") REFERENCES public."Ogretim Uyesi"("sicilNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Universite lnk_Rektör_Universite; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Universite"
    ADD CONSTRAINT "lnk_Rektör_Universite" FOREIGN KEY ("RektorSicilNo") REFERENCES public."Rektör"("sicilNo") MATCH FULL;


--
-- Name: Fakulte lnk_Universite_Fakulte; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fakulte"
    ADD CONSTRAINT "lnk_Universite_Fakulte" FOREIGN KEY ("universiteNo") REFERENCES public."Universite"("UniversiteNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kampus lnk_Universite_Kampus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kampus"
    ADD CONSTRAINT "lnk_Universite_Kampus" FOREIGN KEY ("universiteNo") REFERENCES public."Universite"("UniversiteNo") MATCH FULL;


--
-- Name: Ogrenci lnk_Universite_Ogrenci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "lnk_Universite_Ogrenci" FOREIGN KEY ("UniversiteNo") REFERENCES public."Universite"("UniversiteNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rektör lnk_Universite_Rektör; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rektör"
    ADD CONSTRAINT "lnk_Universite_Rektör" FOREIGN KEY ("universiteNo") REFERENCES public."Universite"("UniversiteNo") MATCH FULL;


--
-- Name: ilce lnk_il_ilce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT lnk_il_ilce FOREIGN KEY ("ilNo") REFERENCES public.il("ilNo") MATCH FULL;


--
-- Name: Kampus lnk_ilce_Kampus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kampus"
    ADD CONSTRAINT "lnk_ilce_Kampus" FOREIGN KEY ("ilceNo") REFERENCES public.ilce("ilceNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

