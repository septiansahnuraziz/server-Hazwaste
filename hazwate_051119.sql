--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: histori_perjalanan_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE histori_perjalanan_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE histori_perjalanan_sequence OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: histori_perjalanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE histori_perjalanan (
    id integer DEFAULT nextval('histori_perjalanan_sequence'::regclass) NOT NULL,
    id_perjalanan integer,
    waktu timestamp without time zone,
    posisi_lintang real,
    posisi_bujur real
);


ALTER TABLE histori_perjalanan OWNER TO postgres;

--
-- Name: ijin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ijin (
    no_ijin character varying NOT NULL,
    berlaku_mulai date,
    berlaku_sampai date
);


ALTER TABLE ijin OWNER TO postgres;

--
-- Name: ijin_angkut; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ijin_angkut (
    no_ijin character varying NOT NULL,
    plat character varying NOT NULL,
    status boolean
);


ALTER TABLE ijin_angkut OWNER TO postgres;

--
-- Name: jenis_limbah; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE jenis_limbah (
    kode_limbah character varying NOT NULL,
    jenis character varying,
    id_karakteristik integer,
    kode_un_na character varying
);


ALTER TABLE jenis_limbah OWNER TO postgres;

--
-- Name: karakteristik_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE karakteristik_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE karakteristik_sequence OWNER TO postgres;

--
-- Name: karakteristik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE karakteristik (
    id integer DEFAULT nextval('karakteristik_sequence'::regclass) NOT NULL,
    karakteristik character varying
);


ALTER TABLE karakteristik OWNER TO postgres;

--
-- Name: COLUMN karakteristik.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN karakteristik.id IS '
';


--
-- Name: kemasan_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE kemasan_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kemasan_sequence OWNER TO postgres;

--
-- Name: kemasan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE kemasan (
    id integer DEFAULT nextval('kemasan_sequence'::regclass) NOT NULL,
    kemasan character varying
);


ALTER TABLE kemasan OWNER TO postgres;

--
-- Name: kendaraan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE kendaraan (
    plat character varying NOT NULL,
    jenis character varying,
    no_klh character varying
);


ALTER TABLE kendaraan OWNER TO postgres;

--
-- Name: manifest_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE manifest_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manifest_sequence OWNER TO postgres;

--
-- Name: limbah; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE limbah (
    manifest_no character varying DEFAULT to_char(nextval('manifest_sequence'::regclass), '"BAL"fm0000000'::text) NOT NULL,
    id_perjalanan integer,
    id_penghasil integer,
    jumlah integer,
    bobot real,
    tanggal date,
    id_unit integer,
    id_kemasan integer,
    id_limbah character varying,
    id_tujuan integer
);


ALTER TABLE limbah OWNER TO postgres;

--
-- Name: COLUMN limbah.tanggal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN limbah.tanggal IS '
';


--
-- Name: COLUMN limbah.id_unit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN limbah.id_unit IS '
';


--
-- Name: pengelola_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pengelola_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengelola_sequence OWNER TO postgres;

--
-- Name: pengelola; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pengelola (
    id integer DEFAULT nextval('pengelola_sequence'::regclass) NOT NULL,
    nama character varying,
    alamat character varying
);


ALTER TABLE pengelola OWNER TO postgres;

--
-- Name: pengemudi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pengemudi (
    sim character varying NOT NULL,
    nama character varying,
    telepon character varying
);


ALTER TABLE pengemudi OWNER TO postgres;

--
-- Name: penghasil_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE penghasil_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE penghasil_sequence OWNER TO postgres;

--
-- Name: penghasil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE penghasil (
    id integer DEFAULT nextval('penghasil_sequence'::regclass) NOT NULL,
    nama character varying NOT NULL,
    alamat character varying
);


ALTER TABLE penghasil OWNER TO postgres;

--
-- Name: perjalanan_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE perjalanan_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE perjalanan_sequence OWNER TO postgres;

