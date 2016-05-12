--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: getnextid(character varying); Type: FUNCTION; Schema: public; Owner: dspace
--

CREATE FUNCTION getnextid(character varying) RETURNS integer
    LANGUAGE sql
    AS $_$SELECT CAST (nextval($1 || '_seq') AS INTEGER) AS RESULT;$_$;


ALTER FUNCTION public.getnextid(character varying) OWNER TO dspace;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bitstream; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bitstream (
    bitstream_id integer NOT NULL,
    bitstream_format_id integer,
    checksum character varying(64),
    checksum_algorithm character varying(32),
    internal_id character varying(256),
    deleted boolean,
    store_number integer,
    sequence_id integer,
    size_bytes bigint
);


ALTER TABLE public.bitstream OWNER TO dspace;

--
-- Name: bitstream_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bitstream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitstream_seq OWNER TO dspace;

--
-- Name: bitstreamformatregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bitstreamformatregistry (
    bitstream_format_id integer NOT NULL,
    mimetype character varying(256),
    short_description character varying(128),
    description text,
    support_level integer,
    internal boolean
);


ALTER TABLE public.bitstreamformatregistry OWNER TO dspace;

--
-- Name: bitstreamformatregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bitstreamformatregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitstreamformatregistry_seq OWNER TO dspace;

--
-- Name: bundle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bundle (
    bundle_id integer NOT NULL,
    primary_bitstream_id integer
);


ALTER TABLE public.bundle OWNER TO dspace;

--
-- Name: bundle2bitstream; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE bundle2bitstream (
    id integer NOT NULL,
    bundle_id integer,
    bitstream_id integer,
    bitstream_order integer
);


ALTER TABLE public.bundle2bitstream OWNER TO dspace;

--
-- Name: bundle2bitstream_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bundle2bitstream_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bundle2bitstream_seq OWNER TO dspace;

--
-- Name: bundle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE bundle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bundle_seq OWNER TO dspace;

--
-- Name: checksum_history; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE checksum_history (
    check_id bigint NOT NULL,
    bitstream_id integer,
    process_start_date timestamp without time zone,
    process_end_date timestamp without time zone,
    checksum_expected character varying,
    checksum_calculated character varying,
    result character varying
);


ALTER TABLE public.checksum_history OWNER TO dspace;

--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE checksum_history_check_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checksum_history_check_id_seq OWNER TO dspace;

--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dspace
--

ALTER SEQUENCE checksum_history_check_id_seq OWNED BY checksum_history.check_id;


--
-- Name: checksum_results; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE checksum_results (
    result_code character varying NOT NULL,
    result_description character varying
);


ALTER TABLE public.checksum_results OWNER TO dspace;

--
-- Name: collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection (
    collection_id integer NOT NULL,
    logo_bitstream_id integer,
    template_item_id integer,
    workflow_step_1 integer,
    workflow_step_2 integer,
    workflow_step_3 integer,
    submitter integer,
    admin integer
);


ALTER TABLE public.collection OWNER TO dspace;

--
-- Name: collection2item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection2item (
    id integer NOT NULL,
    collection_id integer,
    item_id integer
);


ALTER TABLE public.collection2item OWNER TO dspace;

--
-- Name: collection2item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE collection2item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection2item_seq OWNER TO dspace;

--
-- Name: collection_item_count; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE collection_item_count (
    collection_id integer NOT NULL,
    count integer
);


ALTER TABLE public.collection_item_count OWNER TO dspace;

--
-- Name: collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_seq OWNER TO dspace;

--
-- Name: communities2item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE communities2item (
    id integer NOT NULL,
    community_id integer,
    item_id integer
);


ALTER TABLE public.communities2item OWNER TO dspace;

--
-- Name: communities2item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE communities2item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities2item_seq OWNER TO dspace;

--
-- Name: community; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community (
    community_id integer NOT NULL,
    logo_bitstream_id integer,
    admin integer
);


ALTER TABLE public.community OWNER TO dspace;

--
-- Name: community2collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community2collection (
    id integer NOT NULL,
    community_id integer,
    collection_id integer
);


ALTER TABLE public.community2collection OWNER TO dspace;

--
-- Name: community2collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community2collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community2collection_seq OWNER TO dspace;

--
-- Name: community2community; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community2community (
    id integer NOT NULL,
    parent_comm_id integer,
    child_comm_id integer
);


ALTER TABLE public.community2community OWNER TO dspace;

--
-- Name: community2community_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community2community_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community2community_seq OWNER TO dspace;

--
-- Name: community2item; Type: VIEW; Schema: public; Owner: dspace
--

CREATE VIEW community2item AS
 SELECT community2collection.community_id,
    collection2item.item_id
   FROM community2collection,
    collection2item
  WHERE (collection2item.collection_id = community2collection.collection_id);


ALTER TABLE public.community2item OWNER TO dspace;

--
-- Name: community_item_count; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE community_item_count (
    community_id integer NOT NULL,
    count integer
);


ALTER TABLE public.community_item_count OWNER TO dspace;

--
-- Name: community_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE community_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community_seq OWNER TO dspace;

--
-- Name: metadatafieldregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadatafieldregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadatafieldregistry_seq OWNER TO dspace;

--
-- Name: metadatafieldregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadatafieldregistry (
    metadata_field_id integer DEFAULT nextval('metadatafieldregistry_seq'::regclass) NOT NULL,
    metadata_schema_id integer NOT NULL,
    element character varying(64),
    qualifier character varying(64),
    scope_note text
);


ALTER TABLE public.metadatafieldregistry OWNER TO dspace;

--
-- Name: metadatavalue_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadatavalue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadatavalue_seq OWNER TO dspace;

--
-- Name: metadatavalue; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadatavalue (
    metadata_value_id integer DEFAULT nextval('metadatavalue_seq'::regclass) NOT NULL,
    resource_id integer NOT NULL,
    metadata_field_id integer,
    text_value text,
    text_lang character varying(24),
    place integer,
    authority character varying(100),
    confidence integer DEFAULT (-1),
    resource_type_id integer NOT NULL
);


ALTER TABLE public.metadatavalue OWNER TO dspace;

--
-- Name: dcvalue; Type: VIEW; Schema: public; Owner: dspace
--

CREATE VIEW dcvalue AS
 SELECT metadatavalue.metadata_value_id AS dc_value_id,
    metadatavalue.resource_id,
    metadatavalue.metadata_field_id AS dc_type_id,
    metadatavalue.text_value,
    metadatavalue.text_lang,
    metadatavalue.place
   FROM metadatavalue,
    metadatafieldregistry
  WHERE (((metadatavalue.metadata_field_id = metadatafieldregistry.metadata_field_id) AND (metadatafieldregistry.metadata_schema_id = 1)) AND (metadatavalue.resource_type_id = 2));


ALTER TABLE public.dcvalue OWNER TO dspace;

--
-- Name: dcvalue_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE dcvalue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcvalue_seq OWNER TO dspace;

--
-- Name: doi; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE doi (
    doi_id integer NOT NULL,
    doi character varying(256),
    resource_type_id integer,
    resource_id integer,
    status integer
);


ALTER TABLE public.doi OWNER TO dspace;

--
-- Name: doi_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE doi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doi_seq OWNER TO dspace;

--
-- Name: eperson; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE eperson (
    eperson_id integer NOT NULL,
    email character varying(64),
    password character varying(128),
    can_log_in boolean,
    require_certificate boolean,
    self_registered boolean,
    last_active timestamp without time zone,
    sub_frequency integer,
    netid character varying(64),
    salt character varying(32),
    digest_algorithm character varying(16)
);


ALTER TABLE public.eperson OWNER TO dspace;

--
-- Name: eperson_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE eperson_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eperson_seq OWNER TO dspace;

--
-- Name: epersongroup; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup (
    eperson_group_id integer NOT NULL
);


ALTER TABLE public.epersongroup OWNER TO dspace;

--
-- Name: epersongroup2eperson; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup2eperson (
    id integer NOT NULL,
    eperson_group_id integer,
    eperson_id integer
);


ALTER TABLE public.epersongroup2eperson OWNER TO dspace;

--
-- Name: epersongroup2eperson_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup2eperson_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup2eperson_seq OWNER TO dspace;

--
-- Name: epersongroup2workspaceitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup2workspaceitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup2workspaceitem_seq OWNER TO dspace;

--
-- Name: epersongroup2workspaceitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE epersongroup2workspaceitem (
    id integer DEFAULT nextval('epersongroup2workspaceitem_seq'::regclass) NOT NULL,
    eperson_group_id integer,
    workspace_item_id integer
);


ALTER TABLE public.epersongroup2workspaceitem OWNER TO dspace;

