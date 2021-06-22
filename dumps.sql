--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11
-- Dumped by pg_dump version 11.11

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authentication_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_customer (
    id integer NOT NULL,
    created_on timestamp with time zone,
    modified_on timestamp with time zone,
    stripe_customer_id character varying(255),
    customer_id integer NOT NULL
);


ALTER TABLE public.authentication_customer OWNER TO postgres;

--
-- Name: authentication_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authentication_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authentication_customer_id_seq OWNER TO postgres;

--
-- Name: authentication_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authentication_customer_id_seq OWNED BY public.authentication_customer.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: payments_customerplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments_customerplan (
    id integer NOT NULL,
    created_on timestamp with time zone,
    modified_on timestamp with time zone,
    billing_type character varying(50),
    payment_type character varying(50),
    price numeric(10,2),
    valid_from date,
    valid_to date,
    is_active boolean NOT NULL,
    is_paid boolean NOT NULL,
    is_refund boolean NOT NULL,
    is_cancel boolean NOT NULL,
    charge_id character varying(255),
    refund_id character varying(255),
    customer_id integer,
    plans_id integer,
    amount numeric(10,2),
    paypal_id character varying(255)
);


ALTER TABLE public.payments_customerplan OWNER TO postgres;

--
-- Name: payments_customerplan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_customerplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_customerplan_id_seq OWNER TO postgres;

--
-- Name: payments_customerplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_customerplan_id_seq OWNED BY public.payments_customerplan.id;


--
-- Name: payments_subscriptionplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments_subscriptionplan (
    id integer NOT NULL,
    created_on timestamp with time zone,
    modified_on timestamp with time zone,
    plan_type character varying(50),
    price numeric(10,2)
);


ALTER TABLE public.payments_subscriptionplan OWNER TO postgres;

--
-- Name: payments_subscriptionplan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_subscriptionplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_subscriptionplan_id_seq OWNER TO postgres;

--
-- Name: payments_subscriptionplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_subscriptionplan_id_seq OWNED BY public.payments_subscriptionplan.id;


--
-- Name: paypal_ipn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paypal_ipn (
    id integer NOT NULL,
    business character varying(127) NOT NULL,
    charset character varying(255) NOT NULL,
    custom character varying(256) NOT NULL,
    notify_version numeric(64,2),
    parent_txn_id character varying(19) NOT NULL,
    receiver_email character varying(254) NOT NULL,
    receiver_id character varying(255) NOT NULL,
    residence_country character varying(2) NOT NULL,
    test_ipn boolean NOT NULL,
    txn_id character varying(255) NOT NULL,
    txn_type character varying(255) NOT NULL,
    verify_sign character varying(255) NOT NULL,
    address_country character varying(64) NOT NULL,
    address_city character varying(40) NOT NULL,
    address_country_code character varying(64) NOT NULL,
    address_name character varying(128) NOT NULL,
    address_state character varying(40) NOT NULL,
    address_status character varying(255) NOT NULL,
    address_street character varying(200) NOT NULL,
    address_zip character varying(20) NOT NULL,
    contact_phone character varying(20) NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    payer_business_name character varying(127) NOT NULL,
    payer_email character varying(127) NOT NULL,
    payer_id character varying(13) NOT NULL,
    auth_amount numeric(64,2),
    auth_exp character varying(28) NOT NULL,
    auth_id character varying(19) NOT NULL,
    auth_status character varying(255) NOT NULL,
    exchange_rate numeric(64,16),
    invoice character varying(127) NOT NULL,
    item_name character varying(127) NOT NULL,
    item_number character varying(127) NOT NULL,
    mc_currency character varying(32) NOT NULL,
    mc_fee numeric(64,2),
    mc_gross numeric(64,2),
    mc_handling numeric(64,2),
    mc_shipping numeric(64,2),
    memo character varying(255) NOT NULL,
    num_cart_items integer,
    option_name1 character varying(64) NOT NULL,
    option_name2 character varying(64) NOT NULL,
    payer_status character varying(255) NOT NULL,
    payment_date timestamp with time zone,
    payment_gross numeric(64,2),
    payment_status character varying(255) NOT NULL,
    payment_type character varying(255) NOT NULL,
    pending_reason character varying(255) NOT NULL,
    protection_eligibility character varying(255) NOT NULL,
    quantity integer,
    reason_code character varying(255) NOT NULL,
    remaining_settle numeric(64,2),
    settle_amount numeric(64,2),
    settle_currency character varying(32) NOT NULL,
    shipping numeric(64,2),
    shipping_method character varying(255) NOT NULL,
    tax numeric(64,2),
    transaction_entity character varying(255) NOT NULL,
    auction_buyer_id character varying(64) NOT NULL,
    auction_closing_date timestamp with time zone,
    auction_multi_item integer,
    for_auction numeric(64,2),
    amount numeric(64,2),
    amount_per_cycle numeric(64,2),
    initial_payment_amount numeric(64,2),
    next_payment_date timestamp with time zone,
    outstanding_balance numeric(64,2),
    payment_cycle character varying(255) NOT NULL,
    period_type character varying(255) NOT NULL,
    product_name character varying(255) NOT NULL,
    product_type character varying(255) NOT NULL,
    profile_status character varying(255) NOT NULL,
    recurring_payment_id character varying(255) NOT NULL,
    rp_invoice_id character varying(127) NOT NULL,
    time_created timestamp with time zone,
    amount1 numeric(64,2),
    amount2 numeric(64,2),
    amount3 numeric(64,2),
    mc_amount1 numeric(64,2),
    mc_amount2 numeric(64,2),
    mc_amount3 numeric(64,2),
    password character varying(24) NOT NULL,
    period1 character varying(255) NOT NULL,
    period2 character varying(255) NOT NULL,
    period3 character varying(255) NOT NULL,
    reattempt character varying(1) NOT NULL,
    recur_times integer,
    recurring character varying(1) NOT NULL,
    retry_at timestamp with time zone,
    subscr_date timestamp with time zone,
    subscr_effective timestamp with time zone,
    subscr_id character varying(19) NOT NULL,
    username character varying(64) NOT NULL,
    case_creation_date timestamp with time zone,
    case_id character varying(255) NOT NULL,
    case_type character varying(255) NOT NULL,
    receipt_id character varying(255) NOT NULL,
    currency_code character varying(32) NOT NULL,
    handling_amount numeric(64,2),
    transaction_subject character varying(256) NOT NULL,
    ipaddress inet,
    flag boolean NOT NULL,
    flag_code character varying(16) NOT NULL,
    flag_info text NOT NULL,
    query text NOT NULL,
    response text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    from_view character varying(6),
    mp_id character varying(128),
    option_selection1 character varying(200) NOT NULL,
    option_selection2 character varying(200) NOT NULL
);


