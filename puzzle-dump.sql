--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: cn
--

CREATE TABLE customers (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE customers OWNER TO cn;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: cn
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers_id_seq OWNER TO cn;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cn
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cn
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying,
    customer_id bigint
);


ALTER TABLE users OWNER TO cn;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cn
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO cn;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cn
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cn
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cn
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: cn
--

COPY customers (id, name) FROM stdin;
1	Woo Inc.
2	Notsobad Privacy
3	OneMoreTime Ltd.
4	BestCompanyEver
5	MAGA Ind.
6	Never Boring Entertaiment
7	Splitbus
8	Pariwise
9	NeverAgain
10	What Where When
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cn
--

SELECT pg_catalog.setval('customers_id_seq', 10, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cn
--

COPY users (id, name, customer_id) FROM stdin;
1	1510a347-2fd9-4c32-b98f-29ad3c02900c	1
2	68bbdd3a-925b-44e9-827a-42e4057611c1	1
3	a0eaa041-9299-4921-b490-2ebbf69b7e80	2
4	20f258be-5d1b-4639-a99f-df4e7972d64b	2
5	1ebb238e-cafe-4d48-b145-2c582bacd0a2	3
6	efc6e05e-498d-4cf4-a42f-a4085cc369b3	3
7	7c5873b7-25ee-4a78-b538-defdbc45bf30	4
8	982fe57d-5f18-41c9-9f08-1bbfe60ed821	4
9	0b2b7541-5239-4a98-91a8-3082107b77dd	5
10	3fa9ee54-dbdc-4b5f-914e-cb92fccec6fe	5
11	9a626c6f-4952-4f58-b411-ce7a5d682aae	6
12	9e39248f-de28-4f25-a930-df06c21d9066	6
13	4ab00d77-b960-473e-ae22-7c3b503d525e	7
14	b35e269c-c52d-469f-b234-d627a69a4fc2	7
15	076ee4b2-d387-4704-84a8-39d7c1acbd4e	8
16	5914cf02-5659-4925-bdb7-2fbe34df6ab7	8
17	e8edb09b-b5c9-4650-a047-6a11b0f58bf2	9
18	530fec01-40a5-41ec-bab0-d12b39dd371d	9
19	f7f4bf6f-7b98-4656-9dea-ff6b7fa1600d	10
20	d4a4afc5-876c-456c-bd7c-f354b81f386f	10
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cn
--

SELECT pg_catalog.setval('users_id_seq', 20, true);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: cn
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: cn
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cn
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customers(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: cn
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM cn;
GRANT ALL ON SCHEMA public TO cn;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