--
-- Name: epersongroup_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE epersongroup_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.epersongroup_seq OWNER TO dspace;

--
-- Name: fileextension; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE fileextension (
    file_extension_id integer NOT NULL,
    bitstream_format_id integer,
    extension character varying(16)
);


ALTER TABLE public.fileextension OWNER TO dspace;

--
-- Name: fileextension_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE fileextension_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fileextension_seq OWNER TO dspace;

--
-- Name: group2group; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE group2group (
    id integer NOT NULL,
    parent_id integer,
    child_id integer
);


ALTER TABLE public.group2group OWNER TO dspace;

--
-- Name: group2group_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE group2group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group2group_seq OWNER TO dspace;

--
-- Name: group2groupcache; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE group2groupcache (
    id integer NOT NULL,
    parent_id integer,
    child_id integer
);


ALTER TABLE public.group2groupcache OWNER TO dspace;

--
-- Name: group2groupcache_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE group2groupcache_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group2groupcache_seq OWNER TO dspace;

--
-- Name: handle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE handle (
    handle_id integer NOT NULL,
    handle character varying(256),
    resource_type_id integer,
    resource_id integer
);


ALTER TABLE public.handle OWNER TO dspace;

--
-- Name: handle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE handle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.handle_seq OWNER TO dspace;

--
-- Name: harvested_collection; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE harvested_collection (
    collection_id integer,
    harvest_type integer,
    oai_source character varying,
    oai_set_id character varying,
    harvest_message character varying,
    metadata_config_id character varying,
    harvest_status integer,
    harvest_start_time timestamp with time zone,
    last_harvested timestamp with time zone,
    id integer NOT NULL
);


ALTER TABLE public.harvested_collection OWNER TO dspace;

--
-- Name: harvested_collection_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE harvested_collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.harvested_collection_seq OWNER TO dspace;

--
-- Name: harvested_item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE harvested_item (
    item_id integer,
    last_harvested timestamp with time zone,
    oai_id character varying,
    id integer NOT NULL
);


ALTER TABLE public.harvested_item OWNER TO dspace;

--
-- Name: harvested_item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE harvested_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.harvested_item_seq OWNER TO dspace;

--
-- Name: history_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE history_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_seq OWNER TO dspace;

--
-- Name: historystate_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE historystate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historystate_seq OWNER TO dspace;

--
-- Name: item; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE item (
    item_id integer NOT NULL,
    submitter_id integer,
    in_archive boolean,
    withdrawn boolean,
    owning_collection integer,
    last_modified timestamp with time zone,
    discoverable boolean
);


ALTER TABLE public.item OWNER TO dspace;

--
-- Name: item2bundle; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE item2bundle (
    id integer NOT NULL,
    item_id integer,
    bundle_id integer
);


ALTER TABLE public.item2bundle OWNER TO dspace;

--
-- Name: item2bundle_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE item2bundle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item2bundle_seq OWNER TO dspace;

--
-- Name: item_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_seq OWNER TO dspace;

--
-- Name: metadataschemaregistry_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE metadataschemaregistry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadataschemaregistry_seq OWNER TO dspace;

--
-- Name: metadataschemaregistry; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE metadataschemaregistry (
    metadata_schema_id integer DEFAULT nextval('metadataschemaregistry_seq'::regclass) NOT NULL,
    namespace character varying(256),
    short_id character varying(32)
);


ALTER TABLE public.metadataschemaregistry OWNER TO dspace;

--
-- Name: most_recent_checksum; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE most_recent_checksum (
    bitstream_id integer NOT NULL,
    to_be_processed boolean NOT NULL,
    expected_checksum character varying NOT NULL,
    current_checksum character varying NOT NULL,
    last_process_start_date timestamp without time zone NOT NULL,
    last_process_end_date timestamp without time zone NOT NULL,
    checksum_algorithm character varying NOT NULL,
    matched_prev_checksum boolean NOT NULL,
    result character varying
);


ALTER TABLE public.most_recent_checksum OWNER TO dspace;

--
-- Name: registrationdata; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE registrationdata (
    registrationdata_id integer NOT NULL,
    email character varying(64),
    token character varying(48),
    expires timestamp without time zone
);


ALTER TABLE public.registrationdata OWNER TO dspace;

--
-- Name: registrationdata_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE registrationdata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registrationdata_seq OWNER TO dspace;

--
-- Name: requestitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE requestitem (
    requestitem_id integer NOT NULL,
    token character varying(48),
    item_id integer,
    bitstream_id integer,
    allfiles boolean,
    request_email character varying(64),
    request_name character varying(64),
    request_date timestamp without time zone,
    accept_request boolean,
    decision_date timestamp without time zone,
    expires timestamp without time zone,
    request_message text
);


ALTER TABLE public.requestitem OWNER TO dspace;

--
-- Name: requestitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE requestitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requestitem_seq OWNER TO dspace;

--
-- Name: resourcepolicy; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE resourcepolicy (
    policy_id integer NOT NULL,
    resource_type_id integer,
    resource_id integer,
    action_id integer,
    eperson_id integer,
    epersongroup_id integer,
    start_date date,
    end_date date,
    rpname character varying(30),
    rptype character varying(30),
    rpdescription character varying(100)
);


ALTER TABLE public.resourcepolicy OWNER TO dspace;