--
-- Name: perjalanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE perjalanan (
    id integer DEFAULT nextval('perjalanan_sequence'::regclass) NOT NULL,
    plat character varying,
    sim character varying,
    status integer,
    tanggal date
);


ALTER TABLE perjalanan OWNER TO postgres;

--
-- Name: COLUMN perjalanan.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN perjalanan.id IS '
';


--
-- Name: unit_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE unit_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unit_sequence OWNER TO postgres;

--
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE unit (
    id integer DEFAULT nextval('unit_sequence'::regclass) NOT NULL,
    unit character varying
);


ALTER TABLE unit OWNER TO postgres;

--
-- Data for Name: histori_perjalanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY histori_perjalanan (id, id_perjalanan, waktu, posisi_lintang, posisi_bujur) FROM stdin;
1	1	2019-11-05 00:00:01	-6.22858906	106.788467
2	1	2019-11-05 00:01:01	-6.22935915	106.789146
\.


--
-- Name: histori_perjalanan_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('histori_perjalanan_sequence', 2, true);


--
-- Data for Name: ijin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ijin (no_ijin, berlaku_mulai, berlaku_sampai) FROM stdin;
R201710260010	2018-03-02	2022-03-02
\.


--
-- Data for Name: ijin_angkut; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ijin_angkut (no_ijin, plat, status) FROM stdin;
R201710260010	BA 8119 KU	t
R201710260010	BA8219KM	t
\.


