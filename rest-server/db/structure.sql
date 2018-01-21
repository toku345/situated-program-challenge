SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: venue_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE venue_type AS ENUM (
    'physical',
    'online'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: groups_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups_members (
    group_id integer NOT NULL,
    member_id integer NOT NULL,
    admin boolean DEFAULT false
);


--
-- Name: meetups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE meetups (
    id integer NOT NULL,
    title text NOT NULL,
    start_at timestamp without time zone,
    end_at timestamp without time zone,
    venue_id integer,
    group_id integer
);


--
-- Name: meetups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meetups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meetups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meetups_id_seq OWNED BY meetups.id;


--
-- Name: meetups_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE meetups_members (
    meetup_id integer NOT NULL,
    member_id integer NOT NULL
);


--
-- Name: members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE members (
    id integer NOT NULL,
    first_name text,
    last_name text,
    email text
);


--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE members_id_seq OWNED BY members.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    id bigint NOT NULL,
    applied timestamp without time zone,
    description character varying(1024)
);


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE venues (
    id integer NOT NULL,
    name text,
    postal_code text,
    prefecture text,
    city text,
    street1 text,
    street2 text,
    group_id integer,
    url text,
    venue_type venue_type DEFAULT 'physical'::venue_type
);


--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: meetups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meetups ALTER COLUMN id SET DEFAULT nextval('meetups_id_seq'::regclass);


--
-- Name: members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY members ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


--
-- Name: groups_members groups_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups_members
    ADD CONSTRAINT groups_members_pkey PRIMARY KEY (group_id, member_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: meetups_members meetups_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meetups_members
    ADD CONSTRAINT meetups_members_pkey PRIMARY KEY (meetup_id, member_id);


--
-- Name: meetups meetups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meetups
    ADD CONSTRAINT meetups_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_id_key UNIQUE (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: groups_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_name ON groups USING btree (name);


--
-- Name: meetups_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meetups_title ON meetups USING btree (title);


--
-- Name: members_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX members_email ON members USING btree (email);


--
-- Name: venues_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX venues_name ON venues USING btree (name);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