--
-- Name: resourcepolicy_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE resourcepolicy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resourcepolicy_seq OWNER TO dspace;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE schema_version (
    version_rank integer NOT NULL,
    installed_rank integer NOT NULL,
    version character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.schema_version OWNER TO dspace;

--
-- Name: subscription; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE subscription (
    subscription_id integer NOT NULL,
    eperson_id integer,
    collection_id integer
);


ALTER TABLE public.subscription OWNER TO dspace;

--
-- Name: subscription_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE subscription_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_seq OWNER TO dspace;

--
-- Name: tasklistitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE tasklistitem (
    tasklist_id integer NOT NULL,
    eperson_id integer,
    workflow_id integer
);


ALTER TABLE public.tasklistitem OWNER TO dspace;

--
-- Name: tasklistitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE tasklistitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasklistitem_seq OWNER TO dspace;

--
-- Name: versionhistory; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE versionhistory (
    versionhistory_id integer NOT NULL
);


ALTER TABLE public.versionhistory OWNER TO dspace;

--
-- Name: versionhistory_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE versionhistory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versionhistory_seq OWNER TO dspace;

--
-- Name: versionitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE versionitem (
    versionitem_id integer NOT NULL,
    item_id integer,
    version_number integer,
    eperson_id integer,
    version_date timestamp without time zone,
    version_summary character varying(255),
    versionhistory_id integer
);


ALTER TABLE public.versionitem OWNER TO dspace;

--
-- Name: versionitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE versionitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versionitem_seq OWNER TO dspace;

--
-- Name: webapp; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE webapp (
    webapp_id integer NOT NULL,
    appname character varying(32),
    url character varying,
    started timestamp without time zone,
    isui integer
);


ALTER TABLE public.webapp OWNER TO dspace;

--
-- Name: webapp_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE webapp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webapp_seq OWNER TO dspace;

--
-- Name: workflowitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE workflowitem (
    workflow_id integer NOT NULL,
    item_id integer,
    collection_id integer,
    state integer,
    owner integer,
    multiple_titles boolean,
    published_before boolean,
    multiple_files boolean
);


ALTER TABLE public.workflowitem OWNER TO dspace;

--
-- Name: workflowitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE workflowitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflowitem_seq OWNER TO dspace;

--
-- Name: workspaceitem; Type: TABLE; Schema: public; Owner: dspace; Tablespace: 
--

CREATE TABLE workspaceitem (
    workspace_item_id integer NOT NULL,
    item_id integer,
    collection_id integer,
    multiple_titles boolean,
    published_before boolean,
    multiple_files boolean,
    stage_reached integer,
    page_reached integer
);


ALTER TABLE public.workspaceitem OWNER TO dspace;

--
-- Name: workspaceitem_seq; Type: SEQUENCE; Schema: public; Owner: dspace
--

CREATE SEQUENCE workspaceitem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workspaceitem_seq OWNER TO dspace;

--
-- Name: check_id; Type: DEFAULT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY checksum_history ALTER COLUMN check_id SET DEFAULT nextval('checksum_history_check_id_seq'::regclass);


--
-- Data for Name: bitstream; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bitstream (bitstream_id, bitstream_format_id, checksum, checksum_algorithm, internal_id, deleted, store_number, sequence_id, size_bytes) FROM stdin;
\.


--
-- Name: bitstream_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bitstream_seq', 1, false);


--
-- Data for Name: bitstreamformatregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bitstreamformatregistry (bitstream_format_id, mimetype, short_description, description, support_level, internal) FROM stdin;
1	application/octet-stream	Unknown	Unknown data format	0	f
2	text/plain; charset=utf-8	License	Item-specific license agreed upon to submission	1	t
3	text/html; charset=utf-8	CC License	Item-specific Creative Commons license agreed upon to submission	1	t
4	application/pdf	Adobe PDF	Adobe Portable Document Format	1	f
5	text/xml	XML	Extensible Markup Language	1	f
6	text/plain	Text	Plain Text	1	f
7	text/html	HTML	Hypertext Markup Language	1	f
8	text/css	CSS	Cascading Style Sheets	1	f
9	application/msword	Microsoft Word	Microsoft Word	1	f
10	application/vnd.openxmlformats-officedocument.wordprocessingml.document	Microsoft Word XML	Microsoft Word XML	1	f
11	application/vnd.ms-powerpoint	Microsoft Powerpoint	Microsoft Powerpoint	1	f
12	application/vnd.openxmlformats-officedocument.presentationml.presentation	Microsoft Powerpoint XML	Microsoft Powerpoint XML	1	f
13	application/vnd.ms-excel	Microsoft Excel	Microsoft Excel	1	f
14	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	Microsoft Excel XML	Microsoft Excel XML	1	f
15	application/marc	MARC	Machine-Readable Cataloging records	1	f
16	image/jpeg	JPEG	Joint Photographic Experts Group/JPEG File Interchange Format (JFIF)	1	f
17	image/gif	GIF	Graphics Interchange Format	1	f
18	image/png	image/png	Portable Network Graphics	1	f
19	image/tiff	TIFF	Tag Image File Format	1	f
20	audio/x-aiff	AIFF	Audio Interchange File Format	1	f
21	audio/basic	audio/basic	Basic Audio	1	f
22	audio/x-wav	WAV	Broadcase Wave Format	1	f
23	video/mpeg	MPEG	Moving Picture Experts Group	1	f
24	text/richtext	RTF	Rich Text Format	1	f
25	application/vnd.visio	Microsoft Visio	Microsoft Visio	1	f
26	application/x-filemaker	FMP3	Filemaker Pro	1	f
27	image/x-ms-bmp	BMP	Microsoft Windows bitmap	1	f
28	application/x-photoshop	Photoshop	Photoshop	1	f
29	application/postscript	Postscript	Postscript Files	1	f
30	video/quicktime	Video Quicktime	Video Quicktime	1	f
31	audio/x-mpeg	MPEG Audio	MPEG Audio	1	f
32	application/vnd.ms-project	Microsoft Project	Microsoft Project	1	f
33	application/mathematica	Mathematica	Mathematica Notebook	1	f
34	application/x-latex	LateX	LaTeX document	1	f
35	application/x-tex	TeX	Tex/LateX document	1	f
36	application/x-dvi	TeX dvi	TeX dvi format	1	f
37	application/sgml	SGML	SGML application (RFC 1874)	1	f
38	application/wordperfect5.1	WordPerfect	WordPerfect 5.1 document	1	f
39	audio/x-pn-realaudio	RealAudio	RealAudio file	1	f
40	image/x-photo-cd	Photo CD	Kodak Photo CD image	1	f
41	application/vnd.oasis.opendocument.text	OpenDocument Text	OpenDocument Text	1	f
42	application/vnd.oasis.opendocument.text-template	OpenDocument Text Template	OpenDocument Text Template	1	f
43	application/vnd.oasis.opendocument.text-web	OpenDocument HTML Template	OpenDocument HTML Template	1	f
44	application/vnd.oasis.opendocument.text-master	OpenDocument Master Document	OpenDocument Master Document	1	f
45	application/vnd.oasis.opendocument.graphics	OpenDocument Drawing	OpenDocument Drawing	1	f
46	application/vnd.oasis.opendocument.graphics-template	OpenDocument Drawing Template	OpenDocument Drawing Template	1	f
47	application/vnd.oasis.opendocument.presentation	OpenDocument Presentation	OpenDocument Presentation	1	f
48	application/vnd.oasis.opendocument.presentation-template	OpenDocument Presentation Template	OpenDocument Presentation Template	1	f
49	application/vnd.oasis.opendocument.spreadsheet	OpenDocument Spreadsheet	OpenDocument Spreadsheet	1	f
50	application/vnd.oasis.opendocument.spreadsheet-template	OpenDocument Spreadsheet Template	OpenDocument Spreadsheet Template	1	f
51	application/vnd.oasis.opendocument.chart	OpenDocument Chart	OpenDocument Chart	1	f
52	application/vnd.oasis.opendocument.formula	OpenDocument Formula	OpenDocument Formula	1	f
53	application/vnd.oasis.opendocument.database	OpenDocument Database	OpenDocument Database	1	f
54	application/vnd.oasis.opendocument.image	OpenDocument Image	OpenDocument Image	1	f
55	application/vnd.openofficeorg.extension	OpenOffice.org extension	OpenOffice.org extension (since OOo 2.1)	1	f
56	application/vnd.sun.xml.writer	Writer 6.0 documents	Writer 6.0 documents	1	f
57	application/vnd.sun.xml.writer.template	Writer 6.0 templates	Writer 6.0 templates	1	f
58	application/vnd.sun.xml.calc	Calc 6.0 spreadsheets	Calc 6.0 spreadsheets	1	f
59	application/vnd.sun.xml.calc.template	Calc 6.0 templates	Calc 6.0 templates	1	f
60	application/vnd.sun.xml.draw	Draw 6.0 documents	Draw 6.0 documents	1	f
61	application/vnd.sun.xml.draw.template	Draw 6.0 templates	Draw 6.0 templates	1	f
62	application/vnd.sun.xml.impress	Impress 6.0 presentations	Impress 6.0 presentations	1	f
63	application/vnd.sun.xml.impress.template	Impress 6.0 templates	Impress 6.0 templates	1	f
64	application/vnd.sun.xml.writer.global	Writer 6.0 global documents	Writer 6.0 global documents	1	f
65	application/vnd.sun.xml.math	Math 6.0 documents	Math 6.0 documents	1	f
66	application/vnd.stardivision.writer	StarWriter 5.x documents	StarWriter 5.x documents	1	f
67	application/vnd.stardivision.writer-global	StarWriter 5.x global documents	StarWriter 5.x global documents	1	f
68	application/vnd.stardivision.calc	StarCalc 5.x spreadsheets	StarCalc 5.x spreadsheets	1	f
69	application/vnd.stardivision.draw	StarDraw 5.x documents	StarDraw 5.x documents	1	f
70	application/vnd.stardivision.impress	StarImpress 5.x presentations	StarImpress 5.x presentations	1	f
71	application/vnd.stardivision.impress-packed	StarImpress Packed 5.x files	StarImpress Packed 5.x files	1	f
72	application/vnd.stardivision.math	StarMath 5.x documents	StarMath 5.x documents	1	f
73	application/vnd.stardivision.chart	StarChart 5.x documents	StarChart 5.x documents	1	f
74	application/vnd.stardivision.mail	StarMail 5.x mail files	StarMail 5.x mail files	1	f
75	application/rdf+xml; charset=utf-8	RDF XML	RDF serialized in XML	1	f
\.


--
-- Name: bitstreamformatregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bitstreamformatregistry_seq', 75, true);


--
-- Data for Name: bundle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bundle (bundle_id, primary_bitstream_id) FROM stdin;
\.


--
-- Data for Name: bundle2bitstream; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY bundle2bitstream (id, bundle_id, bitstream_id, bitstream_order) FROM stdin;
\.


--
-- Name: bundle2bitstream_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bundle2bitstream_seq', 1, false);


--
-- Name: bundle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('bundle_seq', 1, false);


--
-- Data for Name: checksum_history; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY checksum_history (check_id, bitstream_id, process_start_date, process_end_date, checksum_expected, checksum_calculated, result) FROM stdin;
\.


--
-- Name: checksum_history_check_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('checksum_history_check_id_seq', 1, false);


--
-- Data for Name: checksum_results; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY checksum_results (result_code, result_description) FROM stdin;
INVALID_HISTORY	Install of the cheksum checking code do not consider this history as valid
BITSTREAM_NOT_FOUND	The bitstream could not be found
CHECKSUM_MATCH	Current checksum matched previous checksum
CHECKSUM_NO_MATCH	Current checksum does not match previous checksum
CHECKSUM_PREV_NOT_FOUND	Previous checksum was not found: no comparison possible
BITSTREAM_INFO_NOT_FOUND	Bitstream info not found
CHECKSUM_ALGORITHM_INVALID	Invalid checksum algorithm
BITSTREAM_NOT_PROCESSED	Bitstream marked to_be_processed=false
BITSTREAM_MARKED_DELETED	Bitstream marked deleted in bitstream table
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection (collection_id, logo_bitstream_id, template_item_id, workflow_step_1, workflow_step_2, workflow_step_3, submitter, admin) FROM stdin;
\.


--
-- Data for Name: collection2item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection2item (id, collection_id, item_id) FROM stdin;
\.


--
-- Name: collection2item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('collection2item_seq', 1, false);


--
-- Data for Name: collection_item_count; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY collection_item_count (collection_id, count) FROM stdin;
\.


--
-- Name: collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('collection_seq', 1, false);


--
-- Data for Name: communities2item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY communities2item (id, community_id, item_id) FROM stdin;
\.


--
-- Name: communities2item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('communities2item_seq', 1, false);


--
-- Data for Name: community; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community (community_id, logo_bitstream_id, admin) FROM stdin;
\.


--
-- Data for Name: community2collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community2collection (id, community_id, collection_id) FROM stdin;
\.


--
-- Name: community2collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community2collection_seq', 1, false);


--
-- Data for Name: community2community; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community2community (id, parent_comm_id, child_comm_id) FROM stdin;
\.


--
-- Name: community2community_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community2community_seq', 1, false);


--
-- Data for Name: community_item_count; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY community_item_count (community_id, count) FROM stdin;
\.


--
-- Name: community_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('community_seq', 1, false);


--
-- Name: dcvalue_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('dcvalue_seq', 1, false);


--
-- Data for Name: doi; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY doi (doi_id, doi, resource_type_id, resource_id, status) FROM stdin;
\.


--
-- Name: doi_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('doi_seq', 1, false);


--
-- Data for Name: eperson; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY eperson (eperson_id, email, password, can_log_in, require_certificate, self_registered, last_active, sub_frequency, netid, salt, digest_algorithm) FROM stdin;
1	statbib@gmail.com	68b375714da1e11dff646135b27a54949da580ec35d4450c13ff87de0d9b66bf16d2cfd1242d36df60bc772ec7ff1182cf18870023e4b9e5e4f2ae716c513b6d	t	f	f	\N	\N	\N	ab6e8f1f1e2b0a71b251c8bff96ac32a	SHA-512
\.


--
-- Name: eperson_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('eperson_seq', 1, true);


--
-- Data for Name: epersongroup; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup (eperson_group_id) FROM stdin;
0
1
\.


--
-- Data for Name: epersongroup2eperson; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup2eperson (id, eperson_group_id, eperson_id) FROM stdin;
1	1	1
\.


--
-- Name: epersongroup2eperson_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup2eperson_seq', 1, true);


--
-- Data for Name: epersongroup2workspaceitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY epersongroup2workspaceitem (id, eperson_group_id, workspace_item_id) FROM stdin;
\.


--
-- Name: epersongroup2workspaceitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup2workspaceitem_seq', 1, false);


--
-- Name: epersongroup_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('epersongroup_seq', 1, true);


--
-- Data for Name: fileextension; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY fileextension (file_extension_id, bitstream_format_id, extension) FROM stdin;
1	4	pdf
2	5	xml
3	6	txt
4	6	asc
5	7	htm
6	7	html
7	8	css
8	9	doc
9	10	docx
10	11	ppt
11	12	pptx
12	13	xls
13	14	xlsx
14	16	jpeg
15	16	jpg
16	17	gif
17	18	png
18	19	tiff
19	19	tif
20	20	aiff
21	20	aif
22	20	aifc
23	21	au
24	21	snd
25	22	wav
26	23	mpeg
27	23	mpg
28	23	mpe
29	24	rtf
30	25	vsd
31	26	fm
32	27	bmp
33	28	psd
34	28	pdd
35	29	ps
36	29	eps
37	29	ai
38	30	mov
39	30	qt
40	31	mpa
41	31	abs
42	31	mpega
43	32	mpp
44	32	mpx
45	32	mpd
46	33	ma
47	34	latex
48	35	tex
49	36	dvi
50	37	sgm
51	37	sgml
52	38	wpd
53	39	ra
54	39	ram
55	40	pcd
56	41	odt
57	42	ott
58	43	oth
59	44	odm
60	45	odg
61	46	otg
62	47	odp
63	48	otp
64	49	ods
65	50	ots
66	51	odc
67	52	odf
68	53	odb
69	54	odi
70	55	oxt
71	56	sxw
72	57	stw
73	58	sxc
74	59	stc
75	60	sxd
76	61	std
77	62	sxi
78	63	sti
79	64	sxg
80	65	sxm
81	66	sdw
82	67	sgl
83	68	sdc
84	69	sda
85	70	sdd
86	71	sdp
87	72	smf
88	73	sds
89	74	sdm
90	75	rdf
\.


--
-- Name: fileextension_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('fileextension_seq', 90, true);


--
-- Data for Name: group2group; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY group2group (id, parent_id, child_id) FROM stdin;
\.


--
-- Name: group2group_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('group2group_seq', 1, false);


--
-- Data for Name: group2groupcache; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY group2groupcache (id, parent_id, child_id) FROM stdin;
\.


--
-- Name: group2groupcache_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('group2groupcache_seq', 1, false);


--
-- Data for Name: handle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY handle (handle_id, handle, resource_type_id, resource_id) FROM stdin;
\.


--
-- Name: handle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('handle_seq', 1, false);


--
-- Data for Name: harvested_collection; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY harvested_collection (collection_id, harvest_type, oai_source, oai_set_id, harvest_message, metadata_config_id, harvest_status, harvest_start_time, last_harvested, id) FROM stdin;
\.


--
-- Name: harvested_collection_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('harvested_collection_seq', 1, false);


--
-- Data for Name: harvested_item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY harvested_item (item_id, last_harvested, oai_id, id) FROM stdin;
\.


--
-- Name: harvested_item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('harvested_item_seq', 1, false);


--
-- Name: history_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('history_seq', 1, false);


--
-- Name: historystate_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('historystate_seq', 1, false);


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY item (item_id, submitter_id, in_archive, withdrawn, owning_collection, last_modified, discoverable) FROM stdin;
\.


--
-- Data for Name: item2bundle; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY item2bundle (id, item_id, bundle_id) FROM stdin;
\.


--
-- Name: item2bundle_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('item2bundle_seq', 1, false);


--
-- Name: item_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('item_seq', 1, false);


--
-- Data for Name: metadatafieldregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadatafieldregistry (metadata_field_id, metadata_schema_id, element, qualifier, scope_note) FROM stdin;
1	1	contributor	\N	A person, organization, or service responsible for the content of the resource.  Catch-all for unspecified contributors.
2	1	contributor	advisor	Use primarily for thesis advisor.
3	1	contributor	author	\N
4	1	contributor	editor	\N
5	1	contributor	illustrator	\N
6	1	contributor	other	\N
7	1	coverage	spatial	Spatial characteristics of content.
8	1	coverage	temporal	Temporal characteristics of content.
9	1	creator	\N	Do not use; only for harvested metadata.
10	1	date	\N	Use qualified form if possible.
11	1	date	accessioned	Date DSpace takes possession of item.
12	1	date	available	Date or date range item became available to the public.
13	1	date	copyright	Date of copyright.
14	1	date	created	Date of creation or manufacture of intellectual content if different from date.issued.
15	1	date	issued	Date of publication or distribution.
16	1	date	submitted	Recommend for theses/dissertations.
17	1	identifier	\N	Catch-all for unambiguous identifiers not defined by\n    qualified form; use identifier.other for a known identifier common\n    to a local collection instead of unqualified form.
18	1	identifier	citation	Human-readable, standard bibliographic citation \n    of non-DSpace format of this item
19	1	identifier	govdoc	A government document number
20	1	identifier	isbn	International Standard Book Number
21	1	identifier	issn	International Standard Serial Number
22	1	identifier	sici	Serial Item and Contribution Identifier
23	1	identifier	ismn	International Standard Music Number
24	1	identifier	other	A known identifier type common to a local collection.
25	1	identifier	uri	Uniform Resource Identifier
26	1	description	\N	Catch-all for any description not defined by qualifiers.
27	1	description	abstract	Abstract or summary.
28	1	description	provenance	The history of custody of the item since its creation, including any changes successive custodians made to it.
29	1	description	sponsorship	Information about sponsoring agencies, individuals, or\n    contractual arrangements for the item.
30	1	description	statementofresponsibility	To preserve statement of responsibility from MARC records.
31	1	description	tableofcontents	A table of contents for a given item.
32	1	description	uri	Uniform Resource Identifier pointing to description of\n    this item.
33	1	format	\N	Catch-all for any format information not defined by qualifiers.
34	1	format	extent	Size or duration.
35	1	format	medium	Physical medium.
36	1	format	mimetype	Registered MIME type identifiers.
37	1	language	\N	Catch-all for non-ISO forms of the language of the\n    item, accommodating harvested values.
38	1	language	iso	Current ISO standard for language of intellectual content, including country codes (e.g. "en_US").
39	1	publisher	\N	Entity responsible for publication, distribution, or imprint.
40	1	relation	\N	Catch-all for references to other related items.
41	1	relation	isformatof	References additional physical form.
42	1	relation	ispartof	References physically or logically containing item.
43	1	relation	ispartofseries	Series name and number within that series, if available.
44	1	relation	haspart	References physically or logically contained item.
45	1	relation	isversionof	References earlier version.
46	1	relation	hasversion	References later version.
47	1	relation	isbasedon	References source.
48	1	relation	isreferencedby	Pointed to by referenced resource.
49	1	relation	requires	Referenced resource is required to support function,\n    delivery, or coherence of item.
50	1	relation	replaces	References preceeding item.
51	1	relation	isreplacedby	References succeeding item.
52	1	relation	uri	References Uniform Resource Identifier for related item.
53	1	rights	\N	Terms governing use and reproduction.
54	1	rights	uri	References terms governing use and reproduction.
55	1	source	\N	Do not use; only for harvested metadata.
56	1	source	uri	Do not use; only for harvested metadata.
57	1	subject	\N	Uncontrolled index term.
58	1	subject	classification	Catch-all for value from local classification system;\n    global classification systems will receive specific qualifier
59	1	subject	ddc	Dewey Decimal Classification Number
60	1	subject	lcc	Library of Congress Classification Number
61	1	subject	lcsh	Library of Congress Subject Headings
62	1	subject	mesh	MEdical Subject Headings
63	1	subject	other	Local controlled vocabulary; global vocabularies will receive specific qualifier.
64	1	title	\N	Title statement/title proper.
65	1	title	alternative	Varying (or substitute) form of title proper appearing in item,\n    e.g. abbreviation or translation
66	1	type	\N	Nature or genre of content.
67	1	provenance	\N	\N
68	1	rights	license	\N
69	2	abstract	\N	A summary of the resource.
70	2	accessRights	\N	Information about who can access the resource or an indication of its security status. May include information regarding access or restrictions based on privacy, security, or other policies.
71	2	accrualMethod	\N	The method by which items are added to a collection.
72	2	accrualPeriodicity	\N	The frequency with which items are added to a collection.
73	2	accrualPolicy	\N	The policy governing the addition of items to a collection.
74	2	alternative	\N	An alternative name for the resource.
75	2	audience	\N	A class of entity for whom the resource is intended or useful.
76	2	available	\N	Date (often a range) that the resource became or will become available.
77	2	bibliographicCitation	\N	Recommended practice is to include sufficient bibliographic detail to identify the resource as unambiguously as possible.
78	2	conformsTo	\N	An established standard to which the described resource conforms.
79	2	contributor	\N	An entity responsible for making contributions to the resource. Examples of a Contributor include a person, an organization, or a service.
80	2	coverage	\N	The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.
81	2	created	\N	Date of creation of the resource.
82	2	creator	\N	An entity primarily responsible for making the resource.
83	2	date	\N	A point or period of time associated with an event in the lifecycle of the resource.
84	2	dateAccepted	\N	Date of acceptance of the resource.
85	2	dateCopyrighted	\N	Date of copyright.
86	2	dateSubmitted	\N	Date of submission of the resource.
87	2	description	\N	An account of the resource.
88	2	educationLevel	\N	A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.
89	2	extent	\N	The size or duration of the resource.
90	2	format	\N	The file format, physical medium, or dimensions of the resource.
91	2	hasFormat	\N	A related resource that is substantially the same as the pre-existing described resource, but in another format.
92	2	hasPart	\N	A related resource that is included either physically or logically in the described resource.
93	2	hasVersion	\N	A related resource that is a version, edition, or adaptation of the described resource.
94	2	identifier	\N	An unambiguous reference to the resource within a given context.
95	2	instructionalMethod	\N	A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.
96	2	isFormatOf	\N	A related resource that is substantially the same as the described resource, but in another format.
97	2	isPartOf	\N	A related resource in which the described resource is physically or logically included.
98	2	isReferencedBy	\N	A related resource that references, cites, or otherwise points to the described resource.
99	2	isReplacedBy	\N	A related resource that supplants, displaces, or supersedes the described resource.
100	2	isRequiredBy	\N	A related resource that requires the described resource to support its function, delivery, or coherence.
101	2	issued	\N	Date of formal issuance (e.g., publication) of the resource.
102	2	isVersionOf	\N	A related resource of which the described resource is a version, edition, or adaptation.
103	2	language	\N	A language of the resource.
104	2	license	\N	A legal document giving official permission to do something with the resource.
105	2	mediator	\N	An entity that mediates access to the resource and for whom the resource is intended or useful.
106	2	medium	\N	The material or physical carrier of the resource.
107	2	modified	\N	Date on which the resource was changed.
108	2	provenance	\N	A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.
109	2	publisher	\N	An entity responsible for making the resource available.
110	2	references	\N	A related resource that is referenced, cited, or otherwise pointed to by the described resource.
111	2	relation	\N	A related resource.
112	2	replaces	\N	A related resource that is supplanted, displaced, or superseded by the described resource.
113	2	requires	\N	A related resource that is required by the described resource to support its function, delivery, or coherence.
114	2	rights	\N	Information about rights held in and over the resource.
115	2	rightsHolder	\N	A person or organization owning or managing rights over the resource.
116	2	source	\N	A related resource from which the described resource is derived.
117	2	spatial	\N	Spatial characteristics of the resource.
118	2	subject	\N	The topic of the resource.
119	2	tableOfContents	\N	A list of subunits of the resource.
120	2	temporal	\N	Temporal characteristics of the resource.
121	2	title	\N	A name given to the resource.
122	2	type	\N	The nature or genre of the resource.
123	2	valid	\N	Date (often a range) of validity of a resource.
124	3	firstname	\N	Metadata field used for the first name
125	3	lastname	\N	Metadata field used for the last name
126	3	phone	\N	Metadata field used for the phone number
127	3	language	\N	Metadata field used for the language
128	1	date	updated	The last time the item was updated via the SWORD interface
129	1	description	version	The Peer Reviewed status of an item
130	1	identifier	slug	a uri supplied via the sword slug header, as a suggested uri for the item
131	1	language	rfc3066	the rfc3066 form of the language for the item
132	1	rights	holder	The owner of the copyright
\.


--
-- Name: metadatafieldregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadatafieldregistry_seq', 132, true);


--
-- Data for Name: metadataschemaregistry; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadataschemaregistry (metadata_schema_id, namespace, short_id) FROM stdin;
1	http://dublincore.org/documents/dcmi-terms/	dc
2	http://purl.org/dc/terms/	dcterms
3	http://dspace.org/eperson	eperson
\.


--
-- Name: metadataschemaregistry_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadataschemaregistry_seq', 3, true);


--
-- Data for Name: metadatavalue; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY metadatavalue (metadata_value_id, resource_id, metadata_field_id, text_value, text_lang, place, authority, confidence, resource_type_id) FROM stdin;
1	0	64	Anonymous	\N	1	\N	-1	6
2	1	64	Administrator	\N	1	\N	-1	6
3	1	125	biblioteket	\N	1	\N	-1	7
4	1	124	Stats	\N	1	\N	-1	7
5	1	127	en	\N	1	\N	-1	7
\.


--
-- Name: metadatavalue_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('metadatavalue_seq', 5, true);


--
-- Data for Name: most_recent_checksum; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY most_recent_checksum (bitstream_id, to_be_processed, expected_checksum, current_checksum, last_process_start_date, last_process_end_date, checksum_algorithm, matched_prev_checksum, result) FROM stdin;
\.


--
-- Data for Name: registrationdata; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY registrationdata (registrationdata_id, email, token, expires) FROM stdin;
\.


--
-- Name: registrationdata_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('registrationdata_seq', 1, false);


--
-- Data for Name: requestitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY requestitem (requestitem_id, token, item_id, bitstream_id, allfiles, request_email, request_name, request_date, accept_request, decision_date, expires, request_message) FROM stdin;
\.


--
-- Name: requestitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('requestitem_seq', 1, false);


--
-- Data for Name: resourcepolicy; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY resourcepolicy (policy_id, resource_type_id, resource_id, action_id, eperson_id, epersongroup_id, start_date, end_date, rpname, rptype, rpdescription) FROM stdin;
\.


--
-- Name: resourcepolicy_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('resourcepolicy_seq', 1, false);


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY schema_version (version_rank, installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	1	<< Flyway Init >>	INIT	<< Flyway Init >>	\N	dspace	2016-05-12 13:22:23.691918	0	t
2	2	1.1	Initial DSpace 1.1 database schema	SQL	V1.1__Initial_DSpace_1.1_database_schema.sql	864087011	dspace	2016-05-12 13:22:24.028235	346	t
3	3	1.2	Upgrade to DSpace 1.2 schema	SQL	V1.2__Upgrade_to_DSpace_1.2_schema.sql	2027945863	dspace	2016-05-12 13:22:24.416077	54	t
4	4	1.3	Upgrade to DSpace 1.3 schema	SQL	V1.3__Upgrade_to_DSpace_1.3_schema.sql	-575136147	dspace	2016-05-12 13:22:24.482143	48	t
5	5	1.3.9	Drop constraint for DSpace 1 4 schema	JDBC	org.dspace.storage.rdbms.migration.V1_3_9__Drop_constraint_for_DSpace_1_4_schema	-1	dspace	2016-05-12 13:22:24.542267	20	t
6	6	1.4	Upgrade to DSpace 1.4 schema	SQL	V1.4__Upgrade_to_DSpace_1.4_schema.sql	-2094804197	dspace	2016-05-12 13:22:24.578823	111	t
7	7	1.5	Upgrade to DSpace 1.5 schema	SQL	V1.5__Upgrade_to_DSpace_1.5_schema.sql	-353766523	dspace	2016-05-12 13:22:24.700004	108	t
8	8	1.5.9	Drop constraint for DSpace 1 6 schema	JDBC	org.dspace.storage.rdbms.migration.V1_5_9__Drop_constraint_for_DSpace_1_6_schema	-1	dspace	2016-05-12 13:22:24.82939	20	t
9	9	1.6	Upgrade to DSpace 1.6 schema	SQL	V1.6__Upgrade_to_DSpace_1.6_schema.sql	-615013898	dspace	2016-05-12 13:22:24.87271	39	t
10	10	1.7	Upgrade to DSpace 1.7 schema	SQL	V1.7__Upgrade_to_DSpace_1.7_schema.sql	1890535867	dspace	2016-05-12 13:22:24.922639	8	t
11	11	1.8	Upgrade to DSpace 1.8 schema	SQL	V1.8__Upgrade_to_DSpace_1.8_schema.sql	1524534663	dspace	2016-05-12 13:22:24.940408	2	t
12	12	3.0	Upgrade to DSpace 3.x schema	SQL	V3.0__Upgrade_to_DSpace_3.x_schema.sql	1163876269	dspace	2016-05-12 13:22:24.954547	14	t
13	13	4.0	Upgrade to DSpace 4.x schema	SQL	V4.0__Upgrade_to_DSpace_4.x_schema.sql	1058964021	dspace	2016-05-12 13:22:25.290769	21	t
14	14	5.0.2014.08.08	DS-1945 Helpdesk Request a Copy	SQL	V5.0_2014.08.08__DS-1945_Helpdesk_Request_a_Copy.sql	1316176070	dspace	2016-05-12 13:22:25.330805	7	t
15	15	5.0.2014.09.25	DS 1582 Metadata For All Objects drop constraint	JDBC	org.dspace.storage.rdbms.migration.V5_0_2014_09_25__DS_1582_Metadata_For_All_Objects_drop_constraint	-1	dspace	2016-05-12 13:22:25.34756	8	t
16	16	5.0.2014.09.26	DS-1582 Metadata For All Objects	SQL	V5.0_2014.09.26__DS-1582_Metadata_For_All_Objects.sql	-1281275423	dspace	2016-05-12 13:22:25.369476	808	t
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY subscription (subscription_id, eperson_id, collection_id) FROM stdin;
\.


--
-- Name: subscription_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('subscription_seq', 1, false);


--
-- Data for Name: tasklistitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY tasklistitem (tasklist_id, eperson_id, workflow_id) FROM stdin;
\.


--
-- Name: tasklistitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('tasklistitem_seq', 1, false);


--
-- Data for Name: versionhistory; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY versionhistory (versionhistory_id) FROM stdin;
\.


--
-- Name: versionhistory_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('versionhistory_seq', 1, false);


--
-- Data for Name: versionitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY versionitem (versionitem_id, item_id, version_number, eperson_id, version_date, version_summary, versionhistory_id) FROM stdin;
\.


--
-- Name: versionitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('versionitem_seq', 1, false);


--
-- Data for Name: webapp; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY webapp (webapp_id, appname, url, started, isui) FROM stdin;
1	REST	pc621.sb.statsbiblioteket.dk:1234/xmlui	2016-05-12 13:22:36.6	0
2	OAI	pc621.sb.statsbiblioteket.dk:1234/xmlui	2016-05-12 13:22:44.529	0
3	JSPUI	pc621.sb.statsbiblioteket.dk:1234/xmlui	2016-05-12 13:22:51.028	1
4	XMLUI	pc621.sb.statsbiblioteket.dk:1234/xmlui	2016-05-12 13:23:05.146	1
5	RDF	pc621.sb.statsbiblioteket.dk:1234/xmlui	2016-05-12 13:23:14.56	0
\.


--
-- Name: webapp_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('webapp_seq', 5, true);


--
-- Data for Name: workflowitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY workflowitem (workflow_id, item_id, collection_id, state, owner, multiple_titles, published_before, multiple_files) FROM stdin;
\.


--
-- Name: workflowitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('workflowitem_seq', 1, false);


--
-- Data for Name: workspaceitem; Type: TABLE DATA; Schema: public; Owner: dspace
--

COPY workspaceitem (workspace_item_id, item_id, collection_id, multiple_titles, published_before, multiple_files, stage_reached, page_reached) FROM stdin;
\.


--
-- Name: workspaceitem_seq; Type: SEQUENCE SET; Schema: public; Owner: dspace
--

SELECT pg_catalog.setval('workspaceitem_seq', 1, false);


--
-- Name: bitstream_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstream
    ADD CONSTRAINT bitstream_pkey PRIMARY KEY (bitstream_id);


--
-- Name: bitstreamformatregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstreamformatregistry
    ADD CONSTRAINT bitstreamformatregistry_pkey PRIMARY KEY (bitstream_format_id);


--
-- Name: bitstreamformatregistry_short_description_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bitstreamformatregistry
    ADD CONSTRAINT bitstreamformatregistry_short_description_key UNIQUE (short_description);


--
-- Name: bundle2bitstream_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_pkey PRIMARY KEY (id);


--
-- Name: bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY bundle
    ADD CONSTRAINT bundle_pkey PRIMARY KEY (bundle_id);


--
-- Name: checksum_history_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY checksum_history
    ADD CONSTRAINT checksum_history_pkey PRIMARY KEY (check_id);


--
-- Name: checksum_results_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY checksum_results
    ADD CONSTRAINT checksum_results_pkey PRIMARY KEY (result_code);


--
-- Name: collection2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT collection2item_pkey PRIMARY KEY (id);


--
-- Name: collection_item_count_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection_item_count
    ADD CONSTRAINT collection_item_count_pkey PRIMARY KEY (collection_id);


--
-- Name: collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (collection_id);


--
-- Name: communities2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_pkey PRIMARY KEY (id);


--
-- Name: community2collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT community2collection_pkey PRIMARY KEY (id);


--
-- Name: community2community_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT community2community_pkey PRIMARY KEY (id);


--
-- Name: community_item_count_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community_item_count
    ADD CONSTRAINT community_item_count_pkey PRIMARY KEY (community_id);


--
-- Name: community_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_pkey PRIMARY KEY (community_id);


--
-- Name: doi_doi_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY doi
    ADD CONSTRAINT doi_doi_key UNIQUE (doi);


--
-- Name: doi_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY doi
    ADD CONSTRAINT doi_pkey PRIMARY KEY (doi_id);


--
-- Name: eperson_email_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY eperson
    ADD CONSTRAINT eperson_email_key UNIQUE (email);


--
-- Name: eperson_netid_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY eperson
    ADD CONSTRAINT eperson_netid_key UNIQUE (netid);


--
-- Name: eperson_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY eperson
    ADD CONSTRAINT eperson_pkey PRIMARY KEY (eperson_id);


--
-- Name: epersongroup2eperson_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_pkey PRIMARY KEY (id);


--
-- Name: epersongroup2item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2item_pkey PRIMARY KEY (id);


--
-- Name: epersongroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY epersongroup
    ADD CONSTRAINT epersongroup_pkey PRIMARY KEY (eperson_group_id);


--
-- Name: fileextension_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY fileextension
    ADD CONSTRAINT fileextension_pkey PRIMARY KEY (file_extension_id);


--
-- Name: group2group_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_pkey PRIMARY KEY (id);


--
-- Name: group2groupcache_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_pkey PRIMARY KEY (id);


--
-- Name: handle_handle_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY handle
    ADD CONSTRAINT handle_handle_key UNIQUE (handle);


--
-- Name: handle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY handle
    ADD CONSTRAINT handle_pkey PRIMARY KEY (handle_id);


--
-- Name: harvested_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY harvested_collection
    ADD CONSTRAINT harvested_collection_pkey PRIMARY KEY (id);


--
-- Name: harvested_item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY harvested_item
    ADD CONSTRAINT harvested_item_pkey PRIMARY KEY (id);


--
-- Name: item2bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_pkey PRIMARY KEY (id);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (item_id);


--
-- Name: metadatafieldregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadatafieldregistry
    ADD CONSTRAINT metadatafieldregistry_pkey PRIMARY KEY (metadata_field_id);


--
-- Name: metadataschemaregistry_namespace_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadataschemaregistry
    ADD CONSTRAINT metadataschemaregistry_namespace_key UNIQUE (namespace);


--
-- Name: metadataschemaregistry_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadataschemaregistry
    ADD CONSTRAINT metadataschemaregistry_pkey PRIMARY KEY (metadata_schema_id);


--
-- Name: metadatavalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY metadatavalue
    ADD CONSTRAINT metadatavalue_pkey PRIMARY KEY (metadata_value_id);


--
-- Name: most_recent_checksum_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_pkey PRIMARY KEY (bitstream_id);


--
-- Name: registrationdata_email_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY registrationdata
    ADD CONSTRAINT registrationdata_email_key UNIQUE (email);


--
-- Name: registrationdata_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY registrationdata
    ADD CONSTRAINT registrationdata_pkey PRIMARY KEY (registrationdata_id);


--
-- Name: requestitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY requestitem
    ADD CONSTRAINT requestitem_pkey PRIMARY KEY (requestitem_id);


--
-- Name: requestitem_token_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY requestitem
    ADD CONSTRAINT requestitem_token_key UNIQUE (token);


--
-- Name: resourcepolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_pkey PRIMARY KEY (policy_id);


--
-- Name: schema_version_pk; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY schema_version
    ADD CONSTRAINT schema_version_pk PRIMARY KEY (version);


--
-- Name: subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (subscription_id);


--
-- Name: tasklistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_pkey PRIMARY KEY (tasklist_id);


--
-- Name: versionhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY versionhistory
    ADD CONSTRAINT versionhistory_pkey PRIMARY KEY (versionhistory_id);


--
-- Name: versionitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_pkey PRIMARY KEY (versionitem_id);


--
-- Name: webapp_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY webapp
    ADD CONSTRAINT webapp_pkey PRIMARY KEY (webapp_id);


--
-- Name: workflowitem_item_id_key; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_item_id_key UNIQUE (item_id);


--
-- Name: workflowitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_pkey PRIMARY KEY (workflow_id);


--
-- Name: workspaceitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dspace; Tablespace: 
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_pkey PRIMARY KEY (workspace_item_id);


--
-- Name: bit_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bit_bitstream_fk_idx ON bitstream USING btree (bitstream_format_id);


--
-- Name: bundle2bitstream_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle2bitstream_bitstream_fk_idx ON bundle2bitstream USING btree (bitstream_id);


--
-- Name: bundle2bitstream_bundle_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle2bitstream_bundle_idx ON bundle2bitstream USING btree (bundle_id);


--
-- Name: bundle_primary_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX bundle_primary_fk_idx ON bundle USING btree (primary_bitstream_id);


--
-- Name: ch_result_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX ch_result_fk_idx ON checksum_history USING btree (result);


--
-- Name: collection2item_collection_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection2item_collection_idx ON collection2item USING btree (collection_id);


--
-- Name: collection2item_item_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection2item_item_id_idx ON collection2item USING btree (item_id);


--
-- Name: collection_admin_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_admin_fk_idx ON collection USING btree (admin);


--
-- Name: collection_logo_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_logo_fk_idx ON collection USING btree (logo_bitstream_id);


--
-- Name: collection_submitter_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_submitter_fk_idx ON collection USING btree (submitter);


--
-- Name: collection_template_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_template_fk_idx ON collection USING btree (template_item_id);


--
-- Name: collection_workflow1_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow1_fk_idx ON collection USING btree (workflow_step_1);


--
-- Name: collection_workflow2_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow2_fk_idx ON collection USING btree (workflow_step_2);


--
-- Name: collection_workflow3_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX collection_workflow3_fk_idx ON collection USING btree (workflow_step_3);


--
-- Name: com2com_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX com2com_child_fk_idx ON community2community USING btree (child_comm_id);


--
-- Name: com2com_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX com2com_parent_fk_idx ON community2community USING btree (parent_comm_id);


--
-- Name: comm2item_community_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX comm2item_community_fk_idx ON communities2item USING btree (community_id);


--
-- Name: communities2item_item_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX communities2item_item_id_idx ON communities2item USING btree (item_id);


--
-- Name: community2collection_collection_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community2collection_collection_id_idx ON community2collection USING btree (collection_id);


--
-- Name: community2collection_community_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community2collection_community_id_idx ON community2collection USING btree (community_id);


--
-- Name: community_admin_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community_admin_fk_idx ON community USING btree (admin);


--
-- Name: community_logo_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX community_logo_fk_idx ON community USING btree (logo_bitstream_id);


--
-- Name: doi_doi_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX doi_doi_idx ON doi USING btree (doi);


--
-- Name: doi_resource_id_and_type_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX doi_resource_id_and_type_idx ON doi USING btree (resource_id, resource_type_id);


--
-- Name: eperson_email_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX eperson_email_idx ON eperson USING btree (email);


--
-- Name: epersongroup2eperson_group_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epersongroup2eperson_group_idx ON epersongroup2eperson USING btree (eperson_group_id);


--
-- Name: epg2ep_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2ep_eperson_fk_idx ON epersongroup2eperson USING btree (eperson_id);


--
-- Name: epg2wi_group_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2wi_group_fk_idx ON epersongroup2workspaceitem USING btree (eperson_group_id);


--
-- Name: epg2wi_workspace_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX epg2wi_workspace_fk_idx ON epersongroup2workspaceitem USING btree (workspace_item_id);


--
-- Name: fe_bitstream_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX fe_bitstream_fk_idx ON fileextension USING btree (bitstream_format_id);


--
-- Name: g2g_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2g_child_fk_idx ON group2group USING btree (child_id);


--
-- Name: g2g_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2g_parent_fk_idx ON group2group USING btree (parent_id);


--
-- Name: g2gc_child_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2gc_child_fk_idx ON group2group USING btree (child_id);


--
-- Name: g2gc_parent_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX g2gc_parent_fk_idx ON group2group USING btree (parent_id);


--
-- Name: handle_handle_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX handle_handle_idx ON handle USING btree (handle);


--
-- Name: handle_resource_id_and_type_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX handle_resource_id_and_type_idx ON handle USING btree (resource_id, resource_type_id);


--
-- Name: harvested_collection_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX harvested_collection_fk_idx ON harvested_collection USING btree (collection_id);


--
-- Name: harvested_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX harvested_item_fk_idx ON harvested_item USING btree (item_id);


--
-- Name: item2bundle_bundle_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item2bundle_bundle_fk_idx ON item2bundle USING btree (bundle_id);


--
-- Name: item2bundle_item_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item2bundle_item_idx ON item2bundle USING btree (item_id);


--
-- Name: item_submitter_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX item_submitter_fk_idx ON item USING btree (submitter_id);


--
-- Name: metadatafield_schema_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatafield_schema_idx ON metadatafieldregistry USING btree (metadata_schema_id);


--
-- Name: metadatavalue_field_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_field_fk_idx ON metadatavalue USING btree (metadata_field_id);


--
-- Name: metadatavalue_item_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_item_idx ON metadatavalue USING btree (resource_id);


--
-- Name: metadatavalue_item_idx2; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX metadatavalue_item_idx2 ON metadatavalue USING btree (resource_id, metadata_field_id);


--
-- Name: mrc_result_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX mrc_result_fk_idx ON most_recent_checksum USING btree (result);


--
-- Name: resourcepolicy_type_id_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX resourcepolicy_type_id_idx ON resourcepolicy USING btree (resource_type_id, resource_id);


--
-- Name: rp_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX rp_eperson_fk_idx ON resourcepolicy USING btree (eperson_id);


--
-- Name: rp_epersongroup_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX rp_epersongroup_fk_idx ON resourcepolicy USING btree (epersongroup_id);


--
-- Name: schema_version_ir_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX schema_version_ir_idx ON schema_version USING btree (installed_rank);


--
-- Name: schema_version_s_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX schema_version_s_idx ON schema_version USING btree (success);


--
-- Name: schema_version_vr_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX schema_version_vr_idx ON schema_version USING btree (version_rank);


--
-- Name: subs_collection_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX subs_collection_fk_idx ON subscription USING btree (collection_id);


--
-- Name: subs_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX subs_eperson_fk_idx ON subscription USING btree (eperson_id);


--
-- Name: tasklist_eperson_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX tasklist_eperson_fk_idx ON tasklistitem USING btree (eperson_id);


--
-- Name: tasklist_workflow_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX tasklist_workflow_fk_idx ON tasklistitem USING btree (workflow_id);


--
-- Name: workflow_coll_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_coll_fk_idx ON workflowitem USING btree (collection_id);


--
-- Name: workflow_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_item_fk_idx ON workflowitem USING btree (item_id);


--
-- Name: workflow_owner_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workflow_owner_fk_idx ON workflowitem USING btree (owner);


--
-- Name: workspace_coll_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workspace_coll_fk_idx ON workspaceitem USING btree (collection_id);


--
-- Name: workspace_item_fk_idx; Type: INDEX; Schema: public; Owner: dspace; Tablespace: 
--

CREATE INDEX workspace_item_fk_idx ON workspaceitem USING btree (item_id);


--
-- Name: bitstream_bitstream_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bitstream
    ADD CONSTRAINT bitstream_bitstream_format_id_fkey FOREIGN KEY (bitstream_format_id) REFERENCES bitstreamformatregistry(bitstream_format_id);


--
-- Name: bundle2bitstream_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_bitstream_id_fkey FOREIGN KEY (bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: bundle2bitstream_bundle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle2bitstream
    ADD CONSTRAINT bundle2bitstream_bundle_id_fkey FOREIGN KEY (bundle_id) REFERENCES bundle(bundle_id);


--
-- Name: checksum_history_result_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY checksum_history
    ADD CONSTRAINT checksum_history_result_fkey FOREIGN KEY (result) REFERENCES checksum_results(result_code);


--
-- Name: coll2item_item_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT coll2item_item_fk FOREIGN KEY (item_id) REFERENCES item(item_id) DEFERRABLE;


--
-- Name: collection2item_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection2item
    ADD CONSTRAINT collection2item_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: collection_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_admin_fkey FOREIGN KEY (admin) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_item_count_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection_item_count
    ADD CONSTRAINT collection_item_count_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: collection_logo_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_logo_bitstream_id_fkey FOREIGN KEY (logo_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: collection_submitter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_submitter_fkey FOREIGN KEY (submitter) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_template_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_template_item_id_fkey FOREIGN KEY (template_item_id) REFERENCES item(item_id);


--
-- Name: collection_workflow_step_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_1_fkey FOREIGN KEY (workflow_step_1) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_workflow_step_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_2_fkey FOREIGN KEY (workflow_step_2) REFERENCES epersongroup(eperson_group_id);


--
-- Name: collection_workflow_step_3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_workflow_step_3_fkey FOREIGN KEY (workflow_step_3) REFERENCES epersongroup(eperson_group_id);


--
-- Name: com2com_child_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT com2com_child_fk FOREIGN KEY (child_comm_id) REFERENCES community(community_id) DEFERRABLE;


--
-- Name: comm2coll_collection_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT comm2coll_collection_fk FOREIGN KEY (collection_id) REFERENCES collection(collection_id) DEFERRABLE;


--
-- Name: communities2item_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: communities2item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY communities2item
    ADD CONSTRAINT communities2item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: community2collection_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2collection
    ADD CONSTRAINT community2collection_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: community2community_parent_comm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community2community
    ADD CONSTRAINT community2community_parent_comm_id_fkey FOREIGN KEY (parent_comm_id) REFERENCES community(community_id);


--
-- Name: community_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_admin_fkey FOREIGN KEY (admin) REFERENCES epersongroup(eperson_group_id);


--
-- Name: community_item_count_community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community_item_count
    ADD CONSTRAINT community_item_count_community_id_fkey FOREIGN KEY (community_id) REFERENCES community(community_id);


--
-- Name: community_logo_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY community
    ADD CONSTRAINT community_logo_bitstream_id_fkey FOREIGN KEY (logo_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: epersongroup2eperson_eperson_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_eperson_group_id_fkey FOREIGN KEY (eperson_group_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: epersongroup2eperson_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2eperson
    ADD CONSTRAINT epersongroup2eperson_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: epersongroup2workspaceitem_eperson_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2workspaceitem_eperson_group_id_fkey FOREIGN KEY (eperson_group_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: epersongroup2workspaceitem_workspace_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY epersongroup2workspaceitem
    ADD CONSTRAINT epersongroup2workspaceitem_workspace_item_id_fkey FOREIGN KEY (workspace_item_id) REFERENCES workspaceitem(workspace_item_id);


--
-- Name: fileextension_bitstream_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY fileextension
    ADD CONSTRAINT fileextension_bitstream_format_id_fkey FOREIGN KEY (bitstream_format_id) REFERENCES bitstreamformatregistry(bitstream_format_id);


--
-- Name: group2group_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_child_id_fkey FOREIGN KEY (child_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2group_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2group
    ADD CONSTRAINT group2group_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2groupcache_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_child_id_fkey FOREIGN KEY (child_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: group2groupcache_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY group2groupcache
    ADD CONSTRAINT group2groupcache_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: harvested_collection_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY harvested_collection
    ADD CONSTRAINT harvested_collection_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE;


--
-- Name: harvested_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY harvested_item
    ADD CONSTRAINT harvested_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: item2bundle_bundle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_bundle_id_fkey FOREIGN KEY (bundle_id) REFERENCES bundle(bundle_id);


--
-- Name: item2bundle_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item2bundle
    ADD CONSTRAINT item2bundle_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: item_submitter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_submitter_id_fkey FOREIGN KEY (submitter_id) REFERENCES eperson(eperson_id);


--
-- Name: metadatafieldregistry_metadata_schema_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY metadatafieldregistry
    ADD CONSTRAINT metadatafieldregistry_metadata_schema_id_fkey FOREIGN KEY (metadata_schema_id) REFERENCES metadataschemaregistry(metadata_schema_id);


--
-- Name: metadatavalue_metadata_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY metadatavalue
    ADD CONSTRAINT metadatavalue_metadata_field_id_fkey FOREIGN KEY (metadata_field_id) REFERENCES metadatafieldregistry(metadata_field_id);


--
-- Name: most_recent_checksum_bitstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_bitstream_id_fkey FOREIGN KEY (bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: most_recent_checksum_result_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY most_recent_checksum
    ADD CONSTRAINT most_recent_checksum_result_fkey FOREIGN KEY (result) REFERENCES checksum_results(result_code);


--
-- Name: primary_bitstream_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY bundle
    ADD CONSTRAINT primary_bitstream_id_fk FOREIGN KEY (primary_bitstream_id) REFERENCES bitstream(bitstream_id);


--
-- Name: resourcepolicy_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: resourcepolicy_epersongroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY resourcepolicy
    ADD CONSTRAINT resourcepolicy_epersongroup_id_fkey FOREIGN KEY (epersongroup_id) REFERENCES epersongroup(eperson_group_id);


--
-- Name: subscription_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: subscription_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY subscription
    ADD CONSTRAINT subscription_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: tasklistitem_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: tasklistitem_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY tasklistitem
    ADD CONSTRAINT tasklistitem_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES workflowitem(workflow_id);


--
-- Name: versionitem_eperson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_eperson_id_fkey FOREIGN KEY (eperson_id) REFERENCES eperson(eperson_id);


--
-- Name: versionitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: versionitem_versionhistory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY versionitem
    ADD CONSTRAINT versionitem_versionhistory_id_fkey FOREIGN KEY (versionhistory_id) REFERENCES versionhistory(versionhistory_id);


--
-- Name: workflowitem_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: workflowitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: workflowitem_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workflowitem
    ADD CONSTRAINT workflowitem_owner_fkey FOREIGN KEY (owner) REFERENCES eperson(eperson_id);


--
-- Name: workspaceitem_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES collection(collection_id);


--
-- Name: workspaceitem_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dspace
--

ALTER TABLE ONLY workspaceitem
    ADD CONSTRAINT workspaceitem_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