--
-- Data for Name: jenis_limbah; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jenis_limbah (kode_limbah, jenis, id_karakteristik, kode_un_na) FROM stdin;
A102d	AKI/BATERAI BEKAS	1	\N
A107d	PELARUT BEKAS LAINNYA YANG BELUM DIKODIFIKASI	3	\N
A305-1	MONOMER ATAU OLIGOMER YANG TIDAK BEREAKSI [POLIMER KEGIATAN PRODUKSI, BAIK KHUSUS ATAU INTEGRASI DALAM MANUFAKTUR PRODUK PLASTIK, KARET ATAU SERAT SINTETIS DENGAN CARA POLIMERISASI]	2	\N
A305-2	RESIDU PRODUKSI ATAU REAKSI PEMURNIAN, POLIMER ABSORBEN, FRAKSINASI	2	\N
A305-3	RESIDU DARI PROSES DESTILASI	2	\N
A305-4	ORGALITE DARI FURNACE PROSES PRODUKSI CS2	2	\N
A305-5	ALKALI SELULOSA	2	\N
A307-1	SLUDGE DARI PROSES PRODUKSI DAN FASILITAS PENYIMPANAN MINYAK BUMI ATAU GAS ALAM [KILANG MINYAK DAN GAS BUMI]	2	\N
A307-2	RESIDU DASAR TANKI	2	\N
A307-3	SLOP PADATAN EMULSI MINYAK DARI INDUSTRI PENYULINGAN MINYAK BUMI	3	\N
A337-1	LIMBAH KLINIS MEMILIKI KARAKTERISTIK INFEKSIUS [RUMAH SAKIT DAN FASILITAS PELAYANAN KESEHATAN]	4	\N
A337-2	PRODUK FARMASI KEDALUWARSA	2	\N
A337-3	BAHAN KIMIA KEDALUWARSA	2	\N
A337-4	PERALATAN LABORATORIUM TERKONTAMINASI B3	2	\N
A337-5	PERALATAN MEDIS MENGANDUNG LOGAM BERAT, TERMASUK MERKURI (Hg), KADMIUM (Cd), DAN SEJENISNYA	2	\N
A342-1	RESIDU FILTRASI (PENGOLAHAN MINYAK HEWANI ATAU NABATI)	2	\N
A342-2	RESIDU PROSES DESTILASI	2	\N
A343-1	GLYCERINE PITCH [PENGOLAHAN OLEOKIMIA DASAR ANTARA LAIN BERUPA PENGOLAHAN DERIVAT MINYAK NABATI ATAU HEWANI]	2	\N
A343-2	RESIDU FILTRASI	2	\N
A351-1	ADESIF ATAU PEREKAT SISA DAN KEDALUWARSA [PULP DAN KERTAS]	2	\N
A351-2	RESIDU PENCETAKAN (TINTA/PEWARNA)	2	\N
A351-3	SLUDGE BRINE	2	\N
A355-1	PELARUT (CLEANING, DEGREASING) [BENGKEL PEMELIHARAAN KENDARAAN]	2	\N
B104d	KEMASAN BEKAS B3	2	\N
B105d	MINYAK PELUMAS BEKAS ANTARA LAIN MINYAK PELUMAS BEKAS HIDROLIK, MESIN, GEAR, LUBRIKASI, INSULASI, HEAT TRANSMISSION, GRIT CHAMBERS, SEPARATORS DAN/ATAU CAMPURANNYA	3	\N
B106d	LIMBAH RESIN ATAU PENUKAR ION	2	\N
B107d	LIMBAH ELEKTRONIK TERMASUK CATHODE RAY TUBE (CRT), LAMPU TL, PRINTED CIRCUIT BOARD (PCB), KARET KAWAT (WIRE RUBBER)	2	\N
B109d	FILTER BEKAS DARI FASILITAS PENGENDALIAN PENCEMARAN UDARA	2	\N
B110d	KAIN MAJUN BEKAS (USED RAGS) DAN YANG SEJENIS	5	\N
B305-1	KATALIS BEKAS	2	\N
B305-2	SISA DAN BEKAS STABILIZER	2	\N
B305-3	FIRE RETARDANT MISALNYA Sb DAN SENYAWA BROMINE ORGANIC	2	\N
B305-4	SENYAWA Sn ORGANIS UNTUK THERMAL STABILIZER 	2	\N
B305-5	SLUDGE IPAL	2	\N
B307-1	KATALIS BEKAS	2	\N
B307-2	KARBON AKTIF BEKAS SELAIN LIMBAH KARBON AKTIF DENGAN KODE LIMBAH A110D	5	\N
B307-3	FILTER BEKAS TERMASUK LEMPUNG (CLAYS) SPENT FILTER	2	\N
B307-4	DEBU DARI FASILITAS PENGENDALIAN PENCEMARAN UDARA	2	\N
B333-1	DEBU DARI FASILITAS PENGENDALIAN PENCEMARAN UDARA SELAIN LIMBAH DENGAN KODE B409 ATAU B410 [PEMBANGKIT LISTRIK TENAGA UAP (PLTU), BOILER DAN/ATAU TUNGKU INDUSTRI YANG MENGGUNAKAN BAHAN BAKAR BATUBARA]	2	\N
B333-2	PASIR DARI FLUIDIZED BED	2	\r
B337-1	KEMASAN PRODUK FARMASI	2	\N
B337-2	SLUDGE IPAL	2	\N
B343-1	KATALIS BEKAS [PENGOLAJAN OLEOKIMIA DASAR]	2	\N
B343-2	SLUDGE IPAL	2	\N
B351-1	LIME MUD [PULP DAN KERTAS]	1	\N
B351-2	DEBU DARI FASILITAS PENGENDALIAN PENCEMARAN UDARA	2	\N
B351-3	SLUDGE OIL TREATMENT DAN/ATAU PENYIMPANAN	3	\N
B351-4	SLUDGE IPAL PEMBUATAN PRODUK KERTAS DEINKING	2	\N
B353-1	TONER BEKAS [FOTOKOPI]	2	\N
B355-1	LIMBAH CAT [BENGKEL PEMELIHARAAN KENDARAAN]	2	\N
B402	STEEL SLAG [PROSES PELEBURAN BIJIH DAN/ATAU LOGAM BESI DAN BAJA]	2	\N
B409	FLY ASH	2	\N
B410	BOTTOM ASH	2	\N
B411	SLUDGE IPAL [PROSES PENGOLAHAN AIR LIMBAH DAN INDUSTRI PULP]	2	\N
B413	SPENT BLEACHING EARTH	2	\N
B414	GIPSUM [PLTU, PUPUS FOSFAT, INDSTRI MONOSODIUM GLUTAMATE(MSG)]	2	\N
B415	KAPUR (CaCO3) [PROSES PEMBUATAN PUPUK AMMONIUM]	2	\N
\.


