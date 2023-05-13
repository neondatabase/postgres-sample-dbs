--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2 (Ubuntu 15.2-1.pgdg22.04+1)

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

SET default_table_access_method = heap;

--
-- Name: 2019; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."2019" (
    overall_rank integer NOT NULL,
    country_or_region character varying(255) NOT NULL,
    score numeric(5,2) NOT NULL,
    gdp_per_capita numeric(10,2),
    social_support numeric(10,2),
    healthy_life_expectancy numeric(10,2),
    freedom_to_make_life_choices numeric(10,2),
    generosity numeric(10,2),
    perceptions_of_corruption numeric(10,2)
);


--
-- Name: 2019_overall_rank_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."2019_overall_rank_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: 2019_overall_rank_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."2019_overall_rank_seq" OWNED BY public."2019".overall_rank;


--
-- Name: 2019 overall_rank; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."2019" ALTER COLUMN overall_rank SET DEFAULT nextval('public."2019_overall_rank_seq"'::regclass);


--
-- Data for Name: 2019; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."2019" (overall_rank, country_or_region, score, gdp_per_capita, social_support, healthy_life_expectancy, freedom_to_make_life_choices, generosity, perceptions_of_corruption) FROM stdin;
1	Finland	7.77	1.34	1.59	0.99	0.60	0.15	0.39
2	Denmark	7.60	1.38	1.57	1.00	0.59	0.25	0.41
3	Norway	7.55	1.49	1.58	1.03	0.60	0.27	0.34
4	Iceland	7.49	1.38	1.62	1.03	0.59	0.35	0.12
5	Netherlands	7.49	1.40	1.52	1.00	0.56	0.32	0.30
6	Switzerland	7.48	1.45	1.53	1.05	0.57	0.26	0.34
7	Sweden	7.34	1.39	1.49	1.01	0.57	0.27	0.37
8	New Zealand	7.31	1.30	1.56	1.03	0.59	0.33	0.38
9	Canada	7.28	1.37	1.51	1.04	0.58	0.29	0.31
10	Austria	7.25	1.38	1.48	1.02	0.53	0.24	0.23
11	Australia	7.23	1.37	1.55	1.04	0.56	0.33	0.29
12	Costa Rica	7.17	1.03	1.44	0.96	0.56	0.14	0.09
13	Israel	7.14	1.28	1.46	1.03	0.37	0.26	0.08
14	Luxembourg	7.09	1.61	1.48	1.01	0.53	0.19	0.32
15	United Kingdom	7.05	1.33	1.54	1.00	0.45	0.35	0.28
16	Ireland	7.02	1.50	1.55	1.00	0.52	0.30	0.31
17	Germany	6.99	1.37	1.45	0.99	0.50	0.26	0.27
18	Belgium	6.92	1.36	1.50	0.99	0.47	0.16	0.21
19	United States	6.89	1.43	1.46	0.87	0.45	0.28	0.13
20	Czech Republic	6.85	1.27	1.49	0.92	0.46	0.05	0.04
21	United Arab Emirates	6.83	1.50	1.31	0.83	0.60	0.26	0.18
22	Malta	6.73	1.30	1.52	1.00	0.56	0.38	0.15
23	Mexico	6.60	1.07	1.32	0.86	0.43	0.07	0.07
24	France	6.59	1.32	1.47	1.05	0.44	0.11	0.18
25	Taiwan	6.45	1.37	1.43	0.91	0.35	0.24	0.10
26	Chile	6.44	1.16	1.37	0.92	0.36	0.19	0.06
27	Guatemala	6.44	0.80	1.27	0.75	0.54	0.18	0.08
28	Saudi Arabia	6.38	1.40	1.36	0.80	0.44	0.08	0.13
29	Qatar	6.37	1.68	1.31	0.87	0.56	0.22	0.17
30	Spain	6.35	1.29	1.48	1.06	0.36	0.15	0.08
31	Panama	6.32	1.15	1.44	0.91	0.52	0.11	0.05
32	Brazil	6.30	1.00	1.44	0.80	0.39	0.10	0.09
33	Uruguay	6.29	1.12	1.47	0.89	0.52	0.13	0.15
34	Singapore	6.26	1.57	1.46	1.14	0.56	0.27	0.45
35	El Salvador	6.25	0.79	1.24	0.79	0.43	0.09	0.07
36	Italy	6.22	1.29	1.49	1.04	0.23	0.16	0.03
37	Bahrain	6.20	1.36	1.37	0.87	0.54	0.26	0.11
38	Slovakia	6.20	1.25	1.50	0.88	0.33	0.12	0.01
39	Trinidad & Tobago	6.19	1.23	1.48	0.71	0.49	0.19	0.02
40	Poland	6.18	1.21	1.44	0.88	0.48	0.12	0.05
41	Uzbekistan	6.17	0.75	1.53	0.76	0.63	0.32	0.24
42	Lithuania	6.15	1.24	1.52	0.82	0.29	0.04	0.04
43	Colombia	6.13	0.99	1.41	0.84	0.47	0.10	0.03
44	Slovenia	6.12	1.26	1.52	0.95	0.56	0.14	0.06
45	Nicaragua	6.11	0.69	1.33	0.84	0.44	0.20	0.13
46	Kosovo	6.10	0.88	1.23	0.76	0.49	0.26	0.01
47	Argentina	6.09	1.09	1.43	0.88	0.47	0.07	0.05
48	Romania	6.07	1.16	1.23	0.83	0.46	0.08	0.01
49	Cyprus	6.05	1.26	1.22	1.04	0.41	0.19	0.04
50	Ecuador	6.03	0.91	1.31	0.87	0.50	0.13	0.09
51	Kuwait	6.02	1.50	1.32	0.81	0.49	0.14	0.10
52	Thailand	6.01	1.05	1.41	0.83	0.56	0.36	0.03
53	Latvia	5.94	1.19	1.47	0.81	0.26	0.08	0.06
54	South Korea	5.90	1.30	1.22	1.04	0.16	0.18	0.06
55	Estonia	5.89	1.24	1.53	0.87	0.50	0.10	0.16
56	Jamaica	5.89	0.83	1.48	0.83	0.49	0.11	0.03
57	Mauritius	5.89	1.12	1.40	0.80	0.50	0.22	0.06
58	Japan	5.89	1.33	1.42	1.09	0.45	0.07	0.14
59	Honduras	5.86	0.64	1.24	0.83	0.51	0.25	0.08
60	Kazakhstan	5.81	1.17	1.51	0.73	0.41	0.15	0.10
61	Bolivia	5.78	0.78	1.21	0.71	0.51	0.14	0.06
62	Hungary	5.76	1.20	1.41	0.83	0.20	0.08	0.02
63	Paraguay	5.74	0.86	1.48	0.78	0.51	0.18	0.08
64	Northern Cyprus	5.72	1.26	1.25	1.04	0.42	0.19	0.16
65	Peru	5.70	0.96	1.27	0.85	0.46	0.08	0.03
66	Portugal	5.69	1.22	1.43	1.00	0.51	0.05	0.03
67	Pakistan	5.65	0.68	0.89	0.54	0.31	0.22	0.10
68	Russia	5.65	1.18	1.45	0.73	0.33	0.08	0.03
69	Philippines	5.63	0.81	1.29	0.66	0.56	0.12	0.11
70	Serbia	5.60	1.00	1.38	0.85	0.28	0.14	0.04
71	Moldova	5.53	0.69	1.33	0.74	0.25	0.18	0.00
72	Libya	5.53	1.04	1.30	0.67	0.42	0.13	0.15
73	Montenegro	5.52	1.05	1.36	0.87	0.20	0.14	0.08
74	Tajikistan	5.47	0.49	1.10	0.72	0.39	0.23	0.14
75	Croatia	5.43	1.16	1.27	0.91	0.30	0.12	0.02
76	Hong Kong	5.43	1.44	1.28	1.12	0.44	0.26	0.29
77	Dominican Republic	5.43	1.02	1.40	0.78	0.50	0.11	0.10
78	Bosnia and Herzegovina	5.39	0.95	1.21	0.85	0.21	0.26	0.01
79	Turkey	5.37	1.18	1.36	0.81	0.20	0.08	0.11
80	Malaysia	5.34	1.22	1.17	0.83	0.51	0.26	0.02
81	Belarus	5.32	1.07	1.47	0.79	0.24	0.09	0.14
82	Greece	5.29	1.18	1.16	1.00	0.07	0.00	0.03
83	Mongolia	5.29	0.95	1.53	0.67	0.32	0.24	0.04
84	North Macedonia	5.27	0.98	1.29	0.84	0.35	0.19	0.03
85	Nigeria	5.27	0.70	1.11	0.25	0.43	0.22	0.04
86	Kyrgyzstan	5.26	0.55	1.44	0.72	0.51	0.30	0.02
87	Turkmenistan	5.25	1.05	1.54	0.66	0.39	0.24	0.03
88	Algeria	5.21	1.00	1.16	0.79	0.09	0.07	0.11
89	Morocco	5.21	0.80	0.78	0.78	0.42	0.04	0.08
90	Azerbaijan	5.21	1.04	1.15	0.77	0.35	0.04	0.18
91	Lebanon	5.20	0.99	1.22	0.82	0.22	0.17	0.03
92	Indonesia	5.19	0.93	1.20	0.66	0.49	0.50	0.03
93	China	5.19	1.03	1.13	0.89	0.52	0.06	0.10
94	Vietnam	5.18	0.74	1.35	0.85	0.54	0.15	0.07
95	Bhutan	5.08	0.81	1.32	0.60	0.46	0.37	0.17
96	Cameroon	5.04	0.55	0.91	0.33	0.38	0.19	0.04
97	Bulgaria	5.01	1.09	1.51	0.82	0.31	0.08	0.00
98	Ghana	5.00	0.61	0.87	0.49	0.38	0.25	0.04
99	Ivory Coast	4.94	0.57	0.81	0.23	0.35	0.15	0.09
100	Nepal	4.91	0.45	1.23	0.68	0.44	0.29	0.09
101	Jordan	4.91	0.84	1.23	0.82	0.38	0.11	0.13
102	Benin	4.88	0.39	0.44	0.40	0.35	0.18	0.08
103	Congo (Brazzaville)	4.81	0.67	0.80	0.51	0.37	0.11	0.09
104	Gabon	4.80	1.06	1.18	0.57	0.30	0.04	0.06
105	Laos	4.80	0.76	1.03	0.55	0.55	0.27	0.16
106	South Africa	4.72	0.96	1.35	0.47	0.39	0.13	0.06
107	Albania	4.72	0.95	0.85	0.87	0.38	0.18	0.03
108	Venezuela	4.71	0.96	1.43	0.81	0.15	0.06	0.05
109	Cambodia	4.70	0.57	1.12	0.64	0.61	0.23	0.06
110	Palestinian Territories	4.70	0.66	1.25	0.67	0.23	0.10	0.07
111	Senegal	4.68	0.45	1.13	0.57	0.29	0.15	0.07
112	Somalia	4.67	0.00	0.70	0.27	0.56	0.24	0.27
113	Namibia	4.64	0.88	1.31	0.48	0.40	0.07	0.06
114	Niger	4.63	0.14	0.77	0.37	0.32	0.19	0.10
115	Burkina Faso	4.59	0.33	1.06	0.38	0.26	0.18	0.11
116	Armenia	4.56	0.85	1.06	0.82	0.28	0.10	0.06
117	Iran	4.55	1.10	0.84	0.79	0.31	0.27	0.13
118	Guinea	4.53	0.38	0.83	0.38	0.33	0.21	0.09
119	Georgia	4.52	0.89	0.67	0.75	0.35	0.04	0.16
120	Gambia	4.52	0.31	0.94	0.43	0.38	0.27	0.17
121	Kenya	4.51	0.51	0.98	0.58	0.43	0.37	0.05
122	Mauritania	4.49	0.57	1.17	0.49	0.07	0.11	0.09
123	Mozambique	4.47	0.20	0.99	0.39	0.49	0.20	0.14
124	Tunisia	4.46	0.92	1.00	0.82	0.17	0.06	0.06
125	Bangladesh	4.46	0.56	0.93	0.72	0.53	0.17	0.14
126	Iraq	4.44	1.04	0.98	0.57	0.24	0.15	0.09
127	Congo (Kinshasa)	4.42	0.09	1.13	0.36	0.27	0.21	0.05
128	Mali	4.39	0.39	1.11	0.31	0.33	0.15	0.05
129	Sierra Leone	4.37	0.27	0.84	0.24	0.31	0.25	0.05
130	Sri Lanka	4.37	0.95	1.27	0.83	0.47	0.24	0.05
131	Myanmar	4.36	0.71	1.18	0.56	0.53	0.57	0.17
132	Chad	4.35	0.35	0.77	0.19	0.17	0.20	0.08
133	Ukraine	4.33	0.82	1.39	0.74	0.18	0.19	0.01
134	Ethiopia	4.29	0.34	1.03	0.53	0.34	0.21	0.10
135	Swaziland	4.21	0.81	1.15	0.00	0.31	0.07	0.14
136	Uganda	4.19	0.33	1.07	0.44	0.36	0.25	0.06
137	Egypt	4.17	0.91	1.04	0.64	0.24	0.08	0.07
138	Zambia	4.11	0.58	1.06	0.43	0.43	0.25	0.09
139	Togo	4.09	0.28	0.57	0.41	0.29	0.18	0.09
140	India	4.02	0.76	0.77	0.59	0.50	0.20	0.09
141	Liberia	3.98	0.07	0.92	0.44	0.37	0.23	0.03
142	Comoros	3.97	0.27	0.76	0.51	0.14	0.28	0.08
143	Madagascar	3.93	0.27	0.92	0.56	0.15	0.17	0.04
144	Lesotho	3.80	0.49	1.17	0.17	0.36	0.11	0.09
145	Burundi	3.78	0.05	0.45	0.38	0.22	0.18	0.18
146	Zimbabwe	3.66	0.37	1.11	0.43	0.36	0.15	0.09
147	Haiti	3.60	0.32	0.69	0.45	0.03	0.42	0.11
148	Botswana	3.49	1.04	1.15	0.54	0.46	0.03	0.10
149	Syria	3.46	0.62	0.38	0.44	0.01	0.33	0.14
150	Malawi	3.41	0.19	0.56	0.50	0.44	0.22	0.09
151	Yemen	3.38	0.29	1.16	0.46	0.14	0.11	0.08
152	Rwanda	3.33	0.36	0.71	0.61	0.56	0.22	0.41
153	Tanzania	3.23	0.48	0.89	0.50	0.42	0.28	0.15
154	Afghanistan	3.20	0.35	0.52	0.36	0.00	0.16	0.03
155	Central African Republic	3.08	0.03	0.00	0.11	0.23	0.24	0.04
156	South Sudan	2.85	0.31	0.58	0.30	0.01	0.20	0.09
\.


--
-- Name: 2019_overall_rank_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."2019_overall_rank_seq"', 1, false);


--
-- Name: 2019 2019_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."2019"
    ADD CONSTRAINT "2019_pkey" PRIMARY KEY (overall_rank);


--
-- PostgreSQL database dump complete
--