ALTER TABLE public.paypal_ipn OWNER TO postgres;

--
-- Name: paypal_ipn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paypal_ipn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paypal_ipn_id_seq OWNER TO postgres;

--
-- Name: paypal_ipn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_ipn_id_seq OWNED BY public.paypal_ipn.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: authentication_customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_customer ALTER COLUMN id SET DEFAULT nextval('public.authentication_customer_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: payments_customerplan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_customerplan ALTER COLUMN id SET DEFAULT nextval('public.payments_customerplan_id_seq'::regclass);


--
-- Name: payments_subscriptionplan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_subscriptionplan ALTER COLUMN id SET DEFAULT nextval('public.payments_subscriptionplan_id_seq'::regclass);


--
-- Name: paypal_ipn id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal_ipn ALTER COLUMN id SET DEFAULT nextval('public.paypal_ipn_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add group	4	add_group
11	Can change group	4	change_group
12	Can delete group	4	delete_group
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add customer	7	add_customer
20	Can change customer	7	change_customer
21	Can delete customer	7	delete_customer
22	Can add customer plan	8	add_customerplan
23	Can change customer plan	8	change_customerplan
24	Can delete customer plan	8	delete_customerplan
25	Can add subscription plan	9	add_subscriptionplan
26	Can change subscription plan	9	change_subscriptionplan
27	Can delete subscription plan	9	delete_subscriptionplan
28	Can add PayPal IPN	10	add_paypalipn
29	Can change PayPal IPN	10	change_paypalipn
30	Can delete PayPal IPN	10	delete_paypalipn
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$HZvY2kXMD4lX$Ry/7aaOyWQF3d1xMMYxZdCXWNtTHEFLIq7Jq+FSICTo=	2021-06-21 16:03:17.525+05:30	t	admin			admin@admin.com	t	t	2021-06-10 20:41:47.881+05:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authentication_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_customer (id, created_on, modified_on, stripe_customer_id, customer_id) FROM stdin;
1	2021-06-10 21:02:16.578+05:30	2021-06-10 21:02:19.031+05:30	cus_Je87XE7aegd5wz	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-06-10 20:42:45.736+05:30	1	basic	1	[{"added": {}}]	9	1
2	2021-06-10 20:42:55.346+05:30	2	premium	1	[{"added": {}}]	9	1
3	2021-06-10 22:16:54.431+05:30	7	adminbasic	3		8	1
4	2021-06-10 22:16:54.439+05:30	6	adminpremium	3		8	1
5	2021-06-13 16:05:16.357+05:30	10	adminpremium	2	[{"changed": {"fields": ["plans", "price", "refund_id"]}}]	8	1
6	2021-06-13 16:08:44.028+05:30	10	adminbasic	2	[{"changed": {"fields": ["plans", "price"]}}]	8	1
7	2021-06-13 19:02:05.632+05:30	10	adminpremium	2	[{"changed": {"fields": ["is_active"]}}]	8	1
8	2021-06-13 22:29:03.949+05:30	11	adminbasic	3		8	1
9	2021-06-13 22:29:03.965+05:30	10	adminpremium	3		8	1
10	2021-06-13 22:29:03.965+05:30	9	adminbasic	3		8	1
11	2021-06-13 22:29:03.965+05:30	4	adminbasic	3		8	1
12	2021-06-15 22:36:34.105+05:30	12	adminbasic	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
13	2021-06-15 22:44:07.262+05:30	12	adminbasic	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
14	2021-06-18 19:33:34.289+05:30	13	adminpremium	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
15	2021-06-18 20:40:48.245+05:30	14	adminpremium	3		8	1
16	2021-06-19 11:00:55.903+05:30	13	adminpremium	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
17	2021-06-20 13:51:39.413+05:30	13	adminpremium	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
18	2021-06-20 20:14:56.815+05:30	15	adminpremium	3		8	1
19	2021-06-20 20:39:46.949+05:30	16	adminpremium	3		8	1
20	2021-06-20 20:49:38.934+05:30	17	adminpremium	3		8	1
21	2021-06-21 07:04:26.612+05:30	18	adminpremium	3		8	1
22	2021-06-21 09:24:30.61+05:30	19	adminpremium	2	[{"changed": {"fields": ["payment_type"]}}]	8	1
23	2021-06-21 09:43:38.751+05:30	19	adminpremium	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
24	2021-06-21 09:53:50.708+05:30	19	adminpremium	2	[{"changed": {"fields": ["is_active", "is_refund"]}}]	8	1
25	2021-06-21 14:38:22.733+05:30	19	adminpremium	3		8	1
26	2021-06-21 16:03:37.553+05:30	20	adminpremium	3		8	1
27	2021-06-21 16:39:06.321+05:30	21	adminpremium	3		8	1
28	2021-06-21 17:27:26.686+05:30	23	adminbasic	2	[{"changed": {"fields": ["is_active", "is_cancel"]}}]	8	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	user
4	auth	group
5	contenttypes	contenttype
6	sessions	session
7	authentication	customer
8	payments	customerplan
9	payments	subscriptionplan
10	ipn	paypalipn
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-06-10 20:41:03.483+05:30
2	auth	0001_initial	2021-06-10 20:41:03.646+05:30
3	admin	0001_initial	2021-06-10 20:41:03.715+05:30
4	admin	0002_logentry_remove_auto_add	2021-06-10 20:41:03.73+05:30
5	contenttypes	0002_remove_content_type_name	2021-06-10 20:41:03.799+05:30
6	auth	0002_alter_permission_name_max_length	2021-06-10 20:41:03.815+05:30
7	auth	0003_alter_user_email_max_length	2021-06-10 20:41:03.831+05:30
8	auth	0004_alter_user_username_opts	2021-06-10 20:41:03.862+05:30
9	auth	0005_alter_user_last_login_null	2021-06-10 20:41:03.884+05:30
10	auth	0006_require_contenttypes_0002	2021-06-10 20:41:03.884+05:30
11	auth	0007_alter_validators_add_error_messages	2021-06-10 20:41:03.9+05:30
12	auth	0008_alter_user_username_max_length	2021-06-10 20:41:03.931+05:30
13	authentication	0001_initial	2021-06-10 20:41:03.978+05:30
14	payments	0001_initial	2021-06-10 20:41:04.062+05:30
15	sessions	0001_initial	2021-06-10 20:41:04.085+05:30
16	payments	0002_customerplan_amount	2021-06-13 22:21:48.812+05:30
17	ipn	0001_initial	2021-06-18 11:46:35.287+05:30
18	ipn	0002_paypalipn_mp_id	2021-06-18 11:46:35.335+05:30
19	ipn	0003_auto_20141117_1647	2021-06-18 11:46:35.359+05:30
20	ipn	0004_auto_20150612_1826	2021-06-18 11:46:35.896+05:30
21	ipn	0005_auto_20151217_0948	2021-06-18 11:46:35.937+05:30
22	ipn	0006_auto_20160108_1112	2021-06-18 11:46:35.977+05:30
23	ipn	0007_auto_20160219_1135	2021-06-18 11:46:36.026+05:30
24	ipn	0008_auto_20181128_1032	2021-06-18 11:46:36.074+05:30
25	payments	0003_auto_20210620_2225	2021-06-20 22:26:06.313+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
zfbh5agl9fbwt0593h5wv45wae2tzhg2	ZmFkNGRiZDQ3MTg3ZDk4YTEwMmU0NTNiM2UwMzRmNzUwN2RkY2Q2Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjkzOGY2MDAwYjRjZmQxY2YwMGZmNzk3NDEwMjBkY2NjMWZkZDgxZGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2021-06-24 22:16:37.588+05:30
dbtup1tsoteauv9woujd78ww3sz8538e	ZmFkNGRiZDQ3MTg3ZDk4YTEwMmU0NTNiM2UwMzRmNzUwN2RkY2Q2Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjkzOGY2MDAwYjRjZmQxY2YwMGZmNzk3NDEwMjBkY2NjMWZkZDgxZGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2021-06-26 14:36:15.744+05:30
617nraq4ve08nqh0cl9yelqt181ulzkc	ZmFkNGRiZDQ3MTg3ZDk4YTEwMmU0NTNiM2UwMzRmNzUwN2RkY2Q2Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjkzOGY2MDAwYjRjZmQxY2YwMGZmNzk3NDEwMjBkY2NjMWZkZDgxZGYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2021-06-29 22:36:06.735+05:30
vlyizk65ol0ej5wlnounbrnpi7wuaiy4	MGRiMjMzMDMwNTFkY2NkOTk5Zjk0YmRhOTQ5NWNhNTg0ZWVhMGJiZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjViMTFmNjkzMGUxZjNhMDFmMTJkMjc5YmNmNTliZjZiZTZmMzUyZDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2021-07-02 12:23:44.973+05:30
w3qvri2ny190xiwflt1lkf43xhd1gw1k	MGRiMjMzMDMwNTFkY2NkOTk5Zjk0YmRhOTQ5NWNhNTg0ZWVhMGJiZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjViMTFmNjkzMGUxZjNhMDFmMTJkMjc5YmNmNTliZjZiZTZmMzUyZDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2021-07-05 16:03:17.565+05:30
\.


--
-- Data for Name: payments_customerplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments_customerplan (id, created_on, modified_on, billing_type, payment_type, price, valid_from, valid_to, is_active, is_paid, is_refund, is_cancel, charge_id, refund_id, customer_id, plans_id, amount, paypal_id) FROM stdin;
12	2021-06-13 22:33:23.925+05:30	2021-06-15 22:44:07.254+05:30	yearly	stripe	100.00	2021-06-13	2022-06-13	f	t	f	t	ch_1J2fRgSAchjH7T9UNJu8lumu	re_1J2fUeSAchjH7T9UyMGuLSbv	1	1	1200.00	\N
13	2021-06-15 22:44:36.386+05:30	2021-06-20 13:51:39.393+05:30	monthly	stripe	1000.00	2021-06-15	2021-07-15	f	t	f	t	ch_1J2fsaSAchjH7T9U2xzWzDQ1	re_1J2fsuSAchjH7T9UFzICUjAt	1	2	11013.70	\N
22	2021-06-21 16:41:02.179+05:30	2021-06-21 16:44:44.834+05:30	monthly	stripe	1000.00	2021-06-21	2021-07-21	f	t	f	t	ch_1J4l1uSAchjH7T9UBBDefUQs	re_1J4l5USAchjH7T9UH4PbRinL	1	2	1000.00	\N
23	2021-06-21 16:50:37.464+05:30	2021-06-21 17:27:26.683+05:30	monthly	stripe	100.00	2021-06-21	2021-07-21	f	t	f	t	ch_1J4lCxSAchjH7T9UOqybkrLs	re_1J4lJlSAchjH7T9Ulei8DQue	1	1	1101.37	\N
24	2021-06-21 17:29:08.882+05:30	2021-06-21 17:29:49.182+05:30	monthly	paypal	100.00	2021-06-21	2021-07-21	f	t	f	t	\N	\N	1	1	100.00	24463943B62346805
\.


--
-- Data for Name: payments_subscriptionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments_subscriptionplan (id, created_on, modified_on, plan_type, price) FROM stdin;
1	2021-06-10 20:42:45.729+05:30	2021-06-10 20:42:45.729+05:30	basic	100.00
2	2021-06-10 20:42:55.344+05:30	2021-06-10 20:42:55.344+05:30	premium	1000.00
\.


--
-- Data for Name: paypal_ipn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paypal_ipn (id, business, charset, custom, notify_version, parent_txn_id, receiver_email, receiver_id, residence_country, test_ipn, txn_id, txn_type, verify_sign, address_country, address_city, address_country_code, address_name, address_state, address_status, address_street, address_zip, contact_phone, first_name, last_name, payer_business_name, payer_email, payer_id, auth_amount, auth_exp, auth_id, auth_status, exchange_rate, invoice, item_name, item_number, mc_currency, mc_fee, mc_gross, mc_handling, mc_shipping, memo, num_cart_items, option_name1, option_name2, payer_status, payment_date, payment_gross, payment_status, payment_type, pending_reason, protection_eligibility, quantity, reason_code, remaining_settle, settle_amount, settle_currency, shipping, shipping_method, tax, transaction_entity, auction_buyer_id, auction_closing_date, auction_multi_item, for_auction, amount, amount_per_cycle, initial_payment_amount, next_payment_date, outstanding_balance, payment_cycle, period_type, product_name, product_type, profile_status, recurring_payment_id, rp_invoice_id, time_created, amount1, amount2, amount3, mc_amount1, mc_amount2, mc_amount3, password, period1, period2, period3, reattempt, recur_times, recurring, retry_at, subscr_date, subscr_effective, subscr_id, username, case_creation_date, case_id, case_type, receipt_id, currency_code, handling_amount, transaction_subject, ipaddress, flag, flag_code, flag_info, query, response, created_at, updated_at, from_view, mp_id, option_selection1, option_selection2) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 30, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: authentication_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authentication_customer_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 28, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: payments_customerplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_customerplan_id_seq', 24, true);


--
-- Name: payments_subscriptionplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_subscriptionplan_id_seq', 2, true);


--
-- Name: paypal_ipn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_ipn_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authentication_customer authentication_customer_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_customer
    ADD CONSTRAINT authentication_customer_customer_id_key UNIQUE (customer_id);


--
-- Name: authentication_customer authentication_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_customer
    ADD CONSTRAINT authentication_customer_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: payments_customerplan payments_customerplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_customerplan
    ADD CONSTRAINT payments_customerplan_pkey PRIMARY KEY (id);


--
-- Name: payments_subscriptionplan payments_subscriptionplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_subscriptionplan
    ADD CONSTRAINT payments_subscriptionplan_pkey PRIMARY KEY (id);


--
-- Name: paypal_ipn paypal_ipn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal_ipn
    ADD CONSTRAINT paypal_ipn_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_0e939a4f ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_8373b171 ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_417f1b1c ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_0e939a4f ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_e8701ad4 ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_8373b171 ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_417f1b1c ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_e8701ad4 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_de54fa62 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: payments_customerplan_82a0ba38; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payments_customerplan_82a0ba38 ON public.payments_customerplan USING btree (plans_id);


--
-- Name: payments_customerplan_cb24373b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payments_customerplan_cb24373b ON public.payments_customerplan USING btree (customer_id);


--
-- Name: paypal_ipn_txn_id_8fa22c44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX paypal_ipn_txn_id_8fa22c44 ON public.paypal_ipn USING btree (txn_id);


--
-- Name: paypal_ipn_txn_id_8fa22c44_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX paypal_ipn_txn_id_8fa22c44_like ON public.paypal_ipn USING btree (txn_id varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authentication_customer authentication_customer_customer_id_f631a324_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_customer
    ADD CONSTRAINT authentication_customer_customer_id_f631a324_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_customerplan payments_cust_plans_id_21ea67f4_fk_payments_subscriptionplan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_customerplan
    ADD CONSTRAINT payments_cust_plans_id_21ea67f4_fk_payments_subscriptionplan_id FOREIGN KEY (plans_id) REFERENCES public.payments_subscriptionplan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_customerplan payments_customerplan_customer_id_e3458abf_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments_customerplan
    ADD CONSTRAINT payments_customerplan_customer_id_e3458abf_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