--
-- Data for Name: karakteristik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY karakteristik (id, karakteristik) FROM stdin;
1	KOROSIF
2	BERACUN
3	CAIRAN MUDAH MENYALA
4	INFEKSIUS
5	PADATAN MUDAH MENYALA
\.


--
-- Name: karakteristik_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('karakteristik_sequence', 5, true);


--
-- Data for Name: kemasan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kemasan (id, kemasan) FROM stdin;
3	JUMBO BAG
1	DRUM PLASTIK
2	DRUM BESI
4	KANTONG KUNING
\.


--
-- Name: kemasan_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('kemasan_sequence', 4, true);


--
-- Data for Name: kendaraan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY kendaraan (plat, jenis, no_klh) FROM stdin;
BA 8119 KU	TRUCK	1
BA 8219 KM	BESTEL WAGON/DV	12
BA8219KM	BESTEL WAGON/DV	12
BA 8219 XU	TRUK	2
\.


--
-- Data for Name: limbah; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY limbah (manifest_no, id_perjalanan, id_penghasil, jumlah, bobot, tanggal, id_unit, id_kemasan, id_limbah, id_tujuan) FROM stdin;
BAL0000001	1	2	1	195	\N	1	4	A337-1	1
BAL0000002	2	2	1	200	\N	1	4	A337-1	1
BAL0000003	7	2	1	100	\N	1	4	A337-1	1
\.


--
-- Name: manifest_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('manifest_sequence', 3, true);


--
-- Data for Name: pengelola; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pengelola (id, nama, alamat) FROM stdin;
1	KLH	Jakarta
2	WHO	Jakarta
\.


--
-- Name: pengelola_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pengelola_sequence', 2, true);


--
-- Data for Name: pengemudi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pengemudi (sim, nama, telepon) FROM stdin;
1	fandi	\N
2	zulkarnain	\N
3	anto	\N
4	roni susandi	\N
10111213	ujang	0811456789
\.


--
-- Data for Name: penghasil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY penghasil (id, nama, alamat) FROM stdin;
1	RSIA CICIK	\N
2	RS ISLAM SITI RAHMAH	\N
3	RSKM REGINA EYE CENTER	\N
4	RS AWAL BROS UJUNG BATU	\N
5	RS HERMINA PADANG	\N
6	RSUD AROSUKA	\N
7	RS NAILI DBS	\N
8	RS AZZAHRA UJUNG BATU	\N
9	RS DOA IBUNDA	\N
10	RSPI	pondok indah
\.


--
-- Name: penghasil_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('penghasil_sequence', 10, true);


--
-- Data for Name: perjalanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY perjalanan (id, plat, sim, status, tanggal) FROM stdin;
5	BA 8219 KM	1	2	2019-11-05
7	BA 8119 KU	2	1	2019-11-05
2	BA 8219 XU	1	1	2019-11-05
1	BA 8219 KM	1	2	\N
6	BA 8119 KU	2	2	\N
11	BA 8219 XU	3	1	2019-11-05
\.


--
-- Name: perjalanan_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perjalanan_sequence', 11, true);


--
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY unit (id, unit) FROM stdin;
1	kg
\.


--
-- Name: unit_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('unit_sequence', 1, true);


--
-- Name: histori_perjalanan histori_perjalanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY histori_perjalanan
    ADD CONSTRAINT histori_perjalanan_pkey PRIMARY KEY (id);


--
-- Name: ijin_angkut ijin_angkut_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ijin_angkut
    ADD CONSTRAINT ijin_angkut_pkey PRIMARY KEY (no_ijin, plat);


--
-- Name: ijin ijin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ijin
    ADD CONSTRAINT ijin_pkey PRIMARY KEY (no_ijin);


--
-- Name: jenis_limbah jenis_limbah_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jenis_limbah
    ADD CONSTRAINT jenis_limbah_pkey PRIMARY KEY (kode_limbah);


--
-- Name: karakteristik karakteristik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY karakteristik
    ADD CONSTRAINT karakteristik_pkey PRIMARY KEY (id);


--
-- Name: kemasan kemasan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kemasan
    ADD CONSTRAINT kemasan_pkey PRIMARY KEY (id);


--
-- Name: kendaraan kendaraan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY kendaraan
    ADD CONSTRAINT kendaraan_pkey PRIMARY KEY (plat);


--
-- Name: limbah limbah_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_pkey PRIMARY KEY (manifest_no);


--
-- Name: pengelola pengelola_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pengelola
    ADD CONSTRAINT pengelola_pkey PRIMARY KEY (id);


--
-- Name: pengemudi pengemudi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pengemudi
    ADD CONSTRAINT pengemudi_pkey PRIMARY KEY (sim);


--
-- Name: penghasil penghasil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY penghasil
    ADD CONSTRAINT penghasil_pkey PRIMARY KEY (id);


--
-- Name: perjalanan perjalanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perjalanan
    ADD CONSTRAINT perjalanan_pkey PRIMARY KEY (id);


--
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (id);


--
-- Name: histori_perjalanan histori_perjalanan_id_perjalanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY histori_perjalanan
    ADD CONSTRAINT histori_perjalanan_id_perjalanan_fkey FOREIGN KEY (id_perjalanan) REFERENCES perjalanan(id);


--
-- Name: ijin_angkut ijin_angkut_no_ijin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ijin_angkut
    ADD CONSTRAINT ijin_angkut_no_ijin_fkey FOREIGN KEY (no_ijin) REFERENCES ijin(no_ijin);


--
-- Name: ijin_angkut ijin_angkut_plat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ijin_angkut
    ADD CONSTRAINT ijin_angkut_plat_fkey FOREIGN KEY (plat) REFERENCES kendaraan(plat);


--
-- Name: jenis_limbah jenis_limbah_id_karakteristik_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY jenis_limbah
    ADD CONSTRAINT jenis_limbah_id_karakteristik_fkey FOREIGN KEY (id_karakteristik) REFERENCES karakteristik(id);


--
-- Name: limbah limbah_id_kemasan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_id_kemasan_fkey FOREIGN KEY (id_kemasan) REFERENCES kemasan(id);


--
-- Name: limbah limbah_id_limbah_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_id_limbah_fkey FOREIGN KEY (id_limbah) REFERENCES jenis_limbah(kode_limbah);


--
-- Name: limbah limbah_id_penghasil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_id_penghasil_fkey FOREIGN KEY (id_penghasil) REFERENCES penghasil(id);


--
-- Name: limbah limbah_id_perjalanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_id_perjalanan_fkey FOREIGN KEY (id_perjalanan) REFERENCES perjalanan(id);


--
-- Name: limbah limbah_id_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY limbah
    ADD CONSTRAINT limbah_id_unit_fkey FOREIGN KEY (id_unit) REFERENCES unit(id);


--
-- Name: perjalanan perjalanan_plat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perjalanan
    ADD CONSTRAINT perjalanan_plat_fkey FOREIGN KEY (plat) REFERENCES kendaraan(plat);


--
-- Name: perjalanan perjalanan_sim_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perjalanan
    ADD CONSTRAINT perjalanan_sim_fkey FOREIGN KEY (sim) REFERENCES pengemudi(sim);


--
-- PostgreSQL database dump complete
--

